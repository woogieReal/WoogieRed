package com.sist.ehr.proxy;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;

public class UpperAdvice implements MethodInterceptor {
	final Logger LOG = Logger.getLogger(this.getClass());
	
	
	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		
		//MethodInvocation은 메소드 정보와 함께 타깃 오브젝트 정보를 알고 있다.
		LOG.debug("invocation.getMethod(): "+invocation.getMethod());
		String ret = (String) invocation.proceed();
		LOG.debug("ret: " + ret);
		
		return ret.toUpperCase();
	}

}
