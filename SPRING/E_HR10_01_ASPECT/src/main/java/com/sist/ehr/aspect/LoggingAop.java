package com.sist.ehr.aspect;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;

public class LoggingAop {
	final Logger LOG = Logger.getLogger(LoggingAop.class);
	
	/**
	 * JoinPoint: 메소드 param, 메소드 정보
	 * aop:before/after는 param이 JoinPoint
	 * aop:around는 param이 ProceedingJoinPoint
	 * @param joinPoint
	 */
	public void logging(JoinPoint joinPoint) {
		Signature signature = joinPoint.getSignature();
		
		//메소드 이름 리턴
		String methodName = signature.getName();
		
		
		LOG.debug("***************************");
		LOG.debug("*methodName*"+methodName);
		LOG.debug("***************************");
		
	}
	
	
	
}
