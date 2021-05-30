### async vs defer
 * �������� html������ ���� ���� �о� �������� �д´�.
 * �ڹٽ�ũ��Ʈ ������ head �Ǵ� body�� ���� �ÿ� ���� ���� �� �� ������ �ִ�.
   * head �±� ���� ��ġ�� ��� js������ ũ�Ⱑ Ŭ ��� html�� �д� ���� ������ ��ȭ�� �ε尡 ��������.
   * body �±��� ���� �ؿ� ��ġ�ϸ� �ڹٽ�ũ��Ʈ�� �������� ��� ���� ����
 * async �ɼ�
   * �⺻���� true
   * js������ ������ �ٿ�ε� �ϸ鼭 html�� �о� ���̴ٰ� �ٿ�ε尡 �Ϸ�Ǹ� js������ ������
   * ���� ���� js ������ ���� ��� �ۼ������� �ƴ϶� �ٿ�ε尡 �Ϸ�� �������� �����
   * ����
     * �Ľ��� ���������� �̷�������� ��
   * ����
     * js������ �� �ٿ�ε尡 �Ϸ�Ǳ� ���� html�� ���ϴ� ��Ұ� ���ǵ��� ���� �� ����
	 * �������� js������ �ٿ�ε�Ǹ鼭 ���� �� ����
 * defer �ɼ�
   * js������ ������ �ٿ�ε带 ����, html�� �� �о� ���̰��� js������ ����
   * ���� ���� �ɼ�
   * ���� ���� js ������ ���� ��� �ۼ�������� �����
   * js������ ������ �������� ��� defer �ɼ� ����� ����.
   
### 'use strict';
 * ECMAScript 5���� �߰�
 * Ÿ�Խ�ũ��Ʈ�� ��� ������ �ʿ䰡 ����
 * �ڹٽ�ũ��Ʈ�� ��� ������ �����̱� ������ ������ ���� ������ ã�� ����
 * ���� �ڵ带 ������ ������ �� �����ϰ� ����
 * �� �ְ� ����!

## primative
---

### let
 * Mutable

### const
 * Inmutable
 * ������ �����԰� ���ÿ� ���� �Ҵ��ϸ� ������ �� ����
 * �ڹ��� ���(final)�� ����
 * ���� ���� ���� ���ٸ� �����ϸ� const�� ���
 * thread safety
 
### first-class function(�ϱ��Լ�)
 * �Լ��� ������ �ڷᱸ���� ������ �� ����
 * �Լ��� �Ű�����(����)�� �ٸ� �Լ��� �μ��� ������ �� ����
 * �Լ��� ��ȯ ��(return ��)���� �Լ��� ������ �� ����
 
### Infinity/-Infinity
``` javascript
console.log(1/0);  -> Infinity
console.log(-1/0); -> -Infinity
```

### typeof
 * ������ Ÿ���� ������
``` javascript
const hour = 24;
const myNation = 'korea';
console.log(typeof hour);      -> number
console.log(typeof myNation);  -> string
```

### ` ` ��ȣ
``` javascript
const hour = 24;
console.log('value: ' + hour); -> value: 24
console.log(`value: ${hour}`); -> value: 24
����� ������
```

### boolean
 * false : 0, null, undefined, NaN, ''
 * true  : any other value;
 
### null/undefined
 * null�� ������ ������ null�� �Ҵ� �� ���
 * undefined�� ������ ���� �Ǿ����� ���� �Ҵ� ���� ���� ���

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
 * description �� �ٿ��� string���� ������ ��� ����
 
### Dynamic typing: dynamically typed language
 * ������ �� � Ÿ������ �������� �ʰ� ���α׷��� ������ �� �Ҵ�� ���� ���� Ÿ���� ����Ǵ� ��
 * �̸� �ذ��ϱ� ���� ���� ������ ������ �� Ÿ���� �����ϴ� Ÿ�Խ�ũ��Ʈ
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
 * �ڹ��� ���������ڿ� ����
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
 * || �� ��� ����(��)�� ���ʷ� üũ�ϸ� true�� ������ ���� �����.
 * expression�̳� �Լ� ���� ������ �ʿ��� ������ �ڷ� ���� ���� ȿ����
 * && �� ��쵵 ��������. false �� ������ ���� �����.
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
   * Ÿ���� ���߾� ���� ��
   * '5' == 5 -> true
 * ===
   * strict equality, no type conversion
   * Ÿ�԰� ���� �Բ� ��
   * �����ϸ� ������ ����
   * '5' === 5 -> false
 * object ���� ��
