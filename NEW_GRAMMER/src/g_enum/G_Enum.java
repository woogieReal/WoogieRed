package g_enum;

enum Rainbow {RED, ORANGE, YELLOW, GREEN, BLUE, INDIGO, VIOLET}
/*
 * 열거체의 상숫값 정의 및 추가
 * 위와 같이 정의된 열거체의 첫 번째 상숫값은 0부터 설정되며, 그다음은 바로 앞의 상숫값보다 1만큼 증가되며 설정됩니다.
 * enum 열거형으로 지정된 상수는 대문자 사용.
 * 마지막 끝에 세미콜론(;)을 붙이지 않음.
 */

public class G_Enum {

	public String name;
	public int no;
	public Rainbow color;
	
	
	public static void main(String[] args) {

		G_Enum person = new G_Enum();
		
		person.name = "김재욱";
		person.no = 5609;
		person.color = Rainbow.RED; //Rainbow의 객체 RED로 선언
		
		System.out.println(person.name);
		System.out.println(person.no);
		System.out.println(person.color);

		
		System.out.println("================================");
//		values() 메소드
//		해당 열거체의 모든 상수를 저장한 배열을 생성하여 반환합니다.
//		이 메소드는 자바의 모든 열거체에 컴파일러가 자동으로 추가해 주는 메소드입니다.
		
		Rainbow [] arr = Rainbow.values();
		for (Rainbow rb : arr) {
			System.out.println(rb);
		}
		
		System.out.println("================================");
//		valueOf() 메소드
//		전달된 문자열과 일치하는 해당 열거체의 상수를 반환합니다.
		
		Rainbow rb = Rainbow.valueOf("GREEN");
		System.out.println(rb);
		System.out.println("================================");
		
//		ordinal() 메소드
//		해당 열거체 상수가 열거체 정의에서 정의된 순서(0부터 시작)를 반환합니다.
//		이때 반환되는 값은 열거체 정의에서 해당 열거체 상수가 정의된 순서이며, 상숫값 자체가 아님을 명심해야 합니다.
		
		int num = Rainbow.RED.ordinal();
		System.out.println(num);
		System.out.println("================================");

		
		
		
	}

}
