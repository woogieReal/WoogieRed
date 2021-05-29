### async vs defer
 * 브라우저는 html파일을 한줄 한줄 읽어 내려가며 읽는다.
 * 자바스크립트 파일을 head 또는 body의 제일 맡에 놓는 것은 둘 다 단점이 있다.
   * head 태그 내에 위치할 경우 js파일의 크기가 클 경우 html을 읽는 것이 느려져 웹화면 로드가 느려진다.
   * body 태그의 가장 밑에 위치하면 자바스크립트에 의존적일 경우 좋지 않음
 * async 옵션
   * 기본값이 true
   * js파일을 만나면 다운로드 하면서 html을 읽어 들이다가 다운로드가 완료되면 js파일을 실행함
   * 여러 개의 js 파일이 있을 경우 작성순서가 아니라 다운로드가 완료된 순서부터 실행됨
   * 장점
     * 파싱을 병렬적으로 이루어지도록 함
   * 단점
     * js파일이 다 다운로드가 완료되기 전에 html에 원하는 요소가 정의되지 않을 수 있음
	 * 언제든지 js파일을 다운로드되면서 멈출 수 있음
 * defer 옵션
   * js파일을 만나면 다운로드를 시작, html을 다 읽어 들이고나서 js파일을 실행
   * 제일 좋은 옵션
   * 여러 개의 js 파일이 있을 경우 작성순서대로 실행됨
   * js파일이 순서에 의존적일 경우 defer 옵션 방식이 좋다.
   
### 'use strict';
 * ECMAScript 5에서 추가
 * 타입스크립트의 경우 선언할 필요가 없음
 * 자바스크립트의 경우 유연한 문법이기 때문에 오류가 나도 오류를 찾기 힘듬
 * 위의 코드를 넣으면 문법을 더 엄격하게 잡음
 * 꼭 넣고 하자!

## primative
---

### let
 * Mutable

### const
 * Inmutable
 * 변수를 선언함과 동시에 값을 할당하면 변경할 수 없음
 * 자바의 상수(final)과 같음
 * 값이 변할 일이 없다면 웬만하면 const를 사용
 * thread safety
 
### first-class function(일급함수)
 * 함수를 변수나 자료구조에 저장할 수 있음
 * 함수의 매개변수(인자)에 다른 함수를 인수로 전달할 수 있음
 * 함수의 반환 값(return 값)으로 함수를 전달할 수 있음
 
### Infinity/-Infinity
``` javascript
console.log(1/0);  -> Infinity
console.log(-1/0); -> -Infinity
```

### typeof
 * 변수의 타입을 돌려줌
``` javascript
const hour = 24;
const myNation = 'korea';
console.log(typeof hour);      -> number
console.log(typeof myNation);  -> string
```

### ` ` 기호
``` javascript
const hour = 24;
console.log('value: ' + hour); -> value: 24
console.log(`value: ${hour}`); -> value: 24
결과는 동일함
```

### boolean
 * false : 0, null, undefined, NaN, ''
 * true  : any other value;
 
### null/undefined
 * null은 변수의 값으로 null이 할당 된 경우
 * undefined는 변수는 선언 되었지만 값이 할당 되지 않은 경우

### sysmbol
 * create unique identifiers for objects
``` javascript
const symbol1 = Symbol('anything');
const symbol2 = Symbol('anything');

console.log(symbol1 == symbol2);    -> false

const gSymbol1 = Symbol.for('anything');
const gSymbol2 = Symbol.for('anything');

console.log(gSymbol1 == gSymbol2);  -> true

console.log(`value: ${symbol1.description}, type: ${typeof symbol}`);
```
 * description 을 붙여서 string으로 만들어야 출력 가능
 
### Dynamic typing: dynamically typed language
 * 선언할 때 어떤 타입인지 선언하지 않고 프로그램이 동작할 때 할당된 값에 따라 타입이 변경되는 것
 * 이를 해결하기 위한 것이 변수를 선언할 때 타입을 선언하는 타입스크립트
