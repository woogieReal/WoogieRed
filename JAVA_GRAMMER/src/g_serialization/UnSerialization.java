package g_serialization;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;

public class UnSerialization {

	/*
	 * 역직렬화
	 * 직열렬된 객체를 읽어들이는것
	 * ObjectInputStream
	 */
	@SuppressWarnings("unchecked")
	public static void main(String[] args) {

		FileInputStream fis = null;
		BufferedInputStream bis = null;
		ObjectInputStream in = null;
		
		String fileName = "UserInfo.ser";
		try {
			fis = new FileInputStream(fileName);
			bis = new BufferedInputStream(fis);
			in = new ObjectInputStream(bis);
			
			//객체 역직렬화
			UserInfo user01 = (UserInfo) in.readObject();
			UserInfo user02 = (UserInfo) in.readObject();
			ArrayList<UserInfo> list = (ArrayList<UserInfo>) in.readObject();
			
			System.out.println(user01.toString());
			System.out.println(user02.toString());
			System.out.println(list.toString());
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (null != in) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

}
