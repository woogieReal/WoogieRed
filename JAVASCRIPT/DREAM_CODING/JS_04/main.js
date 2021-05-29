'use strict';
console.log('JS_04!');

let testNumPlus = 3;
const resultNumPlus = ++testNumPlus;
console.log(`testNumPlus: ${testNumPlus}`);
console.log(`resultNumPlus: ${resultNumPlus}`);

let testNumMinus = 3;
const resultNumMinus = testNumMinus--;
console.log(`testNumMinus: ${testNumMinus}`);
console.log(`resultNumMinus: ${resultNumMinus}`);

const condition1 = true;
const condition2 = 1 < 2;
function condition3() {
    for(let i = 1; i < 10; i++){
        console.log(i);
    }
    return true;
}

console.log(`or: ${condition1 || condition2 || condition3()}`);

const object1 = {nm: 'woogie', age: 28};
const object2 = {nm: 'woogie', age: 28};
const object3 = object1;

console.log(object1.nm === object2.nm);
console.log(object1 === object2);
console.log(object1 === object3);

console.log('========================');
console.log(0 == false);
console.log(0 === false);
console.log('' == false);
console.log('' === false);
console.log(null == undefined);
console.log(null === undefined);

let conditionTernary = 'woogie';
let resultNumTernary = 0;
conditionTernary === 'woogie' ? resultNumTernary = 1 : resultNumTernary = 0;
console.log(`resultNumTernary: ${resultNumTernary}`);

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
}







