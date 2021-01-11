package g_generics;

//제한된 지네릭 클래스
//타입의 종류를 제한할 수 있다.
//ex)지네릭타입에 'extends'를 사용하면 특정타입의 자손들만 대입할 수 있게 제한

//Box클래스를 상속함
//Fruit을 상속한 자손만 타입으로 지정가능(Apple,Grape)
public class FruitBox<T extends Fruit> extends Box<T> {

}
