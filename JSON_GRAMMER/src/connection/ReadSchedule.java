package connection;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ReadSchedule {

	public static void main(String[] args) {

		String member_id = "user01";
		String schedule_id = "379018";
		
		JSONParser parser = new JSONParser();
		File scheduleJson = new File(".\\jsonFile\\schedule.json");
		FileReader fr = null;
		BufferedReader br = null;
		
		try {
			
			fr = new FileReader(scheduleJson);
			br = new BufferedReader(fr);
			
			JSONObject jsonObject = (JSONObject) parser.parse(br);
			
			JSONArray userArr = (JSONArray) jsonObject.get(member_id);
			int num = 0;
			JSONObject jobj;
			
			while(true) {
				jobj = (JSONObject) parser.parse(userArr.get(num).toString());
				if(jobj.containsValue(schedule_id)) {
					break;
				}
				num++;
			}

			
			System.out.println(jobj.get("member_id"));
			System.out.println(jobj.get("lunar_date"));
			System.out.println(jobj.get("repeat_type"));
			System.out.println(jobj.get("alarm_time"));
			System.out.println(jobj.get("schedule_place"));
			System.out.println(jobj.get("schedule_alarm"));
			System.out.println(jobj.get("register_date"));
			System.out.println(jobj.get("schedule_date"));
			System.out.println(jobj.get("sticker_img"));
			System.out.println(jobj.get("text_size"));
			System.out.println(jobj.get("schedule_time"));
			System.out.println(jobj.get("repeat_check"));
			System.out.println(jobj.get("schedule_id"));
			System.out.println(jobj.get("schedule_title"));
			
			
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

		}//--finally
		
	}

}
