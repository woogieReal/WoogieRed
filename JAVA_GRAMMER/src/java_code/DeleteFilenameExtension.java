package java_code;

public class DeleteFilenameExtension {

	public static void main(String[] args) {

		//StringBuffer 클래스의 문자열로 생성
		//indexOf로 확장자의 시작위치를 특정
		//삭제 범위는 indexOf()부터 length()까지
		
		StringBuffer str1 = new StringBuffer("today.txt");
		StringBuffer str2 = new StringBuffer("yesterday.doc");
		StringBuffer str3 = new StringBuffer("tomorrow.ppt");
		
		str1.delete(str1.indexOf("."), str1.length());
		str2.delete(str2.indexOf("."), str2.length());
		str3.delete(str3.indexOf("."), str3.length());
		
		System.out.println(str1);
		System.out.println(str2);
		System.out.println(str3);
		
	}

}