``` javascript
let text = 'hello';
console.log(`value: ${text}, type: ${typeof text}`);
-> value: hello, type: string

text = 8;
console.log(`value: ${text}, type: ${typeof text}`);
-> value: 8, type: number

text = '8' + 5;
console.log(`value: ${text}, type: ${typeof text}`);
-> value: 85, type: string

text = '8' / 2;
console.log(`value: ${text}, type: ${typeof text}`); 
-> value: 4, type: number
```

## Operator
---

### ++, -- operator
 * 자바의 증감연산자와 동일
``` javascript
let testNumPlus = 3;
const resultNumPlus = ++testNumPlus;
console.log(`testNumPlus: ${testNumPlus}`);
console.log(`resultNumPlus: ${resultNumPlus}`);
-> testNumPlus: 4
-> resultNumPlus: 4

let testNumMinus = 3;
const resultNumMinus = testNumMinus--;
console.log(`testNumMinus: ${testNumMinus}`);
console.log(`resultNumMinus: ${resultNumMinus}`);
-> testNumMinus: 2
-> resultNumMinus: 3
```

### logical operator
 * ||(or), &&(and), !(not)
 * || 의 경우 조건(들)을 차례로 체크하며 true가 나오는 순간 멈춘다.
 * expression이나 함수 등의 연산이 필요한 조건은 뒤로 빼는 것이 효율적
 * && 의 경우도 마찬가지. false 가 나오는 순간 멈춘다.
``` javascript
const condition1 = true;
const condition2 = 1 < 2;
function condition3() {
    for(let i = 1; i < 10; i++){
        console.log(i);
    }
    return true;
}

console.log(`or: ${condition1 || condition2 || condition3()}`);
-> or: true
```

### equality
 * ==, ===
 * ==
   * loose equality, with type conversion
   * 타입을 맞추어 값을 비교
   * '5' == 5 -> true
 * ===
   * strict equality, no type conversion
   * 타입과 값을 함께 비교
   * 웬만하면 이쪽을 쓰자
   * '5' === 5 -> false
 * object 끼리 비교
``` javascript
const object1 = {nm: 'woogie', age: 28};
const object2 = {nm: 'woogie', age: 28};
const object3 = object1;

console.log(object1.nm === object2.nm); -> true
console.log(object1 === object2);       -> false
console.log(object1 === object3);       -> true
```
 * 참고
``` javascript 
console.log(0 == false);           -> true
console.log(0 === false);          -> false
console.log('' == false);          -> true
console.log('' === false);         -> false
console.log(null == undefined);    -> true
console.log(null === undefined);   -> false
```

### Ternary operator: ?
 * 조건에 따른 간단한 로직일 때만 사용
``` javascript 
let conditionTernary = 'woogie';
let resultNumTernary = 0;
if(conditionTernary === 'woogie' ? resultNumTernary = 1 : resultNumTernary = 0);
console.log(resultNumTernary); -> 1
```

### switch
 * 조건에 따른 로직이 같은 경우에는 아래와 같이 쓸 수 있다.
``` javascript 
let conditionSwitch = 'woogie3';
let resultSwitch1 = '1';
let resultSwitch2 = '2';
let resultSwitch3 = '3or4';
switch(conditionSwitch){
    case 'woogie1':
        console.log(resultSwitch1);
        break;
    case 'woogie2':
        console.log(resultSwitch2);
        break;
    case 'woogie3':
    case 'woogie4':
        console.log(resultSwitch3);
        break;
} -> 3or4
```

## function
---

### 명명규칙
 * 변수명은 명사, 함수명은 동사로
   * doPunching, punch

### 함수의 특징
 * 자바스크립트에서 함수는 object이다
 * 변수에 함수를 할당할 수 있다는 뜻

### default 파라미터
 * 파라미터 값이 없을 때 기본값이 할당 된다.