``` javascript
const object1 = {nm: 'woogie', age: 28};
const object2 = {nm: 'woogie', age: 28};
const object3 = object1;

console.log(object1.nm === object2.nm); -> true
console.log(object1 === object2);       -> false
console.log(object1 === object3);       -> true
```
 * ����
``` javascript 
console.log(0 == false);           -> true
console.log(0 === false);          -> false
console.log('' == false);          -> true
console.log('' === false);         -> false
console.log(null == undefined);    -> true
console.log(null === undefined);   -> false
```

### Ternary operator: ?
 * ���ǿ� ���� ������ ������ ���� ���
``` javascript 
let conditionTernary = 'woogie';
let resultNumTernary = 0;
if(conditionTernary === 'woogie' ? resultNumTernary = 1 : resultNumTernary = 0);
console.log(resultNumTernary); -> 1
```

### switch
 * ���ǿ� ���� ������ ���� ��쿡�� �Ʒ��� ���� �� �� �ִ�.
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

### ����Ģ
 * �������� ���, �Լ����� �����
   * doPunching, punch

### �Լ��� Ư¡
 * �ڹٽ�ũ��Ʈ���� �Լ��� object�̴�
 * ������ �Լ��� �Ҵ��� �� �ִٴ� ��

### default �Ķ����
 * �Ķ���� ���� ���� �� �⺻���� �Ҵ� �ȴ�.
``` javascript 
const myNm = 'woogie';

function sayHello(whoNm = 'everyOne'){
    console.log(`Hi, ${whoNm}`);
}

sayHello(myNm); -> Hi, woogie
sayHello();     -> Hi, everyOne
```

### rest �Ķ����
 * �迭 ���·� ���޵Ǵ� �Ķ����
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
-> woogie3 �� ����� ����
```
### early return, early exit
 * ������ �ȸ´� ��츦 ���� üũ�ؼ� ���� ���� ���Ѷ�
 * �ڵ��� �������� ������
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
 * ������ �Ҵ��ؼ� �Լ��� ��밡��
``` javascript
const sayAnonymous = function(){
    console.log('say');
    console.log('anonymous');
}

sayAnonymous();
```
### callback
 * �Լ��� �Ķ���ͷ� �Լ��� ���� �� �ִ�.
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
 * �׻� �̸��� ���� anonymous function
 * function�̶�� Ű���带 �� �ʿ䰡 ����
 * ��ȣ�� ���� ������ return �̶�� Ű���带 ����� �ʿ䵵 ����.
``` javascript
const addSimple = (a,b) => a+b;
const addComplex = (a,b) => {
    return a+b;
}

console.log(addSimple(1,5));  -> 6
console.log(addComplex(1,5)); -> 6
```

### IIFE: Immediately Invoked Function Expression
 * �����԰� ���ÿ� ȣ��Ǵ� �Լ�
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

### class ������ ���
 * static �޼ҵ��� ����� ������ �ڹٿ� ������
 * getter�� setter���� this + �����(_)�� �ٿ����� ������ ���� �����÷ΰ� ��
 * #�� ������ �ڹ��� private�� ������ ������ �糪 ���� �����ϴ� �������� ���� -> ����� �������
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
        //set�� age�� ������ ��� 0���� ó����(�������� ����)
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
 * �ڹٿ� �����ϰ� ��밡��
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

### ��Ӱ� ������
 * �ڹٿ� ���������� ����� ����� �� ����
 * �޼ҵ� �������̵��� ������
 * super.�Լ��̸�() �̸� �θ� Ŭ������ �Լ��� ��� ����
``` javascript
class Korean extends Person {}

const koreanWoogie = new Korean('���', 28);
console.log(koreanWoogie); -> Korean?{_name: "���", _age: 28}
koreanWoogie.speak(); -> ���, hello!

class Japaneese extends Person {
    //�޼ҵ� �������̵�
    speak() {
        console.log(`${this.name}, ���Ϫ誦!`);
    }

    orgSpeak() {
        super.speak();
    }
}

