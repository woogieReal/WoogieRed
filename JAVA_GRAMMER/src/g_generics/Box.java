package g_generics;

import java.util.ArrayList;

//지네릭스
//컴파일시 타입체크 
//객체의 타입 안정성을 높이고 형변환의 번거로움을 줄여준다
//(하나의 컬렉션에는 대부분 한종류의 객체만 저장)
//
//지네릭스 제한
//static 멤버에는 타입변수 T를 사용할 수 없다.
//ex)static T item;
//지네릭 타입의 배열 T[]를 생성하는 것은 허용되지 않는다.

//대입된 타입과 다른 타입의 객체는 추가할 수 없다(단 상속관계면 가능)

public class Box<T> {
	//Box클래스는 T라는 타입변수를 가진다.
	
	//타입변수 T를 가지는 배열생성
	ArrayList<T> list = new ArrayList<T>();
	
	//T타입의 변수item을 받아 배열에 추가한다.
	void add(T item) {
		list.add(item);
	}
	
	//int i를 파라미터로 리스트의 i번째 요소를 T타입 요소로 반환한다.
	T get(int i) {
		return list.get(i);
	}
	
	//list를 반환한다.
	ArrayList<T> getList(){
		return list;
	}
	
	//list의 크기를 반환한다.
	int size() {
		return list.size();
	}
	
	//list를 문자열로 반환한다.
	public String toString() {
		return list.toString();
	}
	
		
}
