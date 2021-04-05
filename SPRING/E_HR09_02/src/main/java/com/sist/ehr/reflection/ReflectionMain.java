package com.sist.ehr.reflection;

import java.lang.reflect.Method;

import org.apache.log4j.Logger;

public class ReflectionMain {
	final static Logger LOG = Logger.getLogger(ReflectionMain.class);
	public static void main(String[] args) throws Exception {
		//리플렉션은 자바 코드를 추상화 해서 접근
		//모든자바 클래스는 Class 타입의 오브젝트를 하나씩 가지고 있다.
		
		String name = "Spring";
		//1.문자열 길이: length()
		LOG.debug("name.length(): "+name.length());
		
		//인자가 없 메소드 호출
		//2.리플렉션
		Method lengthMethod = String.class.getMethod("length");
		
		//2.1.메소드 call
		int nameLength = (int) lengthMethod.invoke(name);
		LOG.debug("nameLength: "+nameLength);
		
		//----------------------------------------------------------
		
		LOG.debug("name.charAt(0): "+name.charAt(0));
		
		//인자가 있는 메소드 호출
		Method charAtMethod = String.class.getMethod("charAt", int.class);
		Character ch = (Character) charAtMethod.invoke(name, 0);
		LOG.debug("ch: "+ch);
		
		
		
	}

}
