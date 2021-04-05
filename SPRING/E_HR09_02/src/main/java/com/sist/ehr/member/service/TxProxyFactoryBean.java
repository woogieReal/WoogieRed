package com.sist.ehr.member.service;

import java.lang.reflect.Proxy;
 
import org.apache.log4j.Logger;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.transaction.PlatformTransactionManager;

public class TxProxyFactoryBean implements FactoryBean<Object> {
	final Logger LOG = Logger.getLogger(this.getClass());
	
	//모든 클래스에서 사용가능하도록 일반화
	Object target;
	PlatformTransactionManager transactionManager;  //글로벌 트랜잭션
	String pattern;//트랜잭션을 적용할 메소드 이름 패턴
	
	//다이내믹 프록시를 생성할 때 필요
	//UserService 이외의 인터페이스를 가진 타깃에도 적용가능
	Class<?> serviceInterface;

//	--setter를 통한 DI
	public void setServiceInterface(Class<?> serviceInterface) {
		this.serviceInterface = serviceInterface;
	}
	
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


	/*
	 * DI 받은 정보를 통해서 TransactionHandler를 사용하는 다이내믹 프록시를 돌려 준다.
	 */
	@Override
	public Object getObject() throws Exception {
		TransactionHandler txHandler = new TransactionHandler();
		txHandler.setTarget(target);
		txHandler.setTransactionManager(transactionManager);
		txHandler.setPattern(pattern);
		
		return Proxy.newProxyInstance(
				getClass().getClassLoader(), 
				new Class[] {serviceInterface}, 
				txHandler
		);
	}

	//팩토리 빈이 생성하는 오브젝트의 타입은 DI받은 인터페이스 타입에 따라 달라진다.
	//따라서 다양한 타입의 프록시 오브젝트 생성에 재사용 할 수 있다.
	@Override
	public Class<?> getObjectType() {
		return serviceInterface;
	}

	@Override
	public boolean isSingleton() {
		return false;
	}
	
	
	
}
