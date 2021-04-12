package com.sist.ehr.anno;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sist.ehr.DTO;
import com.sist.ehr.anno.service.AnnoService;

@FixMethodOrder(MethodSorters.NAME_ASCENDING) // <- 메소드명 a-z 순으로 실행
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임의 JUnit기능 확장
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"		
})
public class JTestAnnoService {
	
	final Logger LOG = LoggerFactory.getLogger(JTestAnnoService.class);

	@Autowired
	private AnnoService service;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("setUp()");
	}

	@After
	public void tearDown() throws Exception {
		LOG.debug("tearDown()");
	}

	@Test
	public void callService() throws SQLException {
		this.service.doInsert(new DTO());
	}
	
	
	@Test
	public void beans() {
		LOG.debug("service: "+service);
		assertThat(this.service, is(notNullValue()));
	}

}