``` javascript 
const myNm = 'woogie';

function sayHello(whoNm = 'everyOne'){
    console.log(`Hi, ${whoNm}`);
}

sayHello(myNm); -> Hi, woogie
sayHello();     -> Hi, everyOne
```

### rest 파라미터
 * 배열 형태로 전달되는 파라미터
``` javascript 
function showList(...args){
    for(let i = 0; i < args.length; i++){
        console.log(args[i]);
    }

    for(const arg of args){
        console.log(arg);
    }

    args.forEach((arg) => console.log(arg));
}
showList('woogie1', 'woogie2', 'woogie3');
-> woogie1
-> woogie2
-> woogie3 로 결과는 같음
```
### early return, early exit
 * 조건이 안맞는 경우를 먼저 체크해서 빨리 리턴 시켜라
 * 코드의 가독성이 좋아짐
``` javascript 
function showNumber(num){
    if(num > 10){
        return;
    }

    num += 10;
    console.log('plus 10');

    return num;
}

const resultNum = showNumber(15);
console.log(`result: ${resultNum}`);
-> result: undefined
```

### anonymous function
 * 변수에 할당해서 함수를 사용가능
``` javascript
const sayAnonymous = function(){
    console.log('say');
    console.log('anonymous');
}

sayAnonymous();
```
### callback
 * 함수의 파라미터로 함수를 보낼 수 있다.
``` javascript
const sayYes = function() {
    console.log('Yes');
}

const sayNo = function() {
    console.log('No');
}

doMark('woogie', sayYes, sayNo);

function doMark(answer, func1, func2){
    if(answer === 'woogie' ? func1() : func2());
}
```

### arrow function
 * 항상 이름이 없는 anonymous function
 * function이라는 키워드를 쓸 필요가 없다
 * 괄호를 쓰지 않으면 return 이라는 키워드를 사용할 필요도 없다.
``` javascript
const addSimple = (a,b) => a+b;
const addComplex = (a,b) => {
    return a+b;
}

console.log(addSimple(1,5));  -> 6
console.log(addComplex(1,5)); -> 6
```

### IIFE: Immediately Invoked Function Expression
 * 선언함과 동시에 호출되는 함수
``` javascript
(
    function iifeFunction() {
        console.log('Call immediately');
    }
)(); 
-> Call immediately
```

## Class
---

### class 생성과 사용
 * static 메소드의 개념과 사용법은 자바와 동일함
 * getter와 setter에서 this + 언더바(_)를 붙여주지 않으면 스택 오버플로가 됨
 * #을 붙히면 자바의 private과 동일한 성질을 띄나 아직 지원하는 브라우저가 적음 -> 현재는 사용자제
``` javascript
class Person {
    static species = 'human';

    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    
    get name() {
        return this._name;
    }
    
    set name(value) {
        this._name = value;
    }
    
    get age() {
        return this._age;
    }
    
    set age(value) {
        this._age = value < 0 ? 0 : value;
        //set한 age가 음수일 경우 0으로 처리함(안정성을 위해)
    }

    toString() {
        return `name: ${this.name} and age: ${this.age}`;
    }

    speak() {
        console.log(`${this.name}, hello!`);
    }

    static saySpecies(){
        console.log(`We are ${this.species}`);
    }

}
```
 * 자바와 유사하게 사용가능
``` javascript
const woogie = new Person('woogie', -5);

console.log(woogie);          -> Person?{_name: "woogie", _age: 0}
console.log(woogie.name);     -> woogie
console.log(woogie.age);      -> 0
							  
woogie.age = 28;              
							  
console.log(woogie);          -> Person?{_name: "woogie", _age: 28}
console.log(woogie.name);     -> woogie
console.log(woogie.age);      -> 28
							  -> 
woogie.speak();               -> woogie, hello!
							  -> 
console.log(Person.species);  -> human
Person.saySpecies();          -> We are human
``` 

### 상속과 다형성
 * 자바와 마찬가지로 상속을 사용할 수 있음
 * 메소드 오버라이딩이 가능함
 * super.함수이름() 이면 부모 클래스의 함수를 사용 가능
