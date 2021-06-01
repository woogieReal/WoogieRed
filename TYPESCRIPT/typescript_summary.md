## command
---

### tsc
 * tsc ts파일명
 * ts -> js 컴파일
``` javascript
tsc app01.ts

function hello(name: string) {
    console.log(`hello ${name}!`);
}
hello('woogie');

▼ 컴파일

function hello(name) {
    console.log("hello " + name + "!");
}
hello('woogie');

```

### tsc --init
 * tsconfig.json 파일 생성
 * 설정파일

### tsc -w
 * tsc -w ts파일명
 * 자동 컴파일
``` javascript
tsc -w app01.ts
```

## Static Typing
---

### 타입추론(Type Inference)
 * 타입을 명시하지 않았을 시 할당된 값을 보고 타입을 추론하여 지정함
``` javascript
let num01 = 10;
num01 = '10'; 
//오류발생
Type 'string' is not assignable to type 'number'.ts
```

### 타입명시(Type Annotations)
 * 변수 선언시 타입 명시
 * 함수에도 void 또는 return 타입을 명시가능
``` javascript
function hello(name: string):void {
    console.log(`hello ${name}!`);
}
hello('woogie');
-> hello woogie!

class Person {

    name:string;
    age:number;

    constructor(name:string, age:number){
        this.name = name;
        this.age = age;
    }
}

function convertToPerson(name:string, age:number):Person {
    return new Person(name, age);
}

const person01 = convertToPerson('woogie', 28);
console.log(`name: ${person01.name}`);
console.log(`age: ${person01.age}`);
-> name: woogie
-> age: 28
```

## Interface
---

### 생성&사용
 * js로 컴파일하면 사라짐
 * 작성 중인 코드에 대한 더 많은 정보를 타입스크립트에 제공하기 위한 용도
 * 인터페이스의 변수명에 ? 를 붙히면 null 값을 허용한다.
 * 변수명 앞에 readonly를 붙혀 읽기전용 프로퍼티로 지정
 * 객체 생성시 할당된 프로퍼티의 값을 바꿀 수 없다.
``` javascript
interface Dog {
    readonly name: string;
    age: number;
	color?: string;
}

function convertToDog(name:string, age:number):Dog {
    return {name: name, age: age};
}

const dog01 = convertToDog('coco', 4);
console.log(`name: ${dog01.name}`);
console.log(`age: ${dog01.age}`);
-> name: coco
-> age: 4

dog01.name = 'koko';
//오류
//Cannot assign to 'name' because it is a read-only property.
```

## Enum & Literal
---

### Enum
 * 사용법은 자바와 동일
``` javascript
// Enum 변수에 따로 값을 지정해 주지 않으면 0부터 값이 주어짐
enum Grade {
    A,  // -> 값: 0
    B = 'B', 
    C = 'C'
}  

interface Student {
    readonly name: string,
    age: number,
    address?: string, //null 허용
    grade: Grade //Enum 타입을 받음
}

function showStudentGrade(student: Student):void {
    console.log(`${student.name}(${student.age}) got ${student.grade}`);
}

showStudentGrade({
    name: 'woogie', 
    age: 28, 
    grade: Grade.A
});
-> woogie(28) got 0

showStudentGrade({
    name: 'woogie', 
    age: 28, 
    grade: Grade.B
});
-> woogie(28) got B
```

### Literal
 * enum 타입과 같은 효과를 내면서 코드를 간결하게 함
``` javascript
interface Cat {
    name: string,
    age: number,
    color: 'white' | 'black' | 'gray'
}

function showCat(cat: Cat):void {
    console.log(`${cat.name}(${cat.age}) has ${cat.color} hair.`);
}

showCat({
    name: 'nyao',
    age: 2,
    color: 'white'
//color: 'blue'
//오류발생
//Type '"blue"' is not assignable to type '"white" | "black" | "gray"'
});
-> nyao(2) has white hair.
```

## Type
---

### 설명
 * 타입에 관한 더 많은 정보를 명시할 수록 좋음
 * 효과적인 코드의 유지보수

### Any
 * 어떠한 타입이든 모두 할당 될 수 있음
 * 최대한 사용하지 않는 것이 좋다.
``` javascript
let anyValue: any = 5;
anyValue = 'woogie';
//오류 없음
```

### Union type
 * 두 가지 이상의 타입을 할당
``` javascript 
let unionValue: string | boolean = 'true';
unionValue = false;
```

### Type Aliases
 * 타입을 묶어서 별칭으로 지정해 줄 수 있음
``` javascript
type StrOrNum = string | number;

let aliasesValue: StrOrNum = 55;
aliasesValue = 'woogie';
```

### Type Guard
 * Type Aliases를 사용할 경우 하나의 변수가 두 가지 이상의 타입을 가질 수 있기 때문에 오류가 발생할 수 있음
 * 이를 막기 위해 코드를 작성하는 것이 type guard
``` javascript
type StrOrNum = string | number;
let itemPrice: number = 0;

const setItemPrice = (price: StrOrNum):void => {
    if(typeof price === 'string') {
        itemPrice = 0;
    } else {
        itemPrice = price;
    }
};
```







 