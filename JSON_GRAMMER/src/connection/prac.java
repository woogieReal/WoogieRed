package connection;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class prac {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void main(String[] args) {

		JSONParser parser = new JSONParser();
		File file = new File("C:\\Users\\123wo\\OneDrive\\문서\\GitHub\\WoogieRed\\JSON_GRAMMER\\json\\schedule.json");
		FileReader fr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;
		
		try {
			fr = new FileReader(file);
			br = new BufferedReader(fr);
			
			JSONObject jsonObject = (JSONObject) parser.parse(br);
			JSONArray user01 = (JSONArray) jsonObject.get("user01");
			
			for(int i = 0; i < user01.size(); i++) {
				System.out.println(user01.get(i));
				JSONObject jsonTmp = (JSONObject) parser.parse(user01.get(i).toString());
				System.out.println(jsonTmp.get("schedule_id"));
			}
			
			fw = new FileWriter(file);
			bw = new BufferedWriter(fw);
			
			HashMap hm = new HashMap();
			hm.put("schedule_id", "789");
			hm.put("text_size", "5");
			user01.add(hm);
			
			bw.write(jsonObject.toJSONString());
			
			
//			String tmp = user01.toJSONString();
//			String jsonstr = tmp.substring(1, tmp.length()-1);
//			System.out.println(jsonstr);
//			JSONObject json = (JSONObject) parser.parse(jsonstr);
//			System.out.println(json.get("schedule_id"));
			
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
			if(null != bw) {
				try {
					bw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}//--finally
		
	}

}
