package java_api_class;

import java.text.DecimalFormat;

public class G_DecimalFormat {

	public static void main(String[] args) {

		// 형식화 클래스 중에서 숫자를 형식화 하는데 사용
				// 정수, 실수, 천단위 기호
				// #,###,###,###.####이 중요
				
				double number = 1234567.89;
				String[] pattern = {"0", //소수 첫째자리에서 반올림
						"#",
						"0.0", //소수 둘째자리에서 반올림
						"#.#",
						"0000000000.0000", //0001234567.8900
						"#,###,###,###.####"  //1234567.89 이걸 가장 많이 씀
						};
				
				for(int i = 0; i < pattern.length; i++) {
					DecimalFormat df = new DecimalFormat(pattern[i]);
					System.out.printf("%19s %s\n",pattern[i],df.format(number));
				}
		
		
	}

}
