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

## Array
---

### array 출력
 * 아래와 같은 3가지 방법이 있으며 결과는 동일하다.
``` javascript
const cities = ['seoul', 'incheon', 'busan'];

//for
for(let i = 0; i < cities.length; i++){
    console.log(cities[i]);
}

//for..of
for(let city of cities){
    console.log(city);
}

//forEach
cities.forEach((city) => console.log(city));
```
 * forEach의 파라미터로 함수를 넣어 사용할 수도 있다.
``` javascript
cities.forEach(function doCapitalize(city, index, array){
    const result =  city.charAt(0).toUpperCase() + city.slice(1, city.length);
    console.log(`capitalized: ${result}`);
});
-> capitalized: Seoul
-> capitalized: Incheon
-> capitalized: Busan
```

### puch, pop, unshift, shift
 * puch: 배열의 끝에 값을 추가
 * pop: 배열의 끝에서 부터 반환&제거
 * unshift: 배열의 시작에 값을 추가
 * shift: 배열의 처음부터 반환&제거
 * unshift, shift는 성능에 악영향을 끼친다.
 * 앞의 칸을 비우거나 채우기 위해 전체 데이터가 옮겨져야 하기 때문
``` javascript
cities.push('suwon', 'ilsan');
console.log(cities);
-> ["seoul", "incheon", "busan", "suwon", "ilsan"]

cities.pop();
console.log(cities);
-> ["seoul", "incheon", "busan", "suwon"]

cities.unshift('hanyang');
console.log(cities);
-> ["hanyang", "seoul", "incheon", "busan", "suwon"]

cities.shift();
console.log(cities);
-> ["seoul", "incheon", "busan", "suwon"]
``` 

### splice(startNum, [deleteCount], [obj], ..., [obj])
 * 배열의 startNum 부터 deleteCount개 만큼 반환&제거
 * deleteCount는 생략 가능- > startNum부터 전부 반환&제거
 * 그리고 제거된 자리에 obj, ..., obj를 넣는다.
``` javascript
-> ["seoul", "incheon", "busan", "suwon", "ilsan"]
const splicedCities = cities.splice(0, 2);
console.log(cities);
-> ["busan", "suwon"]

console.log(splicedCities);
-> ["seoul", "incheon"]

cities.splice(1, 1, 'seoul', 'incheon', 'ilsan');
console.log(cities);
-> ["busan", "seoul", "incheon", "ilsan"]
``` 

### concat
 * 배열 결합
``` javascript
const japanCities = ['tokyo','osaka'];
const globalCities = cities.concat(japanCities);
console.log(globalCities);
-> ["busan", "seoul", "incheon", "ilsan", "tokyo", "osaka"]
```

### indexOf, includes
 * indexOf(value): value의 위치를 반환(없으면 -1)
 * includes(value): value가 있는지를 true/false로 반환
``` javascript
console.log(globalCities.indexOf('tokyo'));   -> 4
console.log(globalCities.includes('nagoya')); -> false
console.log(globalCities.indexOf('nagoya'));  -> -1
```

### lastIndexOf(value)
 * value가 가장 마지막에 나타난 위치를 반환(없으면 -1)
``` javascript 
globalCities.push('tokyo');
-> ["busan", "seoul", "incheon", "ilsan", "tokyo", "osaka", "tokyo"]
console.log(globalCities.lastIndexOf('tokyo'));
-> 6
``` 

### join([구분자])
 * 배열을 문자열로 반환하는 함수
 * 구분자는 생략 가능하다.
``` javascript 
const fruits = ['apple', 'banana', 'orange'];
let allFruits = fruits.join(', ');
console.log(allFruits);
-> apple, banana, orange
``` 

### split(구분자, [num])
 * 문자열을 구분자를 기준으로 문자열 배열로 반환함
 * num은 생략이 가능하며, 구분자를 기준으로 num개를 가지는 배열을 반환함
``` javascript 
const strFruits2 = 'apple, kiwi, banana, cherry';
const arrFruits2 = strFruits2.split(',', 3);
arrFruits2.forEach(function (fruit, index, array){
    array[index] = fruit.trim();
});
console.log(arrFruits2);
-> ["apple", "kiwi", "banana"]
```

### reverse
 * 배열의 순서를 뒤집음
``` javascript 
const arrNumbers = [1, 2, 3, 4, 5];
arrNumbers.reverse();
console.log(arrNumbers);
-> [5, 4, 3, 2, 1]
```

### slice(num1, num2)
 * 배열의 num1 부터 num2 -1 만큼 반환
``` javascript
const arrNumbers2 = [1, 2, 3, 4, 5];
const arrResult2 = arrNumbers2.slice(1, 4);
console.log(arrResult2);
-> [2, 3, 4]
```

