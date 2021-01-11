package java_api_class;

//에너테이션(annotaion)
//주석처럼 프로그래밍 언어에 영향을 미치지 않으며 유용한 정보를 제공

public class G_Annotation {

//	현재사용하는 변수와 메소드
	int newFile;
	public int getNewFile() {
		return newFile;
	}
	
//	이제는 사용하지 않는 변수와 메소드
//	@Deprecated를 붙혀줌으로써 "앞으로 사용하지 않을 것이니 가급적 사용금지" 라는 의미를 줌
	
	@Deprecated
	int oldFile;
	@Deprecated
	public int getOldFile() {
		return oldFile;
	}
	
	public static void main(String[] args) {

		G_Annotation anno = new G_Annotation();
		
		//사용가능
		anno.newFile = 5;
		anno.getNewFile();
		
		//사용은 가능하지만 권장되지 않음
		anno.oldFile = 3;
		anno.getOldFile();
		
	}
	
//	@Overide: 컴파일러에게 오버라이딩하는 메서드라는 것을 알린다.
//	@Deprecated: 앞으로 사용하지 않을 것이니 가급적 사용금지
//	@SuppressWarnings: 컴파일러의 특정 경고 메시지가 나타나지 않게 해준다.
//	@SafeVargans: 지네릭스 타입의 가변인자에 사용
//	@FunctionalInterface: 함수형 인터페이스라는 것을 알린다.
//	@Native native메서드에서 참조되는 상수 앞에 붙인다(자바의 메서드가 아님 시스템에 있는[ex)C]메서드)
//
//	Annotation을 만들기위한 Annotation
//	@Target: 애터테이션 적용대상을 지정
//	@Documented: 애너테이션 정보가 javadoc에 포함되게 지정
//	@Inherited: 애너테이션 자손 클래스에 상속되도록 지정
//	@Retentic: 애너테이션이 유지되는 범위
//	@Repeatable: 애너테이션이 반복해서 적용할 수 있게 한다.

}
