package java_api_class;

import java.util.StringTokenizer;

public class G_StringTokenizer {

	public static void main(String[] args) {

//		StringTokenizer
//		긴 문자열을 지정된 구분자를 기준으로 토큰이라는 여러개의 문자열로 잘라내는데 사용
		
		String source = "100,200,300,400,500";
		
		StringTokenizer st = new StringTokenizer(source, ",");
		//구분자 쉼표(,)를 기준으로 나눠짐
		
		while(st.hasMoreElements()) {
			System.out.println(st.nextToken());
		}
		System.out.println("============================");
		
		
		String source2 = "x=100*(200+300)/2";
		StringTokenizer st2 = new StringTokenizer(source2,"*(+)/=,true"); 
		//true는 *(+)/= 이 다 개별이라는 것을 의미

		while(st2.hasMoreElements()) {
			System.out.println(st2.nextToken());
		}
		System.out.println("============================");	
		
	}

}
