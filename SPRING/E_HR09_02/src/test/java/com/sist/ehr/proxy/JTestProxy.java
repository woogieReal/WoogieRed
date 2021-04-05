package com.sist.ehr.proxy;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.lang.reflect.Proxy;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.aop.support.NameMatchMethodPointcut;

public class JTestProxy {
	final Logger LOG = Logger.getLogger(JTestProxy.class);
	
	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}
	
	@Test
	public void upperAdviceTest() {
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		
		//포인트 컷
		NameMatchMethodPointcut pointCut = new NameMatchMethodPointcut();
		pointCut.setMappedName("sayH*"); //이름으로 비교조건 설정, sayH로 시작하는 메소드 선택
		
		//Pointcut + Advice = Advisor
		pfBean.addAdvisor(new DefaultPointcutAdvisor(pointCut, new UpperAdvice()));
		
		//proxied된
		Hello proxiedHello = (Hello) pfBean.getObject();
		
		LOG.debug("proxiedHello: "+proxiedHello);
		assertThat(proxiedHello, is(notNullValue()));
		
		LOG.debug(proxiedHello.sayHello("eClass"));
		LOG.debug(proxiedHello.sayHi("eClass"));
		LOG.debug(proxiedHello.sayThankYou("eClass"));
		assertThat(proxiedHello.sayHello("eClass"), is("HELLO ECLASS"));
		assertThat(proxiedHello.sayHi("eClass"), is("HI ECLASS"));
		
		//대상이 아니므로 대문자 처리가 안됨
		//assertThat(proxiedHello.sayThankYou("eClass"), is("THANK YOU ECLASS"));
	}

	@Test
	@Ignore
	public void hello03DynamicProxyFactoryTest() {
		Hello proxiedHello = (Hello) Proxy.newProxyInstance(
				getClass().getClassLoader(), //동적으로 생성되는 다이내믹 프록시 클래스의 로딩
				new Class[] {Hello.class}, //구현할 인터페이스
				new UpperHandler(new HelloTarget()) //부가기능 위임코드를 담은 InvocationHandler
		);
		LOG.debug(proxiedHello.sayHello("eClass"));
		LOG.debug(proxiedHello.sayHi("eClass"));
		LOG.debug(proxiedHello.sayThankYou("eClass"));
		
		assertThat(proxiedHello.sayHello("eClass"), is("HELLO ECLASS"));
		assertThat(proxiedHello.sayHi("eClass"), is("HI ECLASS"));
		assertThat(proxiedHello.sayThankYou("eClass"), is("THANK YOU ECLASS"));
		
	}
	
	
	
	@Test
	@Ignore
	public void hello02Test() {
		//프록시를 통해서 타깃 오브젝트에 접근
		Hello hello = new HelloUppercase(new HelloTarget());
		LOG.debug(hello.sayHello("eClass"));
		assertThat(hello.sayHello("eClass"), is("HELLO ECLASS"));
		assertThat(hello.sayHi("eClass"), is("HI ECLASS"));
		assertThat(hello.sayThankYou("eClass"), is("THANK YOU ECLASS"));
		
	}
	
	@Test
	@Ignore
	public void helloTest() {
		Hello hello = new HelloTarget();
		assertThat(hello.sayHello("eClass"), is("Hello eClass"));
		assertThat(hello.sayHi("eClass"), is("Hi eClass"));
		assertThat(hello.sayThankYou("eClass"), is("Thank You eClass"));
		
	}

}
