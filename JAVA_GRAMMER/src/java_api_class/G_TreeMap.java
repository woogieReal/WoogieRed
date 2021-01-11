package java_api_class;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

public class G_TreeMap {
	
	/*
	 * TreeMap은 이진트리를 기반으로 한 Map 컬렉션
	 * TreeSet은 그냥 값만 저장한다면 TreeMap은 key와 value가 저장된 Map, Etnry를 저장
	 * 객체를 저장하면 자동으로 오름차순으로 정렬
	 * 일반적으로 Map으로써의 성능이 HashMap보다 떨어짐
	 * 정렬된 상태로 Map을 유지해야 하거나 정렬된 데이터를 조회해야 하는 범위 검색이 필요한 경우 TreeMap을 사용
	 */
	public static void main(String[] args) {
		
		TreeMap<Integer,String> map = new TreeMap<Integer,String>();
		//HashMap과 크게 다르지 않으나 선언 시 크기를 지정해줄 수는 없습니다.
		
//		put(key,value)
//		데이터 추가/수정
		map.put(1, "사과");//값 추가
		map.put(2, "복숭아");
		map.put(3, "수박");
		map.put(4, "배");
		map.put(4, "수박");//key4의 value배가 수박으로 변경됨
		
//		remove(key)
//		오직 key값으로만 Map요소를 삭제할 수 있음
		map.remove(4); 
		
//		map.clear(); 
//		모든 값 제거
		
//		TreeMap 단일 값 출력
		System.out.println(map); //전체 출력 : {1=사과, 2=복숭아, 3=수박}
		System.out.println(map.get(1));//key값 1의 value얻기 : 사과
		System.out.println(map.firstEntry());//최소 Entry 출력 : 1=사과
		System.out.println(map.firstKey());//최소 Key 출력 : 1
		System.out.println(map.lastEntry());//최대 Entry 출력: 3=수박
		System.out.println(map.lastKey());//최대 Key 출력 : 3
		
//		TreeMap 전체 값 출력
//		keySet()이 간단하나 성능은 entrySet()이 좋음
//		entrySet() 활용
		for (Entry<Integer, String> entry : map.entrySet()) {
		    System.out.println("[Key]:" + entry.getKey() + " [Value]:" + entry.getValue());
		}
		
//		KeySet() 활용
		for(Integer i : map.keySet()){ //저장된 key값 확인
		    System.out.println("[Key]:" + i + " [Value]:" + map.get(i));
		}
		
//		Iterator
//		entrySet().iterator()
		Iterator<Entry<Integer, String>> entries = map.entrySet().iterator();
		while(entries.hasNext()){
		    Map.Entry<Integer, String> entry = entries.next();
		    System.out.println("[Key]:" + entry.getKey() + " [Value]:" +  entry.getValue());
		}
		
//		keySet().iterator()
		Iterator<Integer> keys = map.keySet().iterator();
		while(keys.hasNext()){
		    int key = keys.next();
		    System.out.println("[Key]:" + key + " [Value]:" +  map.get(key));
		}
		
		
	}

}
