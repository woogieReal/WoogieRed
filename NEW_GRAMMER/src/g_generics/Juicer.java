package g_generics;

public class Juicer {

//	와일드카드
//	지네릭타입에 와일드 카드를 쓰면 여러 타입을 대입가능
//	(단 <? Extends T&E>와 같이 사용안됨 '&'사용불가)
//	<? extends T> : T와  그 자손들만 가능(와일드카드 상한제한)
//	<? super T> : T와 그 조상들만 가능(와일드카드 하한제한)
//	<?> : 제한없음. 모든타입이 가능 = <? extends Object>
	
	public static void makeJuice(FruitBox<? extends Fruit> box) {
		String name = "";
		
		for(Fruit f : box.getList()) {
			name += f.toString()+" ";
		}
		System.out.println("주스로 만들 과일목록 "+name);
	}
	
}
