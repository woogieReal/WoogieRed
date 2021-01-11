package g_generics;

//Fruit를 상속받는 Apple클래스

public class Apple extends Fruit {

	public Apple(String name, int weight) {
		super(name, weight); //아버지 클래스(super)에 있는 생성자호출
	}

}
