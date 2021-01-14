package application;

import javafx.beans.property.SimpleStringProperty;

public class Member {
	
	SimpleStringProperty name, address;

	public Member(String name, String address) {
		super();
		this.name = new SimpleStringProperty(name);
		this.address = new SimpleStringProperty(address);
	}

	public String getName() {
		return name.get();
	}

	public void setName(String name) {
		this.name.set(name);;
	}

	public String getAddress() {
		return address.get();
	}

	public void setAddress(String address) {
		this.address.set(address);
	}
	
}
