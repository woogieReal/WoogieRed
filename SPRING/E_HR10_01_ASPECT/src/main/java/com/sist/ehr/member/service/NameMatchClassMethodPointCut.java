package com.sist.ehr.member.service;

import org.apache.log4j.Logger;
import org.springframework.aop.ClassFilter;
import org.springframework.aop.support.NameMatchMethodPointcut;
import org.springframework.util.PatternMatchUtils;

public class NameMatchClassMethodPointCut extends NameMatchMethodPointcut {
	final static Logger LOG = Logger.getLogger(NameMatchClassMethodPointCut.class);
	
	//setter를 통한 클래스 필터 조건 전달
	public void setMappedClassName(String mappedClassName) {
		this.setClassFilter(new simpleClassFilter(mappedClassName));
	}
	
	//class 필터링
	static class simpleClassFilter implements ClassFilter{

		String mappedName;
		
		public simpleClassFilter(String mappedName) {
			super();
			this.mappedName = mappedName;
		}



		@Override
		public boolean matches(Class<?> clazz) {
			//와일드카드(*)가 들어간 문자열 비교를 지원하는 스프링 유틸리티
			//ex) *name, name*, *name*
			
			boolean flag = false;
			flag = PatternMatchUtils.simpleMatch(mappedName, clazz.getSimpleName());
			LOG.debug("mappedName: "+mappedName);
			LOG.debug("clazz.getSimpleName(): "+clazz.getSimpleName());
			LOG.debug("flag: "+flag);
			
			return flag;
		}
		
	}
	
	
}
