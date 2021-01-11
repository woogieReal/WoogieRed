package java_api_class;

import java.util.Calendar;
import java.util.Date;

public class G_Callendar {

	@SuppressWarnings("unused")
	public static void main(String[] args) {

		Calendar today = Calendar.getInstance();
		
		System.out.println(today.get(Calendar.YEAR));
		System.out.println(today.get(Calendar.MONTH)+1); //1월은 0이므로 1을 더해줌
		System.out.println(today.get(Calendar.DATE));
		System.out.println(today.get(Calendar.DAY_OF_YEAR)); //올해부터 경과된 날짜
		System.out.println(today.get(Calendar.DAY_OF_WEEK)); //일요일 1 ~ 토요일 7
		System.out.println(today.get(Calendar.AM_PM)); //오전 0 ~ 오후 1
		System.out.println(today.get(Calendar.HOUR));
		System.out.println(today.get(Calendar.HOUR_OF_DAY)); //24시 기준
		System.out.println(today.get(Calendar.MINUTE)); 
		System.out.println(today.get(Calendar.SECOND));
		
		System.out.println("===============================================");
		
		Calendar cal = Calendar.getInstance();
//		Date d = new Date(cal.getTimeInMillis());
		Date d = new Date();
		System.out.println(d);
		
		Date d02 = new Date();
		Calendar cal02 = Calendar.getInstance();
		cal02.setTime(d02);
		System.out.println(cal02);
		
		Calendar cal03 = Calendar.getInstance();
		cal03.set(2020, 10, 30);
		System.out.println(toDateString(cal03));
		
		//1일 이후
		cal03.add(Calendar.DATE, 1);
		System.out.println(toDateString(cal03));
		
		//7일 이후
		cal03.add(Calendar.DATE, -7);
		System.out.println(toDateString(cal03));
		
		//6달전
		cal03.add(Calendar.MONTH, -6);
		System.out.println(toDateString(cal03));
		
		String yearString = "2021";
		String monthString = "02";
		
		System.out.println(yearString);
		System.out.println(monthString);
			
		int year = Integer.parseInt(yearString);
		int month = Integer.parseInt(monthString);
		
		//시작요일(?), 시작일(1), 그달의 마지막일(?)
		Calendar start = Calendar.getInstance(); //시작일
		Calendar end = Calendar.getInstance(); //종료일
		
		//시작일: year,month
		start.set(year, month-1, 1);
		
		//종료일 : 다음달 1일에서 -1 / 말일을 만듬
		end.set(year, month, 1);
		end.add(Calendar.DATE, -1);
	
		System.out.println("===============================================");
		
		int startDay = start.get(Calendar.DATE);
		int endDay = end.get(Calendar.DATE);
		
		//시작요일
		int startWeek = start.get(Calendar.DAY_OF_WEEK);
		
//		System.out.println(Main2.toDateString(start)); //2021-1-1
//		System.out.println(Main2.toDateString(end)); //2021-1-31

		System.out.println(year+"년"+month+"월");
		System.out.println(" SU MO TU WE TH FR SA");
		
		//시작요일에 공백추가
		for(int i = 1; i < startWeek; i++) {
			System.out.print("   ");
		}
		
		//달력출력
		//1~그 달의 마지막 일 출력
		//일%7==0 라인스킵
		for(int i = 1, n = startWeek; i <= endDay; i++, n++) {
			System.out.print(   (i<10)?"  "+i:" "+i);
			if(n%7==0) {
				System.out.println();
			}
		}
	}

	public static String toDateString(Calendar cal) {
		return cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+cal.get(Calendar.DATE);
	}
	
}
