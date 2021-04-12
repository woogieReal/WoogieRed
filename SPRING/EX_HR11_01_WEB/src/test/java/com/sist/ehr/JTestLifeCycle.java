/**
 * 
 */
package com.sist.ehr;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//메소드 수행 순서:
@FixMethodOrder(MethodSorters.NAME_ASCENDING) // <- 메소드명 a-z 순으로 실행
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임의 JUnit기능 확장
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		
})
public class JTestLifeCycle {
	
	final static Logger LOG = Logger.getLogger(JTestLifeCycle.class);
	
	@Autowired
	ApplicationContext context; // 테스트 오브젝트가 만들어 지고 나면 스프링 테스트 컨텍스트에 의해 자동으로 주입된다. 
								// @RunWith(SpringJUnit4ClassRunner.class), @ContextConfiguration(locations = "/applicationContext.xml")
								// 위의 두 개의 어노테이션이 클래스에 선언되어 있어야함
	
	@Autowired  // <- xml 파일에서 찾는것
	private UserDao dao;
	User user01 = null;
	User user02 = null;
	User user03 = null;
	
	
	
	//성능 테스트
	List<User> users;
	
	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		LOG.debug("=========================");
		LOG.debug("=@Before=");
		LOG.debug("=========================");
		
		LOG.debug("context: "+context);
		
//		사용자 레벨은: BASIC, SILVER, GOLD
//		처음 사용자 레벨은: BASIC
//		가입 후 50회이상 로그인 시: SILVER
//		SILVER 레벨이면서 30번 이상 추천을 받으면: GOLD
//		사용자 레벨의 변경 작업은 일정한 주기를 가지고 일괄처리(트랜잭션 관리)
		user01 = new User("H_126_01","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", "");
		user02 = new User("H_126_02","김재욱","1234",Level.SILVER,51,0,"plagis@daum.net", "");
		user03 = new User("H_126_03","김재욱","1234",Level.GOLD,70,31,"plagis@daum.net", "");
		
		//성능 테스트용
		users = Arrays.asList(
				new User("H_126_01","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_02","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_03","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_04","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_05","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_06","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_07","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_08","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_09","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_10","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_11","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_12","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_13","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_14","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_15","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_16","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_17","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_18","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_19","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", ""),
				new User("H_126_20","김재욱","1234",Level.BASIC,1,0,"plagis@daum.net", "")
				
		);
		
	}
	
	@Test
	@Ignore
	public void testInsert() throws Exception {
		
		int flag = 0;
		for(User vo : users) {
			dao.doInsert(vo);
			flag += 1;
		}
		LOG.debug("총 Insert 건수: "+flag);
		
	}
	
	@Test
	@Ignore
	public void doUpdate() throws SQLException {
		//1. 기존 데이터 삭제
		//2. 신규 데이터 삭제
		//3. 데이터 수정 + update
		//*  비교
		
		//1. 
		dao.doDelete(user01);
		dao.doDelete(user02);
		dao.doDelete(user03);
		
		//2.
		int flag = dao.doInsert(user01);
		assertThat(flag, is(1));
		
		flag += dao.doInsert(user02);
		assertThat(flag, is(2));
		
		//3.
		user01.setLogin(user01.getLogin()+99);
		user01.setName(user01.getName()+"_U");
		user01.setPasswd(user01.getPasswd()+"_U");
		user01.setRecommend(user01.getRecommend()+10);
		user01.setLevel(Level.SILVER);
		LOG.debug("user01: "+user01);

		flag = dao.doUpdate(user01);
		assertThat(flag, is(1));
		
		//3.1. 수정데이터 조회
		User changeUser = (User) dao.doSelectOne(user01);
		checkUser(changeUser, user01);
		
		//3.2. update 하지 않은 데이터 비교
		User unChangeUser = (User) dao.doSelectOne(user02);
		checkUser(unChangeUser, user02);
		
	}
	
	
	@Test
	public void getAll() throws Exception {
		//데이터 3건 삭제
		dao.doDelete(user01);
		dao.doDelete(user02);
		dao.doDelete(user03);
		
		//데이터 추가
		int flag = 0;
		flag += dao.doInsert(user01);
		flag += dao.doInsert(user02);
		flag += dao.doInsert(user03);
		assertThat(flag, is(3));
		
		//데이터 전체 조회
		//검색용
		User user09 = new User();
		user09.setuId("H_126");
		List<User> list = dao.getAll(user09);
		assertThat(list.size(), is(3));
		
	}
	

	
	

	/**
	 * @throws java.lang.Exception
	 */
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		LOG.debug("-------------------------");
		LOG.debug("=@BeforeClass=");
		LOG.debug("-------------------------");
	}

	/**
	 * @throws java.lang.Exception
	 */
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		LOG.debug("-------------------------");
		LOG.debug("=@AfterClass=");
		LOG.debug("-------------------------");
	}


	/**
	 * @throws java.lang.Exception
	 */
	@After
	public void tearDown() throws Exception {
		LOG.debug("=========================");
		LOG.debug("=@After=");
		LOG.debug("=========================");
	}

	@Test(expected = EmptyResultDataAccessException.class) // EmptyResultDataAccessException 오류가 발생하면 성공
	@Ignore
	public void getFailure() throws ClassNotFoundException, SQLException {
		LOG.debug("=========================");
		LOG.debug("=getFailure=");
		LOG.debug("=========================");
		
		//삭제. flag는 없음. 왜냐면 데이터가 없을 수도 있으므로
		dao.doDelete(user01);
		dao.doDelete(user02);
		dao.doDelete(user03);
		
		User user04 = new User();
		user04.setuId("unknown_id");
		//단건조회
		dao.doSelectOne(user04);
		
	}
	
	
	
