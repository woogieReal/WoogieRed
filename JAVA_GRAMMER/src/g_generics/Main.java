package g_generics;

public class Main {

	@SuppressWarnings("unused")
	public static void main(String[] args) {
		
		//FruitBox는 Fruit을 비롯한 Fruit클래스를 상속한 자손을 변수타입으로 선언가능하다.
		FruitBox<Fruit> fruitBox = new FruitBox<Fruit>();
		FruitBox<Apple> appleBox = new FruitBox<Apple>();
		FruitBox<Grape> grapeBox = new FruitBox<Grape>();
		
		//FruitBox는 Box<T>클래스를 상속했기 때문에 Box클래스의 메소드를 사용할 수 있다.
		fruitBox.add(new Apple("과일모듬1", 10));
		fruitBox.add(new Apple("과일모듬2", 20));
		fruitBox.add(new Apple("과일모듬3", 30));
		System.out.println("전체 상품은: "+fruitBox.getList());
		System.out.println("상품의 갯수는: "+fruitBox.size());
		System.out.println("두 번째 상품은: "+fruitBox.get(1));
	
		Juicer.makeJuice(fruitBox);
	
	
	
	
	}

}
