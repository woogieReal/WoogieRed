'use strict';
console.log('JS_10!');

let json = JSON.stringify(['apple', 'banana']);
console.log(json);

const rabbit = {
    name: 'tori',
    color: 'white',
    size: null,
    birthDate: new Date(),
    jump: () => {
        console.log(`${name} cam jump!`);
    }
};

console.log(rabbit);

const jsonRabbit = JSON.stringify(rabbit);
console.log(jsonRabbit);

const jsonRabbitKey = JSON.stringify(rabbit, ['name', 'color']);
console.log(jsonRabbitKey);

const jsonRabbitKeyValue = JSON.stringify(rabbit, (key, value) => {
    console.log(`key: ${key}, value: ${value}`);
    //return key === 'name' ? 'woogie' : value;
    return key === 'name' ? 'woogie' : value, key === 'size' ? 74 : value;
});
console.log(jsonRabbitKeyValue);

console.clear();

const objectRabbit = JSON.parse(jsonRabbit);
console.log(objectRabbit.birthDate);
console.log(rabbit.birthDate.getDate());

const objecgtRabbitPerfect = JSON.parse(jsonRabbit, (key, value) => {
    console.log(`key: ${key}, value: ${value}`);
    return key === 'birthDate' ? new Date(value) : value;
});
console.log(objecgtRabbitPerfect.birthDate.getDate());










