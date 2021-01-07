package g_serialization;

import java.io.Serializable;

/*
 * 직렬화 하고자 하는 클래스는 Serializable 인터페이스를 implements 한다.
 */
public class UserInfo implements Serializable {

	/**
	 * UserInfo의 고유값.
	 * client <-> Server
	 */
	private static final long serialVersionUID = -4317317462791192390L;

	String name;
	String password;
	int age;
	
	public UserInfo() {
		this("Unknown","1111",0);
	}
	
	public UserInfo(String name, String password, int age) {
		super();
		this.name = name;
		this.password = password;
		this.age = age;
	}

	@Override
	public String toString() {
		return "UserInfo [name=" + name + ", password=" + password + ", age=" + age + "]";
	}
	
	
	
}
