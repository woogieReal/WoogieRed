package java_api_class;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class G_HashMap {

	/*
	 * HashMap은 Map 인터페이스를 구현한 대표적인 Map 컬렉션
	 * key와 value로 구성된 Entry객체를 저장하는 구조
	 * key(중복불가)/value(중복가능)
	 * 기존의 저장된 key값으로 새로운 데이터를 저장하면 새로운 값으로 대체됨
	 * 객체를 저장하면 자동으로 오름차순으로 정렬
	 * 많은 양의 데이터를 검색하는 데 있어서 뛰어난 성능을 가짐
	 */
	@SuppressWarnings("unused")
	public static void main(String[] args) {

		
		HashMap<Integer,String> map1 = new HashMap<Integer,String>();
		HashMap<Integer,String> map2 = new HashMap<>(10);//초기 용량(capacity)지정
		//HashMap은 저장공간보다 값이 추가로 들어오면 저장공간을 약 두배로 늘림
		//초기에 저장할 데이서 개수를 알고 있으면 초기용량을 지정해 주는 것이 좋음
		
//		put(key,value)
//		데이터 추가/수정
		map1.put(1, "사과");
		map1.put(2, "바나나");
		map1.put(4, "배"); //순서가 바뀌어도 1234 순으로 출력됨
		map1.put(3, "포도");
		map1.put(3, "수박");//key3의 포도가 수박으로 변경됨
		
//		remove(key)
//		오직 key값으로만 Map요소를 삭제할 수 있음
		map1.remove(4); 
		
//		get(key)
//		key값의 value를 불러옴
		System.out.println(map1.get(1));
		

//		HashMap 전체 값 출력
//		keySet()이 간단하나 성능은 entrySet()이 좋음
//		entrySet()
//		key와 value 모두가 필요할 경우 사용
		System.out.println("전체는 "+map1.entrySet());
		System.out.println("=====================");
		for (Entry<Integer, String> entry : map1.entrySet()) {
		    System.out.println("[Key]:" + entry.getKey() + " [Value]:" + entry.getValue());
		}
		System.out.println("=====================");

		
//		keySet()
//		key 값만 필요할 경우 사용
		System.out.println("키 값은 "+map1.keySet());
		System.out.println("=====================");
		for (Integer i : map1.keySet()) {
		    System.out.println("[Key]:" + i + " [Value]:" + map1.get(i));
		}
		System.out.println("=====================");

//		Iterator
//		entrySet().iterator()
		Iterator<Entry<Integer, String>> entries = map1.entrySet().iterator();
		while(entries.hasNext()){
		    Map.Entry<Integer, String> entry = entries.next();
		    System.out.println("[Key]:" + entry.getKey() + " [Value]:" +  entry.getValue());
		}
		System.out.println("=====================");

//		//keySet().iterator()
		Iterator<Integer> keys = map1.keySet().iterator();
		while(keys.hasNext()){
		    int key = keys.next();
		    System.out.println("[Key]:" + key + " [Value]:" +  map1.get(key));
		}
		
		
		
		
	}

}
