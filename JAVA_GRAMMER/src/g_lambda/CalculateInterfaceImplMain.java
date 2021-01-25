package g_lambda;

public class CalculateInterfaceImplMain {

	public static void main(String[] args) {

		//인터페이스를 구현한 클래스의 객체를 만들어서 인터페이스 사용
		CalculateInterfaceImpl impl = new CalculateInterfaceImpl();
		System.out.println(impl.complicatedCalculate(3, 4, 5));
		
	}

}
