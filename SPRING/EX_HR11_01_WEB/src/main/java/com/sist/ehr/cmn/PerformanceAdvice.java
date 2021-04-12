package com.sist.ehr.cmn;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;

public class PerformanceAdvice {
	
	final Logger LOG = LoggerFactory.getLogger(PerformanceAdvice.class);
	
	public Object performanceLog(ProceedingJoinPoint pjp) throws Throwable {
		
		Signature signature = pjp.getSignature();
		LOG.debug("signature.getName(): "+signature.getName());
		
		//Before 수행전 시간
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		Object obj = pjp.proceed();
		
		//After 수행후 시간
		stopWatch.stop();
		
		LOG.debug(signature.getName()+"의 수행시간: "+stopWatch.getTotalTimeMillis()+"(ms)초");
		
		return obj;
	}
	
}
