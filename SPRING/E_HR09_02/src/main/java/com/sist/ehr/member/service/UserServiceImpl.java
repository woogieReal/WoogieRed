package com.sist.ehr.member.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

import com.sist.ehr.DTO;
import com.sist.ehr.Level;
import com.sist.ehr.User;
import com.sist.ehr.UserDao;

public class UserServiceImpl implements UserService {
	
	final Logger LOG = Logger.getLogger(UserServiceImpl.class);
	
	public final static int MIN_LOGIN_COUNT_FOR_SILVER = 50;   //실버가 되기 위한 최소 로그인 횟수
	public final static int MIN_RECOMMEND_COUNT_FOR_GOLD = 30; //골드가 되기 위한 최소 추천 횟수
	
	private UserDao userDao;

	private MailSender mailSender;
	
	
//	기본 생성자
	public UserServiceImpl() {}

//	setter를 통한 DI
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
	

	
	

	/**
	 * 최초 회원가입시 등급: BASIC
	 * Level이 NULL이면 BASIC 처리
	 * @param dto
	 * @return
	 * @throws SQLException
	 */
	@Override
	public int add(DTO dto) throws SQLException {
		int flag = 0;
		User user = (User) dto;
		if(null == user.getLevel()) {
			user.setLevel(Level.BASIC);
		}
		
		flag = this.userDao.doInsert(user);
		
		return flag;
	}
	
	
	
	//	회원 데이터를 모두 조회한다
	//	회원 데이터를 1건 조회 후, 등업 대상인지 확인 한다.
	//	등업대상이면 해당 레벨로 등업 한다.
		
	//	사용자 레벨은: BASIC, SILVER, GOLD
	//	처음 사용자 레벨은: BASIC
	//	가입 후 50회이상 로그인 시: SILVER
	//	SILVER 레벨이면서 30번 이상 추천을 받으면: GOLD
	//	사용자 레벨의 변경 작업은 일정한 주기를 가지고 일괄처리(트랜잭션 관리)
	
	@Override
	public void upgradeLevels() throws SQLException, IllegalAccessException {

		User userSearch = new User();
		userSearch.setuId("H_126");
		List<User> users = userDao.getAll(userSearch);
		
		for(User user : users) {
			//1. upgrade 대상 선정
			if(canUpgradeLevel(user) ==true) {
				upgradeLevel(user);
			}
		}//--for
	}
	
	//등업 처리
	protected void upgradeLevel(User user) throws SQLException, IllegalAccessException {
		
		//레벨을 다음 레벨로 set하는 함수
		user.upgradeLevel();
		
//	--User.java ==========================================================
//		public void upgradeLevel() throws IllegalAccessException {
//			Level nextLevel = this.level.getNextLevel();
//			if(null == nextLevel) {
//				throw new IllegalAccessException(level+"은 업그레이드가 불가능 합니다.");
//			} else {
//				this.level = nextLevel;
//			}
//		}
//		===========================================================
		
		this.userDao.doUpdate(user);
		
		//email 전송
		sendUpgradeEmail(user);
		
	}
	
	//email 전송
	private void sendUpgradeEmail(User user) {
		
		/*
		POP 서버명 : pop.naver.com 
		SMTP서버명 : smtp.naver.com 
		POP포트 : 995, 보안연결(SSL) 필요
		SMTP 포트 : 465, 보안 연결(SSL)필요 
		아이디 : 123wodnr
		비밀번호 : 네이버 로그인 비밀번호
		*/
		
		String from = "123wodnr@naver.com";
		String title = user.getName()+"님 등업(https://cafe.naver.com/kndjang)";
		String contents = user.getuId()+"님 등급이 <br/>"+user.getLevel().name()+"로 등업 되었습니다.";
		String recAddr = user.getEmail();
		SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
		
		simpleMailMessage.setFrom(from);
		simpleMailMessage.setTo(recAddr);
		simpleMailMessage.setSubject(title);
		//simpleMailMessage.setSentDate(new Date());
		simpleMailMessage.setText(contents);
		
		mailSender.send(simpleMailMessage);
		
	}
	
	
	
	//등업 대상인지 
	private boolean canUpgradeLevel(User user) throws IllegalAccessException {
		Level currLevel = user.getLevel();
		
		switch(currLevel) {
			//case 문에서 ENUM클래스를 쓸 때는 ENUM클래스명을 생략한다.
			//레벨별로 구분해서 조건판단
			case BASIC: return (user.getLogin() >= MIN_LOGIN_COUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECOMMEND_COUNT_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalAccessException("unknown Level");
		}
		
	}
	
	
}
