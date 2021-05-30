'use strict';
console.log('JS_13!');

function deley(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function walk(id) {
    deley(1500);
    return `${id} arrived`;
}

async function run(id) {
    await deley(1000);
    return `${id} arrived`;
}

async function doRace(id1, id2) {
    return Promise.race([walk(id1), run(id2)]);    
}

async function arrive(id1, id2) {
    return Promise.all([walk(id1), run(id2)])
        .then(name => name.join(', '));
}

doRace('woogie', 'umi').then(result => console.log(`race winner: ${result}`));
arrive('woogie', 'umi').then(console.log);
