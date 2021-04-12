package com.sist.ehr;

public class User extends DTO{
	
	
	private String uId; //사용자 ID
	private String name; //이름
	private String passwd; //비번
	
	private Level level; 
	private int login; 
	private int recommend;
	
	private String email;
	private String regDt;
	

	public User() {
		
	}

	public User(String uId, String name, String passwd, Level level, int login, int recommend, String email,
			String regDt) {
		super();
		this.uId = uId;
		this.name = name;
		this.passwd = passwd;
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.email = email;
		this.regDt = regDt;
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

	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	
	@Override
	public String toString() {
		return "User [uId=" + uId + ", name=" + name + ", passwd=" + passwd + ", level=" + level + ", login=" + login
				+ ", recommend=" + recommend + ", email=" + email + ", regDt=" + regDt + ", toString()="
				+ super.toString() + "]";
	}

	public void upgradeLevel() throws IllegalAccessException {
		Level nextLevel = this.level.getNextLevel();
		if(null == nextLevel) {
			throw new IllegalAccessException(level+"은 업그레이드가 불가능 합니다.");
		} else {
			this.level = nextLevel;
		}
	}
	
	

}
