package com.sist.ehr.factory;

public class Message {
	String text;
	
	//생성자를 private으로 만들어
	//외부에서 생성자를 통해 오브젝트를 생성할 수 없다.(xml 파일로 주입 못함)
	private Message(String text) {
		this.text = text;
	}

	//getter만
	public String getText() {
		return text;
	}
	
	public static Message newMessage(String text) {
		return new Message(text);
	}
	
}
