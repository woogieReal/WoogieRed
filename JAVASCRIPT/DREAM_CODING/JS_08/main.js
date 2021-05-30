'use strict';
console.log('JS_08!');

const cities = ['seoul', 'incheon', 'busan'];

for(let i = 0; i < cities.length; i++){
    console.log(cities[i]);
}

for(let city of cities){
    console.log(city);
}

cities.forEach((city) => console.log(city));

cities.forEach(function doCapitalize(city, index, array){
    const result =  city.charAt(0).toUpperCase() + city.slice(1, city.length);
    console.log(`capitalized: ${result}`);
});

cities.push('suwon', 'ilsan');
console.log(cities);

cities.pop();
console.log(cities);

cities.unshift('hanyang');
console.log(cities);

cities.shift();
console.log(cities);

const splicedCities = cities.splice(0, 2);
console.log(cities);
console.log(splicedCities);

cities.splice(1, 1, 'seoul', 'incheon', 'ilsan');
console.log(cities);

const japanCities = ['tokyo','osaka'];
const globalCities = cities.concat(japanCities);
console.log(globalCities);

console.log(globalCities.indexOf('tokyo'));
console.log(globalCities.includes('nagoya'));
console.log(globalCities.indexOf('nagoya'));


globalCities.push('tokyo');
console.log(globalCities);

console.log(globalCities.lastIndexOf('tokyo'));



