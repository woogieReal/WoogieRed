package connection;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class Read {

//	{
//	    "name":"kim jaeuk",
//	    "age":28,
//		"dog": [
//			"웰시코기",
//			"포메라니안",
//			"푸들",
//			{
//				"ownerName": "홍길동",
//				"phone": "01012345678"
//			}
//		]
//	}
	
	public static void main(String[] args) {

		JSONParser parser = new JSONParser();
		File file = new File("C:\\Users\\123wo\\OneDrive\\문서\\GitHub\\WoogieRed\\JSON_GRAMMER\\json\\TypeArray2.json");
		FileReader fr = null;
		BufferedReader br = null;
		
		try {
			fr = new FileReader(file);
			br = new BufferedReader(fr);
			
			JSONObject jsonObject = (JSONObject) parser.parse(br);
			
			//key값이 "name"인 객체의 value를 get함
			String name = (String)jsonObject.get("name");
			//key값이 "age"인 객체의 value를 get함. 단 value의 타입을 따로 설정하지 않았다면 long
			long age = (long) jsonObject.get("age");
			
			//key값이 "dog"인 객체의 배열을 get함
			JSONArray jsonArr = (JSONArray) jsonObject.get("dog");
			
			System.out.println(name);
			System.out.println(age);
			System.out.println(jsonArr);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(null != br) {
				try {
					br.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		
	}

}
