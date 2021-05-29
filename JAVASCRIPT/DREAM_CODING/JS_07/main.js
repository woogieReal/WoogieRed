'use strict';
console.log('JS_07!');

let person = {name: 'woogie', age: 28};
console.log(person);

person.nation = 'Korea';
console.log(person);

delete person.nation;
console.log(person);

function printValue(obj, key) {
    console.log(obj[key]);
}

printValue(person, 'name');
printValue(person, 'age');

function Person(name, age) {
    this.name = name;
    this.age = age;
}

let person2 = new Person('woogie2', 25);
console.log(person2);

console.log('name' in person);
console.log('nation' in person);

for(let key in person){
    console.log(person[key]);
}

const array = [1,2,3,4];
for(let value of array){
    console.log(value);    
}

const user1 = {name: 'woogie', level: 20};
const user2 = user1;

user2.level = 30;
console.log(user1.level);

const user3 = Object.assign({}, user1);
user3.level = 40;
console.log(user1.level);

const user4 = {level: 50, job: 'magician'};
const user5 = Object.assign({}, user3, user4);
console.log(user5);


