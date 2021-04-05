package com.sist.ehr;

public class DTO {
	
	private String uId; //사용자 ID
	private String name; //이름
	private String passwd; //비번
	
	public DTO() {
		
	}

	public DTO(String uId, String name, String passwd) {
		super();
		this.uId = uId;
		this.name = name;
		this.passwd = passwd;
	}

	public String getuId() {
		return uId;
	}

	public void setuId(String uId) {
		this.uId = uId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	@Override
	public String toString() {
		return "DTO [uId=" + uId + ", name=" + name + ", passwd=" + passwd + "]";
	}
	
	
	
}
