package com.sist.ehr;

import static com.sist.ehr.member.service.UserServiceImpl.MIN_LOGIN_COUNT_FOR_SILVER;
import static com.sist.ehr.member.service.UserServiceImpl.MIN_RECOMMEND_COUNT_FOR_GOLD;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.mail.MailSender;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;

import com.sist.ehr.member.service.UserService;
import com.sist.ehr.member.service.UserServiceImpl;

//메소드 수행 순서:
@FixMethodOrder(MethodSorters.NAME_ASCENDING) // <- 메소드명 a-z 순으로 실행
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임의 JUnit기능 확장
@ContextConfiguration(locations = "/applicationContext.xml")
public class JTestUserService {
	final Logger LOG = Logger.getLogger(JTestUserService.class);
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	UserServiceImpl userService;
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;

	@Autowired
	@Qualifier("dummyMailSender")
	private MailSender mailSender;
	
	private List<User> users;
	
	
	
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("setUp()");
		users = Arrays.asList(
					new User("H_126_01","김재욱_01","1234",Level.BASIC,  MIN_LOGIN_COUNT_FOR_SILVER-1, 0, "plagis@daum.net", ""),   //BASIC
					new User("H_126_02","김재욱_02","1234",Level.BASIC,  MIN_LOGIN_COUNT_FOR_SILVER, 10, "plagis@daum.net", ""),  //BASIC -> SILVER
					new User("H_126_03","김재욱_03","1234",Level.SILVER, MIN_LOGIN_COUNT_FOR_SILVER+1, MIN_RECOMMEND_COUNT_FOR_GOLD-1, "plagis@daum.net", ""), //SILVER
					new User("H_126_04","김재욱_04","1234",Level.SILVER, MIN_LOGIN_COUNT_FOR_SILVER+1, MIN_RECOMMEND_COUNT_FOR_GOLD, "plagis@daum.net", ""),  //SILVER -> GOLD
					new User("H_126_05","김재욱_05","1234",Level.GOLD,   MIN_LOGIN_COUNT_FOR_SILVER+49, MIN_RECOMMEND_COUNT_FOR_GOLD+1, "plagis@daum.net", "")    //GOLD
				);

	}
	
	@Test
	@Ignore
	public void add() throws SQLException {
		//* Level이 NULL이면 LEVEL을 BISIC 처리
		//1. 기존데이터 삭제
		//2. Level을 NULL + 데이터 등록
		//3, 조회 + 등급 == Level.BASIC
		
		//1. 
		for(User user : users) {
			userDao.doDelete(user);
		}
		
		//2.
		User userWithLevel = users.get(4); //Level.GOLD
		User userWithOutLevel = users.get(0); //Level.BASIC
		userWithOutLevel.setLevel(null);
		
		this.userService.add(userWithLevel);
		this.userService.add(userWithOutLevel);
		
		User userWithLevelRead = (User) userDao.doSelectOne(userWithLevel);
		User userWithOutLevelRead = (User) userDao.doSelectOne(userWithOutLevel);
		
		//Level.GOLD == Level.GOLD
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		
		//레벨을 Null처리 했던 것
		assertThat(userWithOutLevelRead.getLevel(), is(Level.BASIC));
		
	}
	
	//Users를 대상으로 등업
	@Test
	@Ignore
	public void upgradeLevels() throws SQLException, IllegalAccessException {
		//1. 데이터 삭제
		//2. 데이터 입력
		
		//1.
		for(User user : users) {
			userDao.doDelete(user);
		}
		
		//2.
		int flag = 0;
		for(User user : users) {
			flag += userDao.doInsert(user);
		}
		assertThat(flag, is(5));
		
		//등업
		this.userService.upgradeLevels();
		
		//등업 로직 체크
		checkLevel(users.get(0), Level.BASIC);
		checkLevel(users.get(1), Level.SILVER);
		checkLevel(users.get(2), Level.SILVER);
		checkLevel(users.get(3), Level.GOLD);
		checkLevel(users.get(4), Level.GOLD);
		
	}
	
	/**
	 * 등업한 Level과 예상 Level을 비교
	 * @param user
	 * @param expected
	 * @throws SQLException
	 */
	private void checkLevel(User user, Level expected) throws SQLException {
		User userUpLevel = (User) this.userDao.doSelectOne(user);
		assertThat(userUpLevel.getLevel(), is(expected));
	}
	

	@After
	public void tearDown() throws Exception {
		LOG.debug("tearDown()");
	}

	@Test
	@Ignore
	public void bean() {
		LOG.debug("context: "+context);
		LOG.debug("userService: "+userService);
		LOG.debug("userDao: "+userDao);
		LOG.debug("dataSource: "+dataSource);
		LOG.debug("transactionManager"+transactionManager);
		assertThat(this.context, is(notNullValue()));
		assertThat(this.userService, is(notNullValue()));
		assertThat(this.userDao, is(notNullValue()));
		assertThat(this.dataSource, is(notNullValue()));
		assertThat(this.transactionManager, is(notNullValue()));
		
	}
	
	
	//Transaction 테스트
	@Test
	public void upgradeAllOrNothing() throws Exception {
		
		//UserService의 대역
		//UserService -> UserServiceImpl -> TestUserService
		//일부러 오류를 나게해 트랜잭션을 처리를 보기 위한 클래스임
		TestUserService txTestUserService = new TestUserService(users.get(3).getuId());
//		TestUserService txTestUserService = new TestUserService("H126");
		
		//TestUserService 에는 mailSender와 userDao 변수가 없지만,
		//UserServiceImpl을 상속하고 있기 때문에 setter를 써서 주입할 수 있다.
		txTestUserService.setMailSender(mailSender);
		txTestUserService.setUserDao(userDao);
		
		ProxyFactoryBean proxyFactoryBean = this.context.getBean("&proxyFactoryBean", ProxyFactoryBean.class);
		proxyFactoryBean.setTarget(txTestUserService);
		
		LOG.debug("proxyFactoryBean: "+proxyFactoryBean);
		assertThat(proxyFactoryBean, is(notNullValue()));
		
		UserService txUserService = (UserService) proxyFactoryBean.getObject();
		LOG.debug("txUserService: "+txUserService);
		assertThat(txUserService, is(notNullValue()));
		
		//1. 데이터 삭제
		//2. 데이터 입력
		//3. 등업
		
		//1.
		for(User user : users) {
			userDao.doDelete(user);
		}
		
		//2.
		int flag = 0;
		for(User user : users) {
			flag += userDao.doInsert(user);
		}
		
		assertThat(flag, is(5));
		
		try {
			txUserService.upgradeLevels();
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch(RuntimeException e) {
			LOG.debug("================================");
			LOG.debug("=RuntimeException="+e.getMessage());
			LOG.debug("================================");
		}
		
		checkLevel(users.get(1),Level.BASIC); // 수정사항 -> Transaction 처리되면 rollback 되게함
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