``` javascript
class Korean extends Person {}

const koreanWoogie = new Korean('우기', 28);
console.log(koreanWoogie); -> Korean?{_name: "우기", _age: 28}
koreanWoogie.speak(); -> 우기, hello!

class Japaneese extends Person {
    //메소드 오버라이딩
    speak() {
        console.log(`${this.name}, おはよう!`);
    }

    orgSpeak() {
        super.speak();
    }
}

const JapaneeseWoogie = new Japaneese('ウギ', 28);
console.log(JapaneeseWoogie); -> Japaneese?{_name: "ウギ", _age: 28}
JapaneeseWoogie.speak();     -> ウギ, おはよう!
JapaneeseWoogie.orgSpeak();  -> ウギ, hello!
```

### instanceOf
 * 해당 클래스의 객체가 맞는 지 true와 false를 반환
 * 모든 클래스는 자바와 마찬가지로 Object를 상속 받는다.
``` javascript
console.log(koreanWoogie instanceof Korean);    -> true
console.log(koreanWoogie instanceof Japaneese); -> false
console.log(koreanWoogie instanceof Person);    -> true
console.log(koreanWoogie instanceof Object);    -> true
```

## Object
---

### literals and properties
 * class가 없어도 key와 value을 가진 쌍으로 만들 수 있다.
 * 자바스크립트는 dynamically typed language 이기 때문에 Object 선언 후에도 key를 선언/삭제가 가능하다.
 * 하지만 유지보수 측면에서 좋지 않다.
``` javascript
let person = {name: 'woogie', age: 28};
console.log(person);      -> {name: "woogie", age: 28}

person.nation = 'Korea';
console.log(person);      -> {name: "woogie", age: 28, nation: "Korea"}

delete person.nation;
console.log(person);      -> {name: "woogie", age: 28}
```

### computed properties
 * 객체.key 또는 객체['key'] 두 가지로 접근 가능
 * 주로 런타임 시에 동적으로 key를 주고 값을 받아야 할 때 사용한다.
 * 마찬가지로 선언 후에도 key값을 선언/삭제 가능
``` javascript
function printValue(obj, key) {
    console.log(obj[key]);
}

printValue(person, 'name');   -> woogie
printValue(person, 'age');    -> 28
```

### constructor function
 * class의 생성자 처럼 사용
``` javascript
function Person(name, age) {
    this.name = name;
    this.age = age;
}

let person2 = new Person('woogie2', 25);
console.log(person2);  -> Person?{name: "woogie2", age: 25}
```

### in operator
 * 해당하는 오브젝트 안에 key가 있는지 없는지 확인 하는 것
``` javascript
console.log('name' in person);    -> true
console.log('nation' in person);  -> false
```


### for..in, for..of
 * for..in: 맵구조의 객체에서 key 값을 기준으로 value를 뽑아내는 방법
 * for..of: 리스트 구조의 객체에서 값을 뽑아내는 방법
``` javascript
for(let key in person){
    console.log(person[key]);
}
-> woogie
-> 28

const array = [1,2,3,4];
for(let value of array){
    console.log(value);    
}
-> 1
-> 2
-> 3
-> 4
```

### cloning
 * Object.assign을 이용하여 참조하는 메모리가 아예 다른 객체를 만든다.
``` javascript
const user1 = {name: 'woogie', level: 20};
const user2 = user1;

user2.level = 30;
console.log(user1.level); -> 30

const user3 = Object.assign({}, user1);
user3.level = 40;
console.log(user1.level); -> 30
```
 * assign에는 복사하는 파라미터를 여러 개 지정하여 합칠 수 있다.
 * 중복되는 key의 value는 후자의 value 값을 가진다.
``` javascript
const user4 = {level: 50, job: 'magician'};
const user5 = Object.assign({}, user3, user4);
console.log(user5);
-> {name: "woogie", level: 50, job: "magician"}
```


 

