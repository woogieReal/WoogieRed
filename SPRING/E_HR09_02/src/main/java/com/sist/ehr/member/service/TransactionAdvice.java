package com.sist.ehr.member.service;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionAdvice implements MethodInterceptor {
	final Logger LOG = Logger.getLogger(this.getClass());
	PlatformTransactionManager transactionManager;  //글로벌 트랜잭션
	
	public TransactionAdvice() {}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		//transaction 선언
		//>>>>분리된 비니니스 로직 call
		//commit
		//rollback
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		Object ret = null;
		try {
//			----분리된 비지니스 로직
//			MethodInvocation은 일종의 콜백 오브젝트로, proceed() 메소드를 실행하면 타깃 오브젝트의 메소드를 내부적으로 실행해주는 기능이 있다.
			ret = invocation.proceed();
//			----//분리된 비지니스 로직
			
			transactionManager.commit(status);
			LOG.debug("commit 성공");
			
		} catch(Exception e) {
			//rollback
			LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			LOG.debug(">Rollback>");
			LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			transactionManager.rollback(status);
			throw e;
		}
		
		return ret;
	}

}
