package java_api_class;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class G_BigDecimal {

	public static void main(String[] args) {

//		BigDecimal은 Java언어에서 실수를 가장 정밀하게 표현할 유일한 방법
//		double은 소수의 정밀도에 있어 한계가 있어 값이 유실될 수 있다.
//		34자리
//		사칙연산은 add,subtract,divide,multiply 사용
//		divide시 소숫점의 자릿수와 반올림설정을 해줘야함
		
		BigDecimal bigd01 = new BigDecimal("10");
		BigDecimal bigd02 = new BigDecimal("3");
		
		System.out.println(bigd01.add(bigd02));
		System.out.println(bigd01.subtract(bigd02));
		System.out.println(bigd01.multiply(bigd02));
		
		try
		{
			System.out.println(bigd01.divide(bigd02,25,RoundingMode.HALF_UP));	
		}catch (ArithmeticException e)
		{
			System.out.println(e.getMessage());
		}
	}

}
