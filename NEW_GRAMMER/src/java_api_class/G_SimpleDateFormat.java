package java_api_class;

import java.text.SimpleDateFormat;
import java.util.Date;

public class G_SimpleDateFormat {

	public static void main(String[] args) {

		Date today = new Date();
		System.out.println(today);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		System.out.println(sdf.format(today));
		
		sdf = new SimpleDateFormat("yy년 MM월 dd일 E요일");
		System.out.println(sdf.format(today));
		
		//년
		sdf = new SimpleDateFormat("오늘은 올해의 D번째 날입니다.");
		System.out.println(sdf.format(today));

		//달
		sdf = new SimpleDateFormat("오늘은이달의 d번째 날입니다.");
		System.out.println(sdf.format(today));
		
		//년기준 주
		sdf = new SimpleDateFormat("오늘은 올해의 w번째 주입니다.");
		System.out.println(sdf.format(today));		
		
		//월기준 주
		sdf = new SimpleDateFormat("오늘은 이달의 W번째 주입니다.");
		System.out.println(sdf.format(today));		
	}

}
