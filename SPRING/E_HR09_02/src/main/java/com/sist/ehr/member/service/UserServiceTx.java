package com.sist.ehr.member.service;

import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.sist.ehr.DTO;

public class UserServiceTx implements UserService {
	final Logger LOG = Logger.getLogger(UserServiceTx.class);
	UserService userService;
	private PlatformTransactionManager transactionManager;  //글로벌 트랜잭션
	
	public UserServiceTx() {}
	
//	--setter를 통한 DI
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setTransactionManager(PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
//	//--setter를 통한 DI

	@Override
	public int add(DTO dto) throws SQLException {
		return userService.add(dto);
	}

	@Override
	public void upgradeLevels() throws SQLException, IllegalAccessException {
		//글로벌 트랜잭션 방식을 사용
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			userService.upgradeLevels();
			transactionManager.commit(status);
		} catch(RuntimeException e) {
			LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			LOG.debug(">Rollback>");
			LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			transactionManager.rollback(status);
			throw e;
		}
		
	}

}
