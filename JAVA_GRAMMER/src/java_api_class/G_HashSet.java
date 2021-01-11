package java_api_class;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;

public class G_HashSet {

	/*
	 * HashSet은 Set 인터페이스의 구현 클래스
	 * Set은 객체를 중복해서 저장할 수 없다.중복을 자동으로 제거 
	 * 저장 순서가 유지되지 않으므로 요소의 저장 순서를 유지해야 한다면 LinkedHashSet 클래스를 사용 
	 * 자동정렬을 지원하지 않으므로 이 경우 TreeSet을 사용
	 */
	@SuppressWarnings("unused")
	public static void main(String[] args) {

		HashSet<Integer> set1 = new HashSet<Integer>();
		HashSet<Integer> set2 = new HashSet<Integer>(10);// 초기 용량(capacity)지정
		HashSet<Integer> set3 = new HashSet<Integer>(Arrays.asList(1, 2, 3));// 초기값 지정

//		add()
//		입력되는 값이 HashSet 내부에 존재하지 않는다면 그 값을 HashSet에 추가하고 true를 반환
		System.out.println(set1.add(1)); // true 반환
		System.out.println(set3.add(1)); // false 반환

//		remove()
//		매개변수값이 HashSet 내부에 존재한다면 그 값을 삭제한 후 true를 반환
		System.out.println(set1.remove(1)); // true 반환
		System.out.println(set1.remove(1)); // false 반환
		
//		clear()
//		HashSet 내부의 모든 데이터 삭제
		set2.add(5);
		set2.add(6);
		set2.clear();
		System.out.println(set2);
		
//		contains()
//		HashSet 내부에 원하는 값이 있는지 확인, 있으면 true 반환
		System.out.println(set3.contains(3)); // true 반환
		System.out.println(set3.contains(4)); // false 반환

//		HashSet 값 출력
//		Set에는 인덱스로 객체를 가져오는 get() 메소드가 없음
//		iterator 메소드를 이용
		Iterator<Integer> iter = set3.iterator();
		while (iter.hasNext()) {
			System.out.println(iter.next());
		}
		
		System.out.println("================================================");

		// HashSet 활용
		// HashSet 합집합, 교집합, 차집합
		// A: 1,2,3,4,5
		// B: 4,5,6,7,8

		// 합집합 (AUB): 1,2,3,4,5,6,7,8
		// 교집합 (A∩B): 4,5
		// 차집합 (A-B): 1,2,3

		HashSet<Integer> setA = new HashSet<Integer>();
		HashSet<Integer> setB = new HashSet<Integer>();

		for (int i = 1; i < 6; i++) {
			setA.add(i);
		}
		for (int i = 4; i < 9; i++) {
			setB.add(i);
		}

		// 합집합 AUB
		HashSet<Integer> setHap = new HashSet<Integer>();
		Iterator<Integer> iterA = setA.iterator();
		Iterator<Integer> iterB = setB.iterator();

		while (iterA.hasNext()) {
			setHap.add(iterA.next());
		}
		while (iterB.hasNext()) {
			setHap.add(iterB.next());
		}
		System.out.println(setHap);

		// 교집합 A∩B
		HashSet<Integer> setKyo = new HashSet<Integer>();
		iterB = setB.iterator();
		while (iterB.hasNext()) {
			Object obj = iterB.next();
			if (setA.contains(obj) == true) {
				setKyo.add((Integer) obj);
			}
		}
		System.out.println(setKyo);

		// 차집합 A-B
		HashSet<Integer> setCha = new HashSet<Integer>();
		iterA = setA.iterator();
		while (iterA.hasNext()) {
			Object obj = iterA.next();
			if (!setB.contains(obj)) {
				setCha.add((Integer) obj);
			}
		}
		System.out.println(setCha);

	}

}
