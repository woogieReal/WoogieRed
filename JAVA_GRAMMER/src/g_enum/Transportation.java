package g_enum;

public enum Transportation {
	
//	운송수단별 요금계산: BUS,TRAIN,SHIP,AIRPLANE
//	요금계산: 추상메서드
	
//	5.enum 클래스 Transportation의 객체 생성
//	  2번에서 정의한대로 객체는 변수로 BASIC_FARE(기본운송료)를 가져야함
//	  4번에서 정의한대로 객체는 추상메소드 fare를 구현해야함
	BUS(100) {
		@Override
		int fare(int distance) {
			return distance*BASIC_FARE;
		}
	},
	TRAIN(150) {
		@Override
		int fare(int distance) {
			return distance*BASIC_FARE;
		}
	},
	SHIP(120) {
		@Override
		int fare(int distance) {
			return distance*BASIC_FARE;
		}
	},
	AIRPLANE(200) {
		@Override
		int fare(int distance) {
			return distance*BASIC_FARE;
		}
	};
	
//	1. 기본운송료를 정의
	protected final int BASIC_FARE; //기본운송료
	
//	2.Transportation의 생성자
//	  객체가 괄호안에 가지는 것은 기본운송료 값이다.
	Transportation(int basic_fare){
		BASIC_FARE = basic_fare;
	}
	
//	3.Transportation 객체의 기본운송료를 반환
	public int getBASIC_FARE() {
		return BASIC_FARE;
	}
	
//	4.Transportation 객체가 반드시 구현해야할 추상메소드
//	  파라미터는 요금을 계산하기 위한 거리값
	abstract int fare(int distance);
	
	
}
