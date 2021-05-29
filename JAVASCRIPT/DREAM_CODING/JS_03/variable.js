'use strict';

console.log('Hello World!');
let nameGlobal = 'global';

{
    let name1 = 'woogie';
    console.log(name1);
    
    name1 = 'woogieReal';
    console.log(name1);    
}

console.log(nameGlobal);

const hour = 24;
console.log(hour);
console.log(1/0);
console.log(-1/0);

const myNation = 'korea';
console.log(typeof hour);
console.log(typeof myNation);

console.log(`value: ${myNation}`);

const symbol1 = Symbol('anything');
const symbol2 = Symbol('anything');

console.log(symbol1 == symbol2);

const gSymbol1 = Symbol.for('anything');
const gSymbol2 = Symbol.for('anything');

console.log(gSymbol1 == gSymbol2);

console.log(`value: ${symbol1.description}, type: ${typeof symbol}`);

let text = 'hello';
console.log(`value: ${text}, type: ${typeof text}`);

text = 8;
console.log(`value: ${text}, type: ${typeof text}`);

text = '8' + 5;
console.log(`value: ${text}, type: ${typeof text}`);

text = '8' / 2;
console.log(`value: ${text}, type: ${typeof text}`);


