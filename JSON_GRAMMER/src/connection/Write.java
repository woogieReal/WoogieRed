package connection;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.json.simple.JSONObject;

public class Write {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {

		File file = new File("C:\\Users\\123wo\\OneDrive\\문서\\GitHub\\WoogieRed\\JSON_GRAMMER\\json\\schedule.json");
		FileWriter fw = null;
		BufferedWriter bw = null;
		
		try {
			// true를 붙히면 파일이 있을 경우 이어쓰기임. 안 붙히거나 false를 붙히면 덮어쓰기임
			fw = new FileWriter(file,true);
			bw = new BufferedWriter(fw);
			
			JSONObject jobj = new JSONObject();
			
			jobj.put("name", "WOOGIE");
			jobj.put("age", 25);
			jobj.put("address", "SEOUL");
			
			bw.write(jobj.toJSONString());
			System.out.println("성공");
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(null != bw) {
				try {
					bw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
