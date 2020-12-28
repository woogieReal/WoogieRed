package java_code;

import java.util.Arrays;
/**
 * 
 * 배열을 for문을 통해 무작위로 뒤섰는 코드
 *
 */
public class MixArray {

	public static void main(String[] args) {

		int[] arr = {1,2,3,4,5,6,7,8,9,10};
		
		for(int i = 0; i < arr.length; i++) {
			int n = (int)(Math.random()*arr.length);
			
			int tmp = arr[i];
			arr[i] = arr[n];
			arr[n] = tmp;
		}
		
		System.out.println(Arrays.toString(arr));
		
	}

}
