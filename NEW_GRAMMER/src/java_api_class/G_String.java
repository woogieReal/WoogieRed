package java_api_class;

import java.util.ArrayList;
import java.util.StringJoiner;

public class G_String {
	
	public static void main(String[] args) {

//		charAt() 메소드
//		해당 문자열의 특정 인덱스에 해당하는 문자를 반환합니다.
//		문자열을 하나 하나 문자로 출력할 때 쓸 수 있음
		
		String name = "woogie";
		char ch = ' ';
		for (int i = 0; i < name.length(); i++) {
			ch = name.charAt(i);
			System.out.print(ch+" ");
		}
		System.out.println();
		
//		substring() 메소드
//		해당 문자열에서 특정 인덱스 구간 만큼의 문자열을 반환합니다.
//      문자열의 일부분을 출력할 때 사용
		
		String tmp = "one two three four";
		String newTmp = tmp.substring(0, 7);
		System.out.println(newTmp);
		
//		toCharArray()
//		문자열을 문자배열(char array)로 바꿔주는 메소드
		
		String id = "aegis01";
		char []idChar = id.toCharArray();
		for (int i = 0; i < idChar.length; i++) {
			System.out.print(idChar[i]+" ");
		}
		System.out.println();
		
//		compareTo() 메소드
//		해당 문자열을 인수로 전달된 문자열과 사전 편찬 순으로 비교합니다.
//		이 메소드는 문자열을 비교할 때 대소문자를 구분하여 비교합니다.
//		만약 두 문자열이 같다면 0을 반환하며, 해당 문자열이 인수로 전달된 문자열보다 작으면 음수를, 크면 양수를 반환합니다.
//		만약 문자열을 비교할 때 대소문자를 구분하지 않기를 원한다면, compareToIgnoreCase() 메소드를 사용하면 됩니다.
		
		String hobby = "Watching movie";
		System.out.println(hobby.compareTo("Watching movie")); //같은 문자열이면 0
		System.out.println(hobby.compareTo("Watching drama")); //아니면 음수나 양수
		System.out.println(hobby.compareToIgnoreCase("watching movie")); //대소문자무시, 띄어쓰기는 유효
		
//		concat() 메소드
//		해당 문자열의 뒤에 인수로 전달된 문자열을 추가한 새로운 문자열을 반환합니다.
//		만약 인수로 전달된 문자열의 길이가 0이면, 해당 문자열을 그대로 반환합니다.
		
		String professor01 = "김재욱";
		String professor02 = "유미연";
		String professor03 = "김영웅";
		
		System.out.println(professor01.concat(" 교수"));
		System.out.println(professor02.concat(" 교수"));
		System.out.println(professor03.concat(" 교수"));
		
		ArrayList <String>arr = new ArrayList<String>();
		arr.add("김재욱");
		arr.add("유미연");
		arr.add("김영웅");
		
		for (int i = 0; i < arr.size(); i++) {
			System.out.println(arr.get(i).concat(" 교수"));
			}
		
//		indexOf() 메소드
//		해당 문자열에서 특정 문자나 문자열이 처음으로 등장하는 위치의 인덱스를 반환합니다.
//		만약 해당 문자열에 전달된 문자나 문자열이 포함되어 있지 않으면 -1을 반환합니다.
		
		String Introducing = "I am woogie, I came from Incheon, Korea";
		System.out.println(Introducing.indexOf("woogie"));
		
//		trim() 메소드
//		해당 문자열의 맨 앞과 맨 뒤에 포함된 모든 공백 문자를 제거해 줍니다.
		
		String blank = "  blank  ";
		System.out.println(blank.trim());
		
//		toLowerCase() 메소드는 해당 문자열의 모든 문자를 소문자로 변환시켜 줍니다.
//		toUpperCase() 메소드는 해당 문자열의 모든 문자를 대문자로 변환시켜 줍니다.
		
		String character = "aBcDeF";
		System.out.println(character.toLowerCase());
		System.out.println(character.toUpperCase());
		
		//문자열에서 첫글자만 대문자 만들기
		String first_letter = character.substring(0, 1);
		String other_letter = character.substring(1, character.length());
		String result = first_letter.toUpperCase() + other_letter;
		System.out.println(result);
		
//		replace() 메소드
//		해당 문자열의 문자/문자열을 치환
		
		String rep = "woogia";
		System.out.println(rep.replace('a', 'e'));
		System.out.println(rep.replace("woogia", "umi"));
		
//		split() 메소드
//		지정한 문자를 기준으로 문자열을 분할하여 배열형태로 반환
		
		String spl = "010-7232-5609";
		String[] splArr = spl.split("-");
		System.out.println(splArr[0]);
		System.out.println(splArr[1]);
		System.out.println(splArr[2]);
		
//		join() 메소드
//		여러 문자열을 구분자를 넣어 결합
		
		String[] strArr = new String[3];
		strArr[0] = "010";
		strArr[1] = "7232";
		strArr[2] = "5609";
		String strJoin = String.join("-", strArr);
		System.out.println(strJoin);
		
//		StringJoiner 클래스
//		시작문자, 구분자, 끝문자를 지정하여 결합하는 클래스
		
		StringJoiner sj = new StringJoiner("-", "<", ">");
		String[] strArr2 = {"010", "7232", "5609"};
		for(String strTmp : strArr2) {
			sj.add(strTmp);
		}
		System.out.println(sj);
		
//		valueOf() 메소드
		
		
		
		
	}

}
