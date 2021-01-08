package g_enum;

public class FareCalculration {

	@SuppressWarnings("unused")
	public static void main(String[] args) {
		
//		BUS(100)의 BASIC_FARE(기본운송료)를 반환(3번 메소드 참고)
		int busBasicFare = Transportation.BUS.BASIC_FARE;
		
//		목적지까지의 거리
		int distance = 100;
		
//		목적지까지의 거리를 파라미터로 운송료를 계산
//		fare(distance) = distance*BASIC_FARE
		int busFare = Transportation.BUS.fare(distance);
		int trainFare = Transportation.TRAIN.fare(distance);
		int shipFare = Transportation.SHIP.fare(distance);
		int airplaneFare = Transportation.AIRPLANE.fare(distance);
		
//		운송료 출력
		System.out.println("목적지 까지의 버스요금은 "+busFare);
		System.out.println("목적지 까지의 기차요금은 "+trainFare);
		System.out.println("목적지 까지의 승선요금은 "+shipFare);
		System.out.println("목적지 까지의 항공요금은 "+airplaneFare);
		
	}

}