const JapaneeseWoogie = new Japaneese('����', 28);
console.log(JapaneeseWoogie); -> Japaneese?{_name: "����", _age: 28}
JapaneeseWoogie.speak();     -> ����, ���Ϫ誦!
JapaneeseWoogie.orgSpeak();  -> ����, hello!
```

### instanceOf
 * �ش� Ŭ������ ��ü�� �´� �� true�� false�� ��ȯ
 * ��� Ŭ������ �ڹٿ� ���������� Object�� ��� �޴´�.
``` javascript
console.log(koreanWoogie instanceof Korean);    -> true
console.log(koreanWoogie instanceof Japaneese); -> false
console.log(koreanWoogie instanceof Person);    -> true
console.log(koreanWoogie instanceof Object);    -> true
```

## Object
---

### literals and properties
 * class�� ��� key�� value�� ���� ������ ���� �� �ִ�.
 * �ڹٽ�ũ��Ʈ�� dynamically typed language �̱� ������ Object ���� �Ŀ��� key�� ����/������ �����ϴ�.
 * ������ �������� ���鿡�� ���� �ʴ�.
``` javascript
let person = {name: 'woogie', age: 28};
console.log(person);      -> {name: "woogie", age: 28}

person.nation = 'Korea';
console.log(person);      -> {name: "woogie", age: 28, nation: "Korea"}

delete person.nation;
console.log(person);      -> {name: "woogie", age: 28}
```

### computed properties
 * ��ü.key �Ǵ� ��ü['key'] �� ������ ���� ����
 * �ַ� ��Ÿ�� �ÿ� �������� key�� �ְ� ���� �޾ƾ� �� �� ����Ѵ�.
 * ���������� ���� �Ŀ��� key���� ����/���� ����
``` javascript
function printValue(obj, key) {
    console.log(obj[key]);
}

printValue(person, 'name');   -> woogie
printValue(person, 'age');    -> 28
```

### constructor function
 * class�� ������ ó�� ���
``` javascript
function Person(name, age) {
    this.name = name;
    this.age = age;
}

let person2 = new Person('woogie2', 25);
console.log(person2);  -> Person?{name: "woogie2", age: 25}
```

### in operator
 * �ش��ϴ� ������Ʈ �ȿ� key�� �ִ��� ������ Ȯ�� �ϴ� ��
``` javascript
console.log('name' in person);    -> true
console.log('nation' in person);  -> false
```


### for..in, for..of
 * for..in: �ʱ����� ��ü���� key ���� �������� value�� �̾Ƴ��� ���
 * for..of: ����Ʈ ������ ��ü���� ���� �̾Ƴ��� ���
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
 * Object.assign�� �̿��Ͽ� �����ϴ� �޸𸮰� �ƿ� �ٸ� ��ü�� �����.
``` javascript
const user1 = {name: 'woogie', level: 20};
const user2 = user1;

user2.level = 30;
console.log(user1.level); -> 30

