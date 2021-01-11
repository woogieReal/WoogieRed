package java_api_class;

import java.time.LocalDate;
import java.time.LocalTime;

/*
 * LocalDate 클래스는 날짜를 표현하는 데 사용되며
 * LocalTime 클래스는 시간을 표현하는 데 사용됩니다.
 * java.time 패키지에 포함된 대부분의 클래스들은 이 두 클래스를 확장한 것이 많으므로 
 * 우선 이 두 클래스를 잘 이해하는 것이 중요합니다.
 */
public class G_LocalDate_LocalTime {

	public static void main(String[] args) {
		
		//LocalDate.now() 메소드
		//현재 날짜를 반환
		//LocalTime.now() 메소드
		//현재 시간을 반환
//			2020-12-02
//			12:21:37.381
		
		LocalDate today = LocalDate.now();
		LocalTime present = LocalTime.now();
		
		System.out.println(today);
		System.out.println(present);
		
		//LocalDate.of() 메소드
		//인수로 연월일을 입력하면 날짜 값으로 반환
		//LocalTime.of() 메소드
		//인수로 시분을 입력하면 시간 값으로 반환
//			1994-04-14
//			12:00
		
		LocalDate birthDay = LocalDate.of(1994, 04, 14);
		LocalTime birthTime = LocalTime.of(12, 00);
		
		System.out.println(birthDay);
		System.out.println(birthTime);
		
		//LocalDate 클래스에서 제공하는 대표적인 getter 메소드는 다음과 같습니다.
//			올해는 2020년 입니다.
//			지금은 DECEMBER 입니다.
//			오늘은 2일 입니다.
//			오늘은 WEDNESDAY입니다.
		
		//LocalDate today = LocalDate.now(); 객체를 먼저 생성
		System.out.println("올해는 "+today.getYear()+"년 입니다.");
		System.out.println("지금은 "+today.getMonth()+" 입니다.");
		System.out.println("오늘은 "+today.getDayOfMonth()+"일 입니다.");
		System.out.println("오늘은 "+today.getDayOfWeek()+"입니다.");
		
		//LocalTime 클래스에서 제공하는 대표적인 getter 메소드는 다음과 같습니다.
		
		//LocalTime present = LocalTime.now(); 객체를 먼저 생성
//			현재 시각은12시 27분 입니다.
		System.out.print("현재 시각은"+present.getHour()+"시 ");
		System.out.println(present.getMinute()+"분 입니다.");
		

	}

}
