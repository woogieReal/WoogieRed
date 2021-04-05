package com.sist.ehr.member.service;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

import org.apache.log4j.Logger;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionHandler implements InvocationHandler {
	final Logger LOG = Logger.getLogger(TransactionHandler.class);
	//모든 클래스에서 사용가능하도록 일반화
	Object target;
	PlatformTransactionManager transactionManager;  //글로벌 트랜잭션
	String pattern;//트랜잭션을 적용할 메소드 이름 패턴
	
	public TransactionHandler() {
		
	}
	
//	--setter를 통한 DI
	public void setTarget(Object target) {
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern) {
		this.pattern = pattern;
	}
//	--//setter를 통한 DI	
	
	//트랜잭션 처리
	public Object invokeInTransaction(Method method, Object[] args) throws Throwable {
		//트랜잭션 선언
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			Object ret =  method.invoke(target, args);
			
			//commit
			transactionManager.commit(status);
			return ret;
		} catch(Exception e) {
			//rollback
			LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			LOG.debug(">Rollback>");
			LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			transactionManager.rollback(status);
			throw e;
		}
		
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		//메소드 이름을 뽑아냄
		//해당 메소드만 트랜잭션 처리해서 리턴 <- 포인트컷
		if(method.getName().startsWith(pattern)) {
			LOG.debug("=tx method.getName()="+method.getName());
			return invokeInTransaction(method, args);
		} else {
			//해당되는 메소드가 아니면 트랜잭션 없이 리턴함
			return method.invoke(target, args);
		}
		
	}

}