const user3 = Object.assign({}, user1);
user3.level = 40;
console.log(user1.level); -> 30
```
 * assign���� �����ϴ� �Ķ���͸� ���� �� �����Ͽ� ��ĥ �� �ִ�.
 * �ߺ��Ǵ� key�� value�� ������ value ���� ������.
``` javascript
const user4 = {level: 50, job: 'magician'};
const user5 = Object.assign({}, user3, user4);
console.log(user5);
-> {name: "woogie", level: 50, job: "magician"}
```

## Array
---

### array ���
 * �Ʒ��� ���� 3���� ����� ������ ����� �����ϴ�.
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
 * forEach�� �Ķ���ͷ� �Լ��� �־� ����� ���� �ִ�.
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
 * puch: �迭�� ���� ���� �߰�
 * pop: �迭�� ������ ���� ��ȯ&����
 * unshift: �迭�� ���ۿ� ���� �߰�
 * shift: �迭�� ó������ ��ȯ&����
 * unshift, shift�� ���ɿ� �ǿ����� ��ģ��.
 * ���� ĭ�� ���ų� ä��� ���� ��ü �����Ͱ� �Ű����� �ϱ� ����
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
 * �迭�� startNum ���� deleteCount�� ��ŭ ��ȯ&����
 * deleteCount�� ���� ����- > startNum���� ���� ��ȯ&����
 * �׸��� ���ŵ� �ڸ��� obj, ..., obj�� �ִ´�.
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
 * �迭 ����
``` javascript
const japanCities = ['tokyo','osaka'];
const globalCities = cities.concat(japanCities);
console.log(globalCities);
-> ["busan", "seoul", "incheon", "ilsan", "tokyo", "osaka"]
```

### indexOf, includes
 * indexOf(value): value�� ��ġ�� ��ȯ(������ -1)
 * includes(value): value�� �ִ����� true/false�� ��ȯ
``` javascript
console.log(globalCities.indexOf('tokyo'));   -> 4
console.log(globalCities.includes('nagoya')); -> false
console.log(globalCities.indexOf('nagoya'));  -> -1
```

### lastIndexOf(value)
 * value�� ���� �������� ��Ÿ�� ��ġ�� ��ȯ(������ -1)
``` javascript 
globalCities.push('tokyo');
-> ["busan", "seoul", "incheon", "ilsan", "tokyo", "osaka", "tokyo"]
console.log(globalCities.lastIndexOf('tokyo'));
-> 6
``` 

### join([������])
 * �迭�� ���ڿ��� ��ȯ�ϴ� �Լ�
 * �����ڴ� ���� �����ϴ�.
``` javascript 
const fruits = ['apple', 'banana', 'orange'];
let allFruits = fruits.join(', ');
console.log(allFruits);
-> apple, banana, orange
``` 

### split(������, [num])
 * ���ڿ��� �����ڸ� �������� ���ڿ� �迭�� ��ȯ��
 * num�� ������ �����ϸ�, �����ڸ� �������� num���� ������ �迭�� ��ȯ��
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
 * �迭�� ������ ������
``` javascript 
const arrNumbers = [1, 2, 3, 4, 5];
arrNumbers.reverse();
console.log(arrNumbers);
-> [5, 4, 3, 2, 1]
```

### slice(num1, num2)
 * �迭�� num1 ���� num2 -1 ��ŭ ��ȯ
``` javascript
const arrNumbers2 = [1, 2, 3, 4, 5];
const arrResult2 = arrNumbers2.slice(1, 4);
console.log(arrResult2);
-> [2, 3, 4]
```

### find([value], [index], [array])
 * return ����, �� ������ ���ǿ� �´� �迭�� ��Ұ� ��ȯ��
 * ���ǿ� �´� ��Ҹ� ã�� ���� �Լ��� �����ϹǷ� ������ ���� ���� �迭�� ��Ҹ� ã�� �� ����ؾ� ��
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
 * return ����, �� ������ ���ǿ� �´� �迭�� ��Ұ� ��ȯ��
 * ���ǿ� �´� ��ҵ��� �迭�� ��ȯ
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
 * �迭�� ��ҵ鿡�� Ư�� ���� �̾� �� �� ���
``` javascript
const mapStudent = students.map((student) => student.name);
console.log(mapStudent);
-> ["A", "B", "C", "D", "E"]
```

### some/every([value], [index], [array])
 * ������ ������ true/false�� ��ȯ
 * some: �迭�� ��� �� ���ǿ� �ϳ��� �ɸ��� true
 * every: �迭�� ��� ���ΰ� ���ǿ� �����ؾ� true
``` javascript
console.log(students.some((student) => student.score < 50));
-> true
console.log(students.every((student) => student.score > 50));
-> false
```

### reduce(prev, curr, index, array)
 * �迭�� �ִ� ����� ���� ����
``` javascript
let sum = students.reduce((prev, curr) => {
    console.log(prev + '+' + curr.score);
    return prev + curr.score;
}, 0); // <- 0�� prev �� ����
console.log(`sum: ${sum}`);
-> 0+45
-> 45+80
-> 125+90
-> 215+66
-> 281+90
-> sum: 371
```

### sort
 * �⺻�� ��������
``` javascript
// ������������ ����
const complexResult = students
    .map((student) => student.score)
    .sort()
    .reverse();

console.log(complexResult);
-> [90, 90, 80, 66, 45]

//�� ȿ������ ���
const complexResult = students
    .map((student) => student.score)
    .sort((a, b) => b - a);
    //���� ����� �����̸� �ڸ��� �ٲٴ� ����
    //a - b �� ��������

console.log(complexResult);
-> [90, 90, 80, 66, 45]
```

## JSON(JavaScript Object Notation)
---

### JSON Ư¡
 * JSON�� �ڹٽ�ũ��Ʈ�� Ȯ���Ͽ� �������
 * JSON�� �ڹٽ�ũ��Ʈ ��ü ǥ����� ����
 * JSON�� ����� ��谡 ��� �б� ����
 * JSON�� ���α׷��� ���� �ü���� ������

### stringify: Object to JSON
 * Object�� JSON���� serialize
 * ����Ʈ �迭�� ["A", "B"...]
 * �� �迭�� {"a":"A", "b": "B"...} ������ ������.
 * ['key1', 'key2'..]�� �Ķ���ͷ� ������ �ش� Ű�� stringify �Ѵ�.
 * callback�Լ��� ����� �� �ִ�.
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
 * JSON�� Object�� unserialize
 * 
``` javascript
const objectRabbit = JSON.parse(jsonRabbit);
console.log(objectRabbit.birthDate);
-> 2021-05-30T06:21:37.119Z
//Object -> JSON -> Object�� �Ǹ� Date() ��ü���� birthDate�� ����� ���ڿ��� ��޵Ǿ� �Լ�(getDate())�� ����� �� ���� �ȴ�.

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

