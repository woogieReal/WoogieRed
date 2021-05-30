'use strict';
console.log('JS_09!');

const arrFruits1 = ['apple', 'banana', 'orange'];
let strFruits1 = arrFruits1.join(', ');
console.log(strFruits1);

const strFruits2 = 'apple, kiwi, banana, cherry';
const arrFruits2 = strFruits2.split(',', 3);
arrFruits2.forEach(function (fruit, index, array){
    array[index] = fruit.trim();
});
console.log(arrFruits2);

const arrNumbers = [1, 2, 3, 4, 5];
arrNumbers.reverse();
console.log(arrNumbers);

const arrNumbers2 = [1, 2, 3, 4, 5];
const arrResult2 = arrNumbers2.slice(1, 4);
console.log(arrResult2);

class Student {
    constructor(name, age, enrolled, score,){
        this.name = name;
        this.age = age;
        this.enrolled = enrolled;
        this.score = score;
    }
}

const students = [
    new Student('A', 29, true, 45),
    new Student('B', 28, false, 80),
    new Student('C', 30, true, 90),
    new Student('D', 40, false, 66),
    new Student('E', 18, true, 90)
];

students.forEach((student) => {
    if(student.score === 90) console.log(student.name); 
});

const findStudent = students.find((student, index, array) => {
    return student.name === 'D';
});
console.log(findStudent);

const filterStudent = students.filter((value, index, array) => {
    return value.enrolled === true;
});
console.log(filterStudent);

const mapStudent = students.map((student) => student.name);
console.log(mapStudent);

console.log(students.some((student) => student.score < 50));
console.log(students.every((student) => student.score > 50));

let sum = students.reduce((prev, curr) => {
    console.log(prev + '+' + curr.score);
    return prev + curr.score;
}, 0);
console.log(`sum: ${sum}`);

const complexResult = students
    .map((student) => student.score)
    .sort((a, b) => b - a);

console.log(complexResult);
