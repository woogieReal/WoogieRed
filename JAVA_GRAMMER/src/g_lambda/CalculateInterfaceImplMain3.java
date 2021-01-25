package g_lambda;

public class CalculateInterfaceImplMain3 {

	public static void main(String[] args) {

		//람다식
		CalculateInterface lambdaCalcul = (int x, int y, int z)
				-> {
					int result = 0;
					for(int i = 0; i <= z; i++) {
						result += i*z*(x + y);
						System.out.println(result);
					}
					return result;
				};
				
		System.out.println(lambdaCalcul.complicatedCalculate(3, 4, 5));
	}

}