### promise ����
 * �ڹٽ�ũ��Ʈ���� �����ϴ� �񵿱⸦ �����ϰ� ó���� �� �ֵ��� �ϴ� ������Ʈ
 * ������ ��ð��� ����� �����ϰ� ����, ���������� ����� ������ �Ǿ��ٸ� ������ �޽����� �Բ� ó���� ������� ���� ����
 * ���� ����� �����ϴٰ� ������ ���� ������ ���� ����
 * ex) ���� �ϼ� ���� ���� A��� ��ǰ�� �ݵ�
   1. ��ǰ�� �ݵ��Ѵ�.
   2. ��ǰ�� �ϼ��� �� ���� ��ٸ���.
   3. ��ǰ�� �޴´�.
 * ex) �̹� �ϼ��� ���� ��ǰ A�� ����
   1. ��ǰ�� �����Ѵ�.
   3. ��ǰ�� �޴´�.
 * ���� ���� ������ promise
 * State: pending -> fulfiled or rejected
 * Producer vs Consumer

### promise ����/���
 * ���ο� promise ��ü�� ����� �Բ� ������ excuter �Լ��� ���ÿ� ���� �ȴ�.
 * Promise ��ü
   * resolve -> ������ ó��
   * reject -> ���н� ó��
 * Promise ��ü ���� �� 
   * then: promise�� resolve ����
   * catch: promise�� reject ����
   * finally: ������ ����
``` javascript
class User {
    constructor(id, pw){
        this.id = id;
        this.pw = pw;
    }
    
    doShowList(list) { //�迭 ����Ʈ�� �ǳ��ָ� ����ϴ� �Լ�
        list.forEach(element => {
            console.log(element);
        });
    }

    doSignin(list, id, pw){ 
        //promise�� ����Ͽ� �ڵ� ����ȭ
        return new Promise((resolve, reject) => {
            const flag = list.some(user => {
                //�迭 Ŭ���� �Լ��� some�� ���ǿ� ���� true/false �� ��ȯ
                return user.id === id && user.pw === pw;
            });
            if(flag){ //�����ϸ� resolve
                resolve(id);
            } else { //�����ϸ� reject
                reject('id or pw is not correct');
            }
        })
    }

    moveToMain(){ //�α��� ������ ȣ��Ǵ� �Լ�
        console.log('main page');
    }

}

const userList = [ //ȸ�����
    new User('woogie1', '123'),
    new User('woogie2', '456'),
    new User('woogie3', '789')
];

const user = new User();

const id = prompt('id');
const pw = prompt('pw');

user.doSignin(userList, id, pw)
    .then(id => { //id <- resolve���� �޾ƿ� �Ķ����
        console.log(`Welcome ${id}`);
        user.moveToMain();
    })
    .catch(error => { //error <- reject���� �޾ƿ� �Ķ����
        alert(error);
    })
    .finally(console.log('process over'))
;
```

## aync & await
---

### ����
 * aync
   * promise�� ������� �ʰ� �Լ��� �񵿱�� ����� ������ ��
   * return ���� �׻� promise��
 * await
   * async�� ���� �Լ��� �ȿ����� ��� �� �� ����
   * �񵿱� �Լ��� ���������� ����(������ �Ϸ�� ������ ��ٸ��� ��)
``` javascript
function deley(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

//1.5�ʸ� ��ٸ��� �ʰ� �ٷ� ���� �ڵ带 ����
async function walk(id) {
    deley(1500); 
    return `${id} arrived`;
}

//1�ʸ� ��ٸ��� ���� ���� �ڵ带 ����
async function run(id) {
    await deley(1000); 
    return `${id} arrived`;
}

//���� ����� �񵿱� �Լ��� ��� ���� ��ȯ
async function doRace(id1, id2) {
    return Promise.race([walk(id1), run(id2)]);    
}

//�Ķ���ͷ� �Էµ� ��� �񵿱� �Լ��� ó���� �Ŀ� �� ��������� ��ȯ
async function arrive(id1, id2) {
    return Promise.all([walk(id1), run(id2)])
        .then(name => name.join(', '));
}

doRace('woogie', 'umi').then(result => console.log(`race winner: ${result}`));
-> race winner: woogie arrived

//�޾ƿ��� ���� �ٷ� �Ķ���ͷ� ����� ��� �� �� ������ �����ϴ�.
arrive('woogie', 'umi').then(console.log);
-> woogie arrived, umi arrived
```

