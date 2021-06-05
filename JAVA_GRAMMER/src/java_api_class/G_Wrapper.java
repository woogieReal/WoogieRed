package java_api_class;

public class G_Wrapper {


	public static void main(String[] args) {
				
		Integer num = new Integer(17); //박싱
		int n = num.intValue(); //언박싱
		System.out.println(n);
			
		Integer num2 = 17; //오토박싱
		@SuppressWarnings("unused")
		int n2 = num2; //오토언박싱
		
		
		String str = "10";
		String str2 = "10.5";
		String str3 = "true";
		
		//String값을 각 타입으로 변환
		byte b = Byte.parseByte(str);
		int i = Integer.parseInt(str);
		long l = Long.parseLong(str);
		float f = Float.parseFloat(str2);
		boolean bool = Boolean.parseBoolean(str3);
		
		System.out.println(b);
		System.out.println(i);
		System.out.println(l);
		System.out.println(f);
		System.out.println(bool);
		
		//각 타임의 값을 가장 쉽게 String값으로 변환하는 방법
		int tmpInt = 15;
		float tmpFloat = 12.45f;
		boolean tmpBoolean = true;
		
		System.out.println(tmpInt + ""); //""문자열 기호를 붙히면 모두 String 값이 됨
		System.out.println(tmpFloat + ""); 
		System.out.println(tmpBoolean + "");
		
		//각 타입의 값을 String값으로 변환(정석)
		String tmpIntStr = Integer.toString(tmpInt);
		String tmpFloatStr = Float.toString(tmpFloat);
		String tmpBooleanStr = Boolean.toString(tmpBoolean);
		
		System.out.println(tmpIntStr);
		System.out.println(tmpFloatStr);
		System.out.println(tmpBooleanStr);
		
		//각 타입의 값을 String값으로 변환(정석2)
		String strVal = String.valueOf(12.5f);
		System.out.println(strVal);
		
	}
}
