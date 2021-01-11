package g_generics;

//모든 과일클래스의 조상클래스

public class Fruit {
	
	String name;
	int weight;
	
	public Fruit(String name, int weight) {
		super();
		this.name = name;
		this.weight = weight;
	}

	@Override
	public String toString() {
		return "Fruit [name=" + name + ", weight=" + weight + "]";
	}
	
	
}
