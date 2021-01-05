package java_api_class;

import java.util.LinkedList;
import java.util.ListIterator;

public class G_ListIterator {

	public static void main(String[] args) {

		LinkedList<Integer> que = new LinkedList<Integer>();
		que.add(1);
		que.add(2);
		que.add(3);
		que.add(4);
		
		ListIterator<Integer> iter = que.listIterator();
		
		//정방향 출력
		while(iter.hasNext()) { //다음(Next)으로 출력할 것이 있으면(has) true, 없으면 false
			System.out.println(iter.next());
		}
		
		System.out.println("=====================");
		
		//역방향 출력
		while(iter.hasPrevious()) { //이전(Previous) 출력할 것이 있으면(has) true, 없으면 false
			System.out.println(iter.previous());
		}
		
		
	}

}
