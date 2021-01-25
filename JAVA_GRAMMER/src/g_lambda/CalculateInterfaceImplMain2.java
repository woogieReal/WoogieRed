package g_lambda;

public class CalculateInterfaceImplMain2 {

	public static void main(String[] args) {
		
		//무명 inner class
		//하나의 클래스 안에 다른 클래스를 정의한 클래스
		//클래스 이름이 없는 클래스로 바디만 존재
		//클래스를 정의하는 동시에 객체를 생성하기 때문에 한 개의 객체만 만들 수 있음
		CalculateInterface inter = new CalculateInterface() {

			@Override
			public int complicatedCalculate(int x, int y, int z) {
				int result = 0;
				for(int i = 0; i <= z; i++) {
					result += i*z*(x + y);
					System.out.println(result);
				}
				return result;
			}		
		};
		
		System.out.println(inter.complicatedCalculate(3, 4, 5));
		
	}
	
}
