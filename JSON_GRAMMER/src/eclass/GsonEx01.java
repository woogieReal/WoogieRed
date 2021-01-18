package eclass;

import com.google.gson.Gson;

public class GsonEx01 {

	String name, age, address;
	
	public GsonEx01(String name, String age, String address) {
		super();
		this.name = name;
		this.age = age;
		this.address = address;
	}
	
	public static void main(String[] args) {

		GsonEx01 obj = new GsonEx01("woogie","28","incheon");
		Gson gson = new Gson();
		String str = gson.toJson(obj);
		System.out.println(str);
	}

}