### find([value], [index], [array])
 * return 조건, 을 넣으면 조건에 맞는 배열의 요소가 반환됨
 * 조건에 맞는 요소를 찾는 순간 함수를 종료하므로 유일한 값을 가진 배열의 요소를 찾을 때 사용해야 함
``` javascript
const students = [
    new Student('A', 29, true, 45),
    new Student('B', 28, false, 80),
    new Student('C', 30, true, 90),
    new Student('D', 40, false, 66),
    new Student('E', 18, true, 90)
];

const findStudent = students.find((student) => {
    return student.name === 'D';
});
console.log(findStudent);
-> Student?{name: "D", age: 40, enrolled: false, score: 66}
```

### filter([value], [index], [array])
 * return 조건, 을 넣으면 조건에 맞는 배열의 요소가 반환됨
 * 조건에 맞는 요소들을 배열로 반환
``` javascript
const filterStudent = students.filter((value) => {
    return value.enrolled === true;
})
console.log(filterStudent);
-> 
 0: Student {name: "A", age: 29, enrolled: true, score: 45}
 1: Student {name: "C", age: 30, enrolled: true, score: 90}
 2: Student {name: "E", age: 18, enrolled: true, score: 90}
```

### map([value], [index], [array])
 * 배열의 요소들에서 특정 값만 뽑아 낼 때 사용
``` javascript
const mapStudent = students.map((student) => student.name);
console.log(mapStudent);
-> ["A", "B", "C", "D", "E"]
```

### some/every([value], [index], [array])
 * 조건을 가지고 true/false를 반환
 * some: 배열의 요소 중 조건에 하나라도 걸리면 true
 * every: 배열의 요소 전부가 조건에 부합해야 true
``` javascript
console.log(students.some((student) => student.score < 50));
-> true
console.log(students.every((student) => student.score > 50));
-> false
```

### reduce(prev, curr, index, array)
 * 배열에 있는 요소의 값을 누적
``` javascript
let sum = students.reduce((prev, curr) => {
    console.log(prev + '+' + curr.score);
    return prev + curr.score;
}, 0); // <- 0은 prev 값 지정
console.log(`sum: ${sum}`);
-> 0+45
-> 45+80
-> 125+90
-> 215+66
-> 281+90
-> sum: 371
```

### sort
 * 기본은 오름차순
``` javascript
// 내림차순으로 정렬
const complexResult = students
    .map((student) => student.score)
    .sort()
    .reverse();

console.log(complexResult);
-> [90, 90, 80, 66, 45]

//더 효율적인 방법
const complexResult = students
    .map((student) => student.score)
    .sort((a, b) => b - a);
    //식의 결과가 음수이면 자리를 바꾸는 구조
    //a - b 가 오름차순

console.log(complexResult);
-> [90, 90, 80, 66, 45]
```

## JSON(JavaScript Object Notation)
---

### JSON 특징
 * JSON은 자바스크립트를 확장하여 만들어짐
 * JSON은 자바스크립트 객체 표기법을 따름
 * JSON은 사람과 기계가 모두 읽기 편함
 * JSON은 프로그래밍 언어와 운영체제에 독립적

### stringify: Object to JSON
 * Object를 JSON으로 serialize
 * 리스트 배열은 ["A", "B"...]
 * 맵 배열은 {"a":"A", "b": "B"...} 형식을 가진다.
 * ['key1', 'key2'..]을 파라미터로 넣으면 해당 키만 stringify 한다.
 * callback함수를 사용할 수 있다.
``` javascript
let json = JSON.stringify(['apple', 'banana']);
console.log(json);
-> ["apple","banana"]

const rabbit = {
    name: 'tori',
    color: 'white',
    size: null,
    birthDate: new Date(),
    jump: () => {
        console.log(`${name} cam jump!`);
    }
};

const jsonRabbit = JSON.stringify(rabbit);
console.log(jsonRabbit);
-> {"name":"tori","color":"white","size":null,"birthDate":"2021-05-30T06:06:55.507Z"}

const jsonRabbitKey = JSON.stringify(rabbit, ['name', 'color']);
console.log(jsonRabbitKey);
-> {"name":"tori","color":"white"}

const jsonRabbitKeyValue = JSON.stringify(rabbit, (key, value) => {
    console.log(`key: ${key}, value: ${value}`);
    //return key === 'name' ? 'woogie' : value;
    return key === 'name' ? 'woogie' : value, key === 'size' ? 74 : value;
});
console.log(jsonRabbitKeyValue);
-> {"name":"tori","color":"white","size":74,"birthDate":"2021-05-30T06:06:55.507Z"}
```

