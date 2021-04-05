package com.sist.ehr.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class UpperHandler implements InvocationHandler {
	//모든 클래스에서 사용가능하도록 일반화
	//Hello -> Object
	Object target;
	
	//다이내믹 프록시로부터 전달받은 요청을 다시 타깃 오브젝트에 위임
	//어떠한 종류의 인터페이스를 구현한 타깃에도 적용가능하도록 Object로 주입
	public UpperHandler(Object target) {
		this.target = target;
	}
	

	/*
	 * sayHello
	 * sayHi		---->invoke로 모임
	 * sayThankYou
	 */
	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		
		Object ret =  method.invoke(target, args);
		System.out.println("method 이름: "+method.getName());
		
		if(ret instanceof String) {
			String tmpRet = (String) ret;
			return tmpRet.toUpperCase();
		} else {
			return ret;
		}
		
		
	}

}
