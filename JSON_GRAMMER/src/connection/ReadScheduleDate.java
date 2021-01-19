package register_controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ReadScheduleDate {

	public static void main(String[] args) {

		String member_id = "user04";
		
		JSONParser parser = new JSONParser();
		File scheduleJson = new File(".\\jsonFile\\schedule2.json");
		FileReader fr = null;
		BufferedReader br = null;
		
		try {
			
			fr = new FileReader(scheduleJson);
			br = new BufferedReader(fr);
			
			JSONObject jsonObject = (JSONObject) parser.parse(br);
			
			JSONArray userArr = (JSONArray) jsonObject.get(member_id);
			int num = 0;
			JSONObject jobj;
			
			//기준일 1월 1일
			LocalDate firstDay = LocalDate.of(2021, 01, 01);
			
			//1일부터 365일까지 날짜를 비교
			for(int i = 0; i < 365; i++) {
				
				//기준일 + i, 최종적으로 2021-12-31까지 비교
				LocalDate dateLoc = firstDay.plusDays(i);
				
				//num을 0으로 초기화함으로써 배열의 처음부터 다시 비교하도록 함
				num = 0;
				
				//num이 배열의 길이와 같다면 더이상 비교할 데이터가 없는 것
				while(!(num == userArr.size())) {
					String date = dateLoc.toString();
					jobj = (JSONObject) parser.parse(userArr.get(num).toString());
					
					//각 배열마다 가지고 있는 schedule_date의 값을 firstDay.plusDays(i)값과 비교
					if(jobj.get("schedule_date").equals(date)) {
						
						//같다면 일정제목(schedule_title)을 출력
						System.out.println(date + ": " + jobj.get("schedule_title"));
					} 
					num++;
					
				}//--while
				
			}//--for
			

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
