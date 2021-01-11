package java_api_class;

import java.util.Comparator;
import java.util.Objects;

public class G_Comparator {

	public static void main(String[] args) {

		Comparator<String> c = String.CASE_INSENSITIVE_ORDER;// 대소문자를 구분하지 않고 비교

		System.out.println(Objects.compare("aa", "bb", c)); // 뒤가 크면 -1
		System.out.println(Objects.compare("bb", "aa", c)); // 앞이 크면 1
		System.out.println(Objects.compare("cc", "cc", c)); // 같으면 0

	}

}
