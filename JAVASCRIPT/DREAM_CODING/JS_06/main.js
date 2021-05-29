'use strict';
console.log('JS_06!');

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

let woogie = new Person('woogie', -5);

console.log(woogie);
console.log(woogie.name);
console.log(woogie.age);

woogie.age = 28;

console.log(woogie);
console.log(woogie.name);
console.log(woogie.age);

woogie.speak();

console.log(Person.species);
Person.saySpecies();

class Korean extends Person {}

const koreanWoogie = new Korean('우기', 28);
console.log(koreanWoogie);
koreanWoogie.speak();

class Japaneese extends Person {
    speak() {
        console.log(`${this.name}, おはよう!`);
    }

    orgSpeak() {
        super.speak();
    }
}

const JapaneeseWoogie = new Japaneese('ウギ', 28);
console.log(JapaneeseWoogie);
JapaneeseWoogie.speak();
JapaneeseWoogie.orgSpeak();

console.log(koreanWoogie instanceof Korean);
console.log(koreanWoogie instanceof Japaneese);
console.log(koreanWoogie instanceof Person);
console.log(koreanWoogie instanceof Object);