### parse: JSON to Object
 * JSON을 Object로 unserialize
 * 
``` javascript
const objectRabbit = JSON.parse(jsonRabbit);
console.log(objectRabbit.birthDate);
-> 2021-05-30T06:21:37.119Z
//Object -> JSON -> Object가 되면 Date() 객체였던 birthDate가 평범한 문자열로 취급되어 함수(getDate())를 사용할 수 없게 된다.

console.log(rabbit.birthDate.getDate());
-> 30

const objecgtRabbitPerfect = JSON.parse(jsonRabbit, (key, value) => {
    //console.log(`key: ${key}, value: ${value}`);
    return key === 'birthDate' ? new Date(value) : value;
});
console.log(objecgtRabbitPerfect.birthDate.getDate());
-> 30
```

## Promise
---

### promise 개념
 * 자바스크립트에서 제공하는 비동기를 간편하게 처리할 수 있도록 하는 오브젝트
 * 정해진 장시간의 기능을 수행하고 나서, 정상적으로 기능이 수행이 되었다면 성공의 메시지와 함께 처리된 결과값을 전달 해줌
 * 만약 기능을 수행하다가 오류가 나면 에러를 전달 해줌
 * ex) 아직 완성 되지 않은 A라는 제품을 펀딩
   1. 제품을 펀딩한다.
   2. 제품이 완성될 때 까지 기다린다.
   3. 제품을 받는다.
 * ex) 이미 완성된 위의 제품 A를 구매
   1. 제품을 구매한다.
   3. 제품을 받는다.
 * 위와 같은 과정이 promise
 * State: pending -> fulfiled or rejected
 * Producer vs Consumer

### promise 생성/사용
 * 새로운 promise 객체를 만들면 함께 선언한 excuter 함수가 동시에 실행 된다.
 * Promise 객체
   * resolve -> 성공시 처리
   * reject -> 실패시 처리
 * Promise 객체 실행 시 
   * then: promise의 resolve 실행
   * catch: promise의 reject 실행
   * finally: 무조건 실행
``` javascript
class User {
    constructor(id, pw){
        this.id = id;
        this.pw = pw;
    }
    
    doShowList(list) { //배열 리스트를 건네주면 출력하는 함수
        list.forEach(element => {
            console.log(element);
        });
    }

    doSignin(list, id, pw){ 
        //promise를 사용하여 코드 간소화
        return new Promise((resolve, reject) => {
            const flag = list.some(user => {
                //배열 클래스 함수인 some은 조건에 따른 true/false 를 반환
                return user.id === id && user.pw === pw;
            });
            if(flag){ //성공하면 resolve
                resolve(id);
            } else { //실패하면 reject
                reject('id or pw is not correct');
            }
        })
    }

    moveToMain(){ //로그인 성공시 호출되는 함수
        console.log('main page');
    }

}

const userList = [ //회원명부
    new User('woogie1', '123'),
    new User('woogie2', '456'),
    new User('woogie3', '789')
];

const user = new User();

const id = prompt('id');
const pw = prompt('pw');

user.doSignin(userList, id, pw)
    .then(id => { //id <- resolve에서 받아온 파라미터
        console.log(`Welcome ${id}`);
        user.moveToMain();
    })
    .catch(error => { //error <- reject에서 받아온 파라미터
        alert(error);
    })
    .finally(console.log('process over'))
;
```

## aync & await
---

### 개념
 * aync
   * promise를 사용하지 않고 함수를 비동기로 만드는 역할을 함
   * return 값은 항상 promise다
 * await
   * async가 붙은 함수의 안에서만 사용 될 수 있음
   * 비동기 함수를 동기적으로 만듬(수행이 완료될 때까지 기다리게 함)
``` javascript
function deley(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

//1.5초를 기다리지 않고 바로 다음 코드를 수행
async function walk(id) {
    deley(1500); 
    return `${id} arrived`;
}

//1초를 기다리고 나서 다음 코드를 수행
async function run(id) {
    await deley(1000); 
    return `${id} arrived`;
}

//먼저 수행된 비동기 함수의 결과 값을 반환
async function doRace(id1, id2) {
    return Promise.race([walk(id1), run(id2)]);    
}

//파라미터로 입력된 모든 비동기 함수가 처리된 후에 그 결과물들을 반환
async function arrive(id1, id2) {
    return Promise.all([walk(id1), run(id2)])
        .then(name => name.join(', '));
}

doRace('woogie', 'umi').then(result => console.log(`race winner: ${result}`));
-> race winner: woogie arrived

//받아오는 값을 바로 파라미터로 사용할 경우 둘 다 생략이 가능하다.
arrive('woogie', 'umi').then(console.log);
-> woogie arrived, umi arrived
```

