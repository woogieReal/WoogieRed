package com.sist.ehr.factory;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.*;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sist.ehr.JTestUserService;

//메소드 수행 순서:
@FixMethodOrder(MethodSorters.NAME_ASCENDING) // <- 메소드명 a-z 순으로 실행
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임의 JUnit기능 확장
@ContextConfiguration(locations = "/com/sist/ehr/factory/factory-applicationContext.xml")
public class JTestFactoryBean {
	final Logger LOG = Logger.getLogger(JTestUserService.class);
	
	@Autowired
	ApplicationContext context;
	
	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}
	
	@Test
	public void getFactoryBean() {
		Object factory = context.getBean("&messageFactoryBean");
		LOG.debug("factory: "+factory);
		assertThat(factory, is(notNullValue()));
		
		LOG.debug("factory instanceof MessageFactoryBean: "+(factory instanceof MessageFactoryBean));
		if(factory instanceof MessageFactoryBean) {
			assertTrue(true);
		} else {
			assertTrue(false);
		}
		
	}

	@Test
	public void bean() {
		LOG.debug("context: "+context);
		assertThat(this.context, is(notNullValue()));
		
		Message message = (Message) context.getBean("messageFactoryBean");
		LOG.debug("message: "+message);
		assertThat(message, is(notNullValue()));
		LOG.debug("message.getText(): "+message.getText());
		assertThat(message.getText(), is("Factory 빈"));
		
	}

}
