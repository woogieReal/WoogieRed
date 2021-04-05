package com.sist.ehr.member.service;

import org.apache.log4j.Logger;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

public class DummyMailSender implements MailSender {
	final Logger LOG = Logger.getLogger(DummyMailSender.class);
	
	@Override
	public void send(SimpleMailMessage simpleMessage) throws MailException {
		LOG.debug("***********************");
		LOG.debug("개발용 email 입니다.");
		LOG.debug("mail은 전송되지 않습니다.");
		LOG.debug("***********************");
		
	}

	@Override
	public void send(SimpleMailMessage... simpleMessages) throws MailException {
		LOG.debug("***********************");
		LOG.debug("개발용 email 입니다.");
		LOG.debug("mail은 전송되지 않습니다.");
		LOG.debug("***********************");

	}

}
