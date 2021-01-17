package connection;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class UpdateSchedule {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {

		String member_id = "user01";
		String schedule_id = "379018";
		
		JSONParser parser = new JSONParser();
		File scheduleJson = new File(".\\jsonFile\\schedule.json");
		FileReader fr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;
		
		try {
			
			fr = new FileReader(scheduleJson);
			br = new BufferedReader(fr);
			
			JSONObject jsonObject = (JSONObject) parser.parse(br);
			
			fw = new FileWriter(scheduleJson);
			bw = new BufferedWriter(fw);	
			
			JSONArray userArr = (JSONArray) jsonObject.get(member_id);
			int num = 0;
			JSONObject jobj;
			
			while(true) {
				jobj = (JSONObject) parser.parse(userArr.get(num).toString());
				if(jobj.containsValue(schedule_id)) {
					jobj.put("schedule_title", "테스트3");
					break;
				}
				num++;
			}

			userArr.remove(num);
			userArr.add(jobj);
			
			bw.write(jsonObject.toJSONString());	
			System.out.println("성공");
			
		} catch(Exception e) {
			System.out.println("registerSchedule: "+ e.getMessage());
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
