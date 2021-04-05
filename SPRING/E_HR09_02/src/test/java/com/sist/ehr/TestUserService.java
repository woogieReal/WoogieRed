package com.sist.ehr;
/*
 * UserService .. upgradeLevels(); 해당소스에 트랜잭션 처리는 위험
 * -> UserService 상속받는 TestUserService 만듬
 * -> 특정 ID가 들어오면 예외 발생
 */

import java.sql.SQLException;

import com.sist.ehr.member.service.UserServiceImpl;

public class TestUserService extends UserServiceImpl {

	private String uId;
	
	public TestUserService(String uId) {
		this.uId = uId;
	}
	
	public void upgradeLevel(User user) throws IllegalAccessException, SQLException {
		if(uId.equals(user.getuId())) {
			//사용자 정의 예외 발생! ->TestUserServiceException
			throw new TestUserServiceException("트랜잭션 테스트: "+user.getuId());
		}
		
		super.upgradeLevel(user);
	}
	
	
}
