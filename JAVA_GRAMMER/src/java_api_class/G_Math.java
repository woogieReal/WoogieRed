package java_api_class;

public class G_Math {
	
	public static void main(String[] args) {
		
		int a = 10;
		int b = 30;
		int c = -20;
		
		System.out.println(Math.max(a, b));
		System.out.println(Math.min(a, b));
		System.out.println(Math.abs(c)); //절대값
		System.out.println("================================");
		System.out.println(Math.floor(12.45)); //소숫점 첫째자리에서 내림
		System.out.println(Math.ceil(12.45)); // 소숫점 첫째자리에서 올림
		System.out.println(Math.round(12.45)); //소숫점 첫째자리에서 반올림
		System.out.println(Math.rint(13.45)); //소숫점 첫째자리에서 반올림(double 값)
		System.out.println(Math.round(12.456*100)/100.0d); //소숫점 셋째자리에서 반올림
		System.out.println("================================");
		System.out.println((int)Math.pow(10, 2)); // 10의 2제곱
		System.out.println(Math.sqrt(30)); //인수의 제곱근을 반환(실수까지)
		System.out.println((int)Math.log10(1000)+1); //숫자의 길이 측정
		
		
	}

}
