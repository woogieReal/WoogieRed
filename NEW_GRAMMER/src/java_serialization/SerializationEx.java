package java_serialization;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

public class SerializationEx {

	/*
	 * 직렬화 
	 * 객체를 데이터 스트림으로 만드는 것
	 * 객체에 저장된 데이터를 스트림에 쓰기(write)위해 연속적인(serial) 데이터로 변환하는 것
	 * ObjectOutputStream
	 */
	public static void main(String[] args) {

		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		ObjectOutputStream out = null;

		String fileName = "UserInfo.ser";

		try {
			fos = new FileOutputStream(fileName);
			bos = new BufferedOutputStream(fos);
			out = new ObjectOutputStream(bos);

			UserInfo user01 = new UserInfo("man", "1234", 25);
			UserInfo user02 = new UserInfo("woman", "1234", 23);

			// 객체직열화
			out.writeObject(user01);
			out.writeObject(user02);

			// 배열을 이용해 다수의 객체직열화
			ArrayList<UserInfo> list = new ArrayList<UserInfo>();
			list.add(user01);
			list.add(user02);
			out.writeObject(list);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (null != out) {
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		System.out.println("직열화 성공");

	}

}