//	@Test(timeout = 1000) <- 1초 안에 끝나야 함
	@Test
	@Ignore
	public void addAndGet() throws ClassNotFoundException, SQLException {
		LOG.debug("=========================");
		LOG.debug("=addAndGet=");
		LOG.debug("=========================");
		
		//검색용
		User user09 = new User();
		user09.setuId("H_126");
		
		//삭제. flag는 없음. 왜냐면 데이터가 없을 수도 있으므로
		dao.doDelete(user01);
		dao.doDelete(user02);
		dao.doDelete(user03);
		
		//등록
		int flag = dao.doInsert(user01);
		assertThat(flag, is(dao.count(user09))); //flag(actual)과 is(예상)비교
		
		flag += dao.doInsert(user02);
		assertThat(flag, is(dao.count(user09))); //flag(actual)과 is(예상)비교
		
		flag += dao.doInsert(user03);
		assertThat(flag, is(dao.count(user09))); //flag(actual)과 is(예상)비교
		
		//건수
		int count = dao.count(user01);
		assertThat(count, is(1));
		
		//단건조회
		User vsUser01 = (User) dao.doSelectOne(user01);
		User vsUser02 = (User) dao.doSelectOne(user02);
		User vsUser03 = (User) dao.doSelectOne(user03);
		
		//비교
		checkUser(vsUser01, user01);
		checkUser(vsUser02, user02);
		checkUser(vsUser03, user03);
		
		
	}
	
	private void checkUser(User vsUser, User user) {
		
		//비교
		assertThat(vsUser.getuId(), is(user.getuId()));
		assertThat(vsUser.getName(), is(user.getName()));
		assertThat(vsUser.getPasswd(), is(user.getPasswd()));
		assertThat(vsUser.getLevel(), is(user.getLevel()));
		assertThat(vsUser.getLogin(), is(user.getLogin()));
		assertThat(vsUser.getRecommend(), is(user.getRecommend()));
		
	}
	
	@Test
	@Ignore
	public void test02() {
		LOG.debug("=========================");
		LOG.debug("=@Test test02=");
		LOG.debug("=========================");
	}
	

}
