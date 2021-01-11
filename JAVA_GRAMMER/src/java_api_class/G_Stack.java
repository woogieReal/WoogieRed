package java_api_class;

import java.util.Stack;

public class G_Stack {

	public static void main(String[] args) {
		
		Stack<Integer> st = new Stack<Integer>();
		//Deque<Integer> st = new ArrayDeque<Integer>();
		//더욱 복잡하고 빠른 스택을 구현가능 but search()사용불가
		
		//push()
		//요소 저장
		st.push(1);
		st.push(2);
		st.push(3);
		st.push(4);
		
		//peek()
		//스택의 제일 나중에 저장된 요소 반환
		System.out.println(st.peek());
		
		//출력
		//원칙적으로 iterator()를 사용한다.
		//하지만 향상된 for문을 사용하는 것을 권장하고 있다.
		System.out.println(st);
		
		//pop()
		//스택의 제일 나중에 저장된 요소 반환 및 추출
		st.pop();
		for(int tmp : st) {
			System.out.println(tmp);
		}
		
		//search()
		//요소의 위치검색(인덱스 반환)
		//제일 나중에 저장된 요소의 위치 1부터 시작(0 아님)
		System.out.println(st.search(3));
		System.out.println(st.search(1));
		
		System.out.println("=====================");

		
	}

}
