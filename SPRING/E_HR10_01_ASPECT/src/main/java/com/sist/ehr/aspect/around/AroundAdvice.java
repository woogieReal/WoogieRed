package com.sist.ehr.aspect.around;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;

/**
 * 클라이언트 메소드 호출을 가로챈다.
 * 클라이언트가 호출한 비지니스 메소드가 실행되기 전/후
 * @author 123wo
 *
 */
public class AroundAdvice {
	final Logger LOG = Logger.getLogger(AroundAdvice.class);
	
	public Object aroundLog(ProceedingJoinPoint pjp) throws Throwable {
		LOG.debug("Before: 메소드 수행 전");
		
		//메소드 이름
		Signature signature = pjp.getSignature();
		LOG.debug("signature.getName(): "+signature.getName());
		
		//param
		Object[] args = pjp.getArgs();
		for(Object obj : args) {
			LOG.debug("obj: "+obj);
		}
		
		Object obj = pjp.proceed();
		
		LOG.debug("After: 메소드 수행 후");
		return obj;
	}
	
	
}
