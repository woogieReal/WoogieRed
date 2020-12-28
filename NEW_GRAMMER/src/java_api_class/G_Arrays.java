package java_api_class;

import java.util.Arrays;

/*
 * Arrays 클래스에는 배열을 다루기 위한 다양한 메소드가 포함되어 있습니다.
 * Arrays 클래스의 모든 메소드는 클래스 메소드(static method)이므로, 객체를 생성하지 않고도 바로 사용할 수 있습니다.
 * 이 클래스는 java.util 패키지에 포함되므로, 반드시 import 문으로 java.util 패키지를 불러오고 나서 사용해야 합니다.
 */
public class G_Arrays {

	public static void main(String[] args) {

//		binarySearch() 메소드
//		전달받은 배열에서 특정 객체의 위치를 이진 검색 알고리즘을 사용하여 검색한 후, 해당 위치를 반환합니다.
//		이 메소드는 이진 검색 알고리즘을 사용하므로, 매개변수로 전달되는 배열이 sort() 메소드 등을 사용하여 미리 정렬되어 있어야만 제대로 동작합니다.

		//10
		int[] arr = new int[100];
		for (int i = 0; i < 100; i++) {
			arr[i] = i + 10;
		}
		System.out.println(Arrays.binarySearch(arr, 20));
		// 20이라는 값을 가진 위치는 arr[10]이기에 10을 반환함

//		copyOf() 메소드
//		전달받은 배열의 특정 길이만큼을 새로운 배열로 복사하여 반환합니다.
//		copyOf() 메소드는 첫 번째 매개변수로 원본 배열을 전달받고, 두 번째 매개변수로 원본 배열에서 새로운 배열로 복사할 요소의 개수를 전달받습니다.
//		그리고 원본 배열과 같은 타입의 복사된 새로운 배열을 반환합니다.

		//1 2 3 4 
		int[] arr2 = { 1, 2, 3, 4, 5 };
		int[] arr3 = Arrays.copyOf(arr2, 4); // 0~3까지의 위치의 배열을 복사
		for (int i = 0; i < arr3.length; i++) {
			System.out.print(arr3[i] + " ");
		}
		System.out.println();

//		copyOfRange() 메소드
//		전달받은 배열의 특정 범위에 해당하는 요소만을 새로운 배열로 복사하여 반환합니다.

		//13 14 15 
		int[] arr4 = { 11, 12, 13, 14, 15 };
		int[] arr5 = Arrays.copyOfRange(arr4, 2, 5); // 2~4까지의 위치의 배열을 복사
		for (int i = 0; i < arr5.length; i++) {
			System.out.print(arr5[i] + " ");
		}
		System.out.println();

//		fill() 메소드
//		전달받은 배열의 모든 요소를 특정 값으로 초기화해 줍니다.
		
		//7 7 7 7 7 7 7 7 7 7 
		int[] arr6 = new int[10];		 
		Arrays.fill(arr6, 7);

		for ( int i = 0; i < arr6.length; i++) {
			System.out.print(arr6[i]+" ");
		}
		System.out.println();
		
//		sort() 메소드
//		전달받은 배열의 모든 요소를 오름차순으로 정렬합니다.
//		매개변수로 정렬할 배열을 전달받으며, 따라서 이 메소드는 전달받은 원본 배열의 순서를 변경하게 됩니다.
		
		//1 2 3 4 5 
		int[] arr7 = {5, 4, 3, 2, 1};
		Arrays.sort(arr7);
		for (int tmp : arr7) {
			System.out.print(tmp+" ");
		}
		System.out.println();
		
//		toString()메소드
//		배열을 String으로 바꿉니다.
//		print를 통해 for문을 쓰지 않고 한 번에 배열을 출력하게 해줍니다.
		
		//[1, 2, 3, 4, 5, 6]
		int[] arr8 = {1, 2, 3, 4, 5, 6};
		System.out.println(Arrays.toString(arr8));
		
		
	}

}
