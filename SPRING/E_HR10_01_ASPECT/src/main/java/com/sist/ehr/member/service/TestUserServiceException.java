package com.sist.ehr.member.service;

import org.apache.log4j.Logger;

public class TestUserServiceException extends RuntimeException {

	final Logger LOG = Logger.getLogger(TestUserServiceException.class);
	
	public TestUserServiceException() {}
	
	public TestUserServiceException(String msg) {
		super(msg);
		LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		LOG.debug(">TestUserServiceException>"+msg);
		LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	}
	
}
