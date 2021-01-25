package g_lambda;

public class CalculateInterfaceImpl implements CalculateInterface {

	@Override
	public int complicatedCalculate(int x, int y, int z) {
		int result = 0;
		for(int i = 0; i <= z; i++) {
			result += i*z*(x + y);
			System.out.println(result);
		}
		return result;
	}

}
