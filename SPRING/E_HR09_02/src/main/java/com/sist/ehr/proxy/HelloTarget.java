package com.sist.ehr.proxy;

//hello interface를 구현한 타깃 클래스
public class HelloTarget implements Hello {

	@Override
	public String sayHello(String name) {
		return "Hello "+name;
	}

	@Override
	public String sayHi(String name) {
		return "Hi "+name;
	}

	@Override
	public String sayThankYou(String name) {
		return "Thank You "+name;
	}

}
