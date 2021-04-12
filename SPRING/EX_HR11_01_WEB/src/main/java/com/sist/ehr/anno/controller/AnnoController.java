package com.sist.ehr.anno.controller;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.ehr.DTO;
import com.sist.ehr.anno.service.AnnoService;

@Controller
public class AnnoController {
	
	final Logger LOG = LoggerFactory.getLogger(AnnoController.class);
	
	@Autowired
	AnnoService service;
	

	/**
	 * 브라우저
	 * http://localhost:8099/ehr/anno/doInsert.do
	 * 
	 * Controller
	 * anno/anno_view.do
	 * 
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "anno/doInsert.do", method = RequestMethod.GET)
	public String doInsert() throws SQLException{
		LOG.debug("====================================");
		LOG.debug("=AnnoController-doInsert()=");
		LOG.debug("====================================");
		///WEB-INF/views/  ++ .jsp
		//WEB-INF/views/anno/anno.jsp
		//		폴더이름/jsp이름
		
		//-------------------------
		//service call
		//-------------------------
		this.service.doInsert(new DTO());
		
		
		return "anno/anno";
	}




}
