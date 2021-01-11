package connection;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.json.simple.JSONObject;

public class Write {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {

		File file = new File("C:\\Users\\123wo\\OneDrive\\문서\\GitHub\\WoogieRed\\JSON_GRAMMER\\json\\Test2.json");
		FileWriter fr = null;
		BufferedWriter br = null;
		
		try {
			// true를 붙히면 파일이 있을 경우 이어쓰기임. 안 붙히거나 false를 붙히면 덮어쓰기임
			fr = new FileWriter(file,true);
			br = new BufferedWriter(fr);
			
			JSONObject jobj = new JSONObject();
			
			jobj.put("name", "KIM JAEUK");
			jobj.put("age", 28);
			jobj.put("address", "INCHEON");
			
			br.write(jobj.toJSONString());
			System.out.println("성공");
			
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
