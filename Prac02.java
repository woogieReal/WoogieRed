import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Scanner;

/*
 * 날짜 계산기
 * 현재 날짜부터 며칠 전, 며칠 후의 날짜와 요일을 검색하는 코드.
 */
public class Prac02 {

	@SuppressWarnings("resource")
	public static void main(String[] args) {

		LocalDate present = LocalDate.now(); //현재 날짜 
		DayOfWeek dayOfWeek = present.getDayOfWeek(); //현재 요일
		
		System.out.print("지금은 "+present+" ");
		System.out.println(dayOfWeek+" 입니다.");
		
		System.out.println("며칠 전, 며칠 후를 검색할까요? ");
		
		Scanner scan = new Scanner(System.in);
		int input = scan.nextInt();
		
		if (input > 0) { //며칠 후를 검색하는 코드
			
			LocalDate AFewDaysLater = present.plusDays(input); //plusDays()를 이용하여 현재로부터 입력값 후의 날짜를 구함
			DayOfWeek newDayOfWeek = AFewDaysLater.getDayOfWeek(); //getDayOfWeek()를 이용하여 현재로부터 입력한 값 후의 요일을 구함
			
			System.out.print(input+"일 후의 날짜는 "+AFewDaysLater+" ");
			System.out.println(newDayOfWeek+" 입니다.");
			
		} else if(input < 0) { //며칠 전을 검색하는 코드
			
			LocalDate AFewDaysAgo = present.plusDays(input); //input 값이 음수이기 때문에 plusDays이지만 이전으로 계산
			DayOfWeek oldDayOfWeek = AFewDaysAgo.getDayOfWeek();
			
			System.out.print((int)Math.abs(input)+"일 전의 날짜는 "+AFewDaysAgo+" ");
			System.out.println(oldDayOfWeek+" 입니다.");
		} else { 
			
			System.out.println("올바른 입력 값이 아닙니다. ");
		
		}
	}

}
