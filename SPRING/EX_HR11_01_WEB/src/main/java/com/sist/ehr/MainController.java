package com.sist.ehr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	final Logger LOG = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value = "main/main.do")
	public String hello(Model model) {
		LOG.info("==============================");
		LOG.info("=hello=");
		LOG.info("==============================");
		
		String sendData = "Hello, world.";
		model.addAttribute("hello",sendData);
		
//<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
//	<beans:property name="prefix" value="/WEB-INF/views/" />
//	<beans:property name="suffix" value=".jsp" />
//</beans:bean>	
//	     prefix             suffix
//	/WEB-INF/views/main/main.jsp
		
		return "main/main";
	}
	
}
