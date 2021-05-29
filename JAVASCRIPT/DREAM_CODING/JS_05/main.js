'use strict';
console.log('JS_05!');

const myNm = 'woogie';

function sayHello(whoNm = 'everyOne'){
    console.log(`Hi, ${whoNm}`);
}

sayHello(myNm);
sayHello();

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

const sayAnonymous = function(){
    console.log('say');
    console.log('anonymous');
}

sayAnonymous();

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

const addSimple = (a,b) => a+b;
const addComplex = (a,b) => {
    return a+b;
}

console.log(addSimple(1,5));
console.log(addComplex(1,5));

(
    function iifeFunction() {
        console.log('Call immediately');
    }
)();





