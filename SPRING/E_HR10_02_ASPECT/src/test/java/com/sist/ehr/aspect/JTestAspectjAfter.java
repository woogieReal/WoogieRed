package com.sist.ehr.aspect;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

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

//메소드 수행 순서:
@FixMethodOrder(MethodSorters.NAME_ASCENDING) // <- 메소드명 a-z 순으로 실행
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임의 JUnit기능 확장
@ContextConfiguration(locations = "/com/sist/ehr/aspect/after/aspectj-after-applicationContext.xml")
public class JTestAspectjAfter {
	final Logger LOG = Logger.getLogger(JTestAspectjAfter.class);
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	Member member;
	
	
	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void beforeAspect() {
		member.doSave();
		member.delete();
		member.doUpdate();
		
//		2021-04-06 14:37:00,055 DEBUG [main] aspect.MemberImpl (MemberImpl.java:10)     - --------------------------
//		2021-04-06 14:37:00,056 DEBUG [main] aspect.MemberImpl (MemberImpl.java:11)     - -doSave()-
//		2021-04-06 14:37:00,056 DEBUG [main] aspect.MemberImpl (MemberImpl.java:12)     - --------------------------
//		2021-04-06 14:37:00,059 DEBUG [main] aspect.LoggingAop (LoggingAop.java:21)     - ***************************
//		2021-04-06 14:37:00,059 DEBUG [main] aspect.LoggingAop (LoggingAop.java:22)     - *methodName*doSave
//		2021-04-06 14:37:00,059 DEBUG [main] aspect.LoggingAop (LoggingAop.java:23)     - ***************************
//		2021-04-06 14:37:00,059 DEBUG [main] aspect.MemberImpl (MemberImpl.java:26)     - --------------------------
//		2021-04-06 14:37:00,059 DEBUG [main] aspect.MemberImpl (MemberImpl.java:27)     - -delete()-
//		2021-04-06 14:37:00,059 DEBUG [main] aspect.MemberImpl (MemberImpl.java:28)     - --------------------------
//		2021-04-06 14:37:00,059 DEBUG [main] aspect.MemberImpl (MemberImpl.java:18)     - --------------------------
//		2021-04-06 14:37:00,060 DEBUG [main] aspect.MemberImpl (MemberImpl.java:19)     - -doUpdate()-
//		2021-04-06 14:37:00,060 DEBUG [main] aspect.MemberImpl (MemberImpl.java:20)     - --------------------------
//		2021-04-06 14:37:00,060 DEBUG [main] aspect.LoggingAop (LoggingAop.java:21)     - ***************************
//		2021-04-06 14:37:00,060 DEBUG [main] aspect.LoggingAop (LoggingAop.java:22)     - *methodName*doUpdate
//		2021-04-06 14:37:00,061 DEBUG [main] aspect.LoggingAop (LoggingAop.java:23)     - ***************************	
	
	}
	
	
	@Test
	public void beans() {
		LOG.debug("context: "+context);
		LOG.debug("member: "+member);
		assertThat(context, is(notNullValue()));
		assertThat(member, is(notNullValue()));
	}

}
