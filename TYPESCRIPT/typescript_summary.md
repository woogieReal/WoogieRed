## command
---

### tsc
 * tsc ts���ϸ�
 * ts -> js ������
``` javascript
tsc app01.ts

function hello(name: string) {
    console.log(`hello ${name}!`);
}
hello('woogie');

�� ������

function hello(name) {
    console.log("hello " + name + "!");
}
hello('woogie');

```

### tsc --init
 * tsconfig.json ���� ����
 * ��������

### tsc -w
 * tsc -w ts���ϸ�
 * �ڵ� ������
``` javascript
tsc -w app01.ts
```

## Static Typing
---

### Ÿ���߷�(Type Inference)
 * Ÿ���� ������� �ʾ��� �� �Ҵ�� ���� ���� Ÿ���� �߷��Ͽ� ������
``` javascript
let num01 = 10;
num01 = '10'; 
//�����߻�
Type 'string' is not assignable to type 'number'.ts
```

### Ÿ�Ը��(Type Annotations)
 * ���� ����� Ÿ�� ���
 * �Լ����� void �Ǵ� return Ÿ���� ��ð���
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

### ����&���
 * js�� �������ϸ� �����
 * �ۼ� ���� �ڵ忡 ���� �� ���� ������ Ÿ�Խ�ũ��Ʈ�� �����ϱ� ���� �뵵
 * �������̽��� ������ ? �� ������ null ���� ����Ѵ�.
 * ������ �տ� readonly�� ���� �б����� ������Ƽ�� ����
 * ��ü ������ �Ҵ�� ������Ƽ�� ���� �ٲ� �� ����.
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
//����
//Cannot assign to 'name' because it is a read-only property.
```

## Enum & Literal
---

### Enum
 * ������ �ڹٿ� ����
``` javascript
// Enum ������ ���� ���� ������ ���� ������ 0���� ���� �־���
enum Grade {
    A,  // -> ��: 0
    B = 'B', 
    C = 'C'
}  

interface Student {
    readonly name: string,
    age: number,
    address?: string, //null ���
    grade: Grade //Enum Ÿ���� ����
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
 * enum Ÿ�԰� ���� ȿ���� ���鼭 �ڵ带 �����ϰ� ��
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
//�����߻�
//Type '"blue"' is not assignable to type '"white" | "black" | "gray"'
});
-> nyao(2) has white hair.
```

## Type
---

### ����
 * Ÿ�Կ� ���� �� ���� ������ ����� ���� ����
 * ȿ������ �ڵ��� ��������

### Any
 * ��� Ÿ���̵� ��� �Ҵ� �� �� ����
 * �ִ��� ������� �ʴ� ���� ����.
``` javascript
let anyValue: any = 5;
anyValue = 'woogie';
//���� ����
```

### Union type
 * �� ���� �̻��� Ÿ���� �Ҵ�
``` javascript 
let unionValue: string | boolean = 'true';
unionValue = false;
```

### Type Aliases
 * Ÿ���� ��� ��Ī���� ������ �� �� ����
``` javascript
type StrOrNum = string | number;

let aliasesValue: StrOrNum = 55;
aliasesValue = 'woogie';
```

### Type Guard
 * Type Aliases�� ����� ��� �ϳ��� ������ �� ���� �̻��� Ÿ���� ���� �� �ֱ� ������ ������ �߻��� �� ����
 * �̸� ���� ���� �ڵ带 �ۼ��ϴ� ���� type guard
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







 