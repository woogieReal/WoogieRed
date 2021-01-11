package java_api_class;

import java.util.LinkedList;
import java.util.Queue;

public class G_Queue {

	public static void main(String[] args) {
		
		Queue<String> que = new LinkedList<String>();
		//LinkedList<String> que = new LinkedList<String>();
		//Deque<String> que = new ArrayDeque<String>();
		
		//add() 또는 offer()
		//요소 저장
		que.offer("하나");
		que.offer("둘");
		que.offer("셋");
		que.offer("넷");
		
		//peek()
		//가장 먼저 들어온 요소 반환
		System.out.println(que.peek());
		
		//큐 간단 출력
		//원칙적으로 iterator()를 사용한다.
		System.out.println(que);
		
		//poll()
		//가장 먼저 들어온 요소의 반환 및 추출
		System.out.println(que.poll());
		System.out.println(que);
		
		//remove()
		//입력한 요소를 제거
		que.remove("넷");
		System.out.println(que);

		
		
	}

}
