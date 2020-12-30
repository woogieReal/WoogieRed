package java_api_class;

import java.math.BigInteger;

public class G_BigInteger {

	public static void main(String[] args) {

//		BigInteger
//		정수형으로 표현할 수 있는 값의 한계가 있다.
//		long으로 표현할 수 있는 값은 10진수 19자리. 이것 이상을 표시할 때 사용
//		내부적으로 int배열로 데이터를 처리한다.
//		따라서 사칙연산도 함수를 통해 이루어진다.
//		사칙연산시 add,subtract,divide,multiply 사용
		
		int i = 2_000_000_000; //20억
		int j = 1_000_000_000; //10억
		
		BigInteger bigNumI = BigInteger.valueOf(i);
		BigInteger bigNumJ = BigInteger.valueOf(j);
		
		//사칙연산
		System.out.println(bigNumI.add(bigNumJ));
		System.out.println(bigNumI.subtract(bigNumJ));
		System.out.println(bigNumI.divide(bigNumJ));
		System.out.println(bigNumI.multiply(bigNumJ));
	}

}
