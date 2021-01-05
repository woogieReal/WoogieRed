package java_api_class;

import java.util.Arrays;
import java.util.Iterator;
import java.util.TreeSet;

public class G_TreeSet {

	/* 
	 * TreeSet은 Set 인터페이스를 구현, 이진 탐색 트리 구조
	 * 이진 탐색 트리는 추가와 삭제에는 시간이 조금 더 걸리지만 정렬, 검색에 높은 성능을 보이는 자료구조
	 * 생성자의 매개변수로 Comparator객체를 입력하여 정렬 방법을 임의로 지정가능
	 */
	public static void main(String[] args) {

		//HashSet과 선언방식은 유사하나 크기를 미리 지정할 수 없음
		TreeSet<Integer> set1 = new TreeSet<Integer>();
		TreeSet<Integer> set2 = new TreeSet<Integer>(Arrays.asList(1,2,3)); // 초기값 지정
		
//		add()
//		입력되는 값이 TreeSet 내부에 존재하지 않는다면 그 값을 TreeSet에 추가하고 true를 반환
		System.out.println(set1.add(1)); //true
		System.out.println(set1.add(2)); //true
		System.out.println(set1.add(3)); //true
		System.out.println(set1.add(4)); //true
		System.out.println(set1.add(5)); //true
		System.out.println(set1.add(1)); //falase
		
//		remove()
//		매개변수값이 TreeSet 내부에 존재한다면 그 값을 삭제한 후 true를 반환
		System.out.println(set1.remove(3)); //true
		System.out.println(set1.remove(3)); //false
		
//		clear()
//		TreeSet 내부의 모든 데이터 삭제
		set2.add(5);
		set2.add(6);
		set2.clear();
		System.out.println(set2);
		
//		contains()
//		TreeSet 내부에 원하는 값이 있는지 확인, 있으면 true 반환
		System.out.println(set1.contains(2)); // true 반환
		System.out.println(set1.contains(3)); // false 반환
		
//		TreeSet 값 출력
//		Set에는 인덱스로 객체를 가져오는 get() 메소드가 없음
//		iterator 메소드를 이용
		Iterator<Integer> iter = set1.iterator();
		while (iter.hasNext()) {
			System.out.println(iter.next());
		}
		System.out.println("==============================");
		
		System.out.println(set1.first());//최소값 출력
		System.out.println(set1.last());//최대값 출력
		System.out.println(set1.higher(3));//입력값보다 큰 데이터중 최소값 출력 없으면 null
		System.out.println(set1.lower(3));//입력값보다 작은 데이터중 최대값 출력 없으면 null

		
	}

}
