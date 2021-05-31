function hello(name: string):void {
    console.log(`hello ${name}!`);
}

hello('woogie');

let num01:number = 11;
//오류발생
//num01 = '10';

function plusExclamationMark(name:string):string {
    return name + '!!';
}

console.log(plusExclamationMark('woogie'));

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

interface Dog {
    readonly name: string;
    age: number;
    color?: string;
}

function convertToDog(name:string, age:number):Dog {
    return {name: name, age: age};
}

const dog01 = convertToDog('coco', 4);
console.log(dog01);
console.log(`name: ${dog01.name}`);
console.log(`age: ${dog01.age}`);

//오류발생
//dog01.name = 'koko';

enum Grade {
    A, 
    B = 'B', 
    C = 'C'
} 

interface Student {
    readonly name: string,
    age: number,
    address?: string,
    grade: Grade
}

function showStudentGrade(student: Student):void {
    console.log(`${student.name}(${student.age}) got ${student.grade}`);
}

showStudentGrade({
    name: 'woogie', 
    age: 28, 
    grade: Grade.A
});

showStudentGrade({
    name: 'woogie', 
    age: 28, 
    grade: Grade.B
});

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
});

let anyValue: any = 5;
anyValue = 'woogie';

let unionValue: string | boolean = 'true';
unionValue = false;

type StrOrNum = string | number;

let aliasesValue: StrOrNum = 55;
aliasesValue = 'woogie';

let itemPrice: number = 0;

const setItemPrice = (price: StrOrNum):void => {
    if(typeof price === 'string') {
        itemPrice = 0;
    } else {
        itemPrice = price;
    }
};

setItemPrice('50');
console.log(`itemPrice: ${itemPrice}`);


