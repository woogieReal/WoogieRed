package connection;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class MakeMember {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void makeMemberInScheduleTable() {
		
		JSONParser parser = new JSONParser();
		
		//프로젝트 바로 아래에 jsonFile이라는 폴더를 만들어 주세요.
		File file = new File(".\\jsonFile\\schedule.json");
		FileReader fr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;
		
		//같이 보내는 json-simple-1.1.jar를 프로젝트 Build path에서 apply해주세요
		//회원등록한 회원 member_id를 Schedule테이블(json파일)에 등록하는 메소드 입니다.
		//{"member_id": []} 처럼 저장되면 정상작동입니다.
		//회원등록 완료시 실행되도록 해주세요.
		
		try {
			//아래의 member_id는 회원등록할 때 등록한 member_id를 파라미터로 받도록 해주세요.
			String member_id = "위에 주석 봐주세요.";
			
			fr = new FileReader(file);
			br = new BufferedReader(fr);
			
			JSONObject jsonObject = (JSONObject) parser.parse(br);
			
			fw = new FileWriter(file);
			bw = new BufferedWriter(fw);
			
			ArrayList arr = new ArrayList();
			jsonObject.put(member_id, arr);
			bw.write(jsonObject.toJSONString());
			
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


