package java_api_class;
import java.util.ArrayList;
import java.util.Random;

public class G_Random {

	public static void main(String[] args) {

		Random random = new Random(); //랜덤객체 생성
		ArrayList <Integer>arr = new ArrayList<>();
		
		for (int i = 0; i < 10; i++) {
			int rand = random.nextInt(10); //0~9까지 랜덤으로 취함
			arr.add(rand);
		}
		
		System.out.println(arr);
		
		
		
	}

}
