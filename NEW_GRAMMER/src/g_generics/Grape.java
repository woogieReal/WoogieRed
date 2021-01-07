package g_generics;

//Fruit를 상속받는 Grape클래스

public class Grape extends Fruit {

	public Grape(String name, int weight) {
		super(name, weight); //아버지 클래스(super)에 있는 생성자호출
	}

}
