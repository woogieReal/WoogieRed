function hello(name) {
    console.log("hello " + name + "!");
}
hello('woogie');
var num01 = 11;
//오류발생
//num01 = '10';
function plusExclamationMark(name) {
    return name + '!!';
}
console.log(plusExclamationMark('woogie'));
var Person = /** @class */ (function () {
    function Person(name, age) {
        this.name = name;
        this.age = age;
    }
    return Person;
}());
function convertToPerson(name, age) {
    return new Person(name, age);
}
var person01 = convertToPerson('woogie', 28);
console.log("name: " + person01.name);
console.log("age: " + person01.age);
function convertToDog(name, age) {
    return { name: name, age: age };
}
var dog01 = convertToDog('coco', 4);
console.log(dog01);
console.log("name: " + dog01.name);
console.log("age: " + dog01.age);
//오류발생
//dog01.name = 'koko';
var Grade;
(function (Grade) {
    Grade[Grade["A"] = 0] = "A";
    Grade["B"] = "B";
    Grade["C"] = "C";
})(Grade || (Grade = {}));
function showStudentGrade(student) {
    console.log(student.name + "(" + student.age + ") got " + student.grade);
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
function showCat(cat) {
    console.log(cat.name + "(" + cat.age + ") has " + cat.color + " hair.");
}
showCat({
    name: 'nyao',
    age: 2,
    color: 'white'
});
var anyValue = 5;
anyValue = 'woogie';
var unionValue = 'true';
unionValue = false;
var aliasesValue = 55;
aliasesValue = 'woogie';
var itemPrice = 0;
var setItemPrice = function (price) {
    if (typeof price === 'string') {
        itemPrice = 0;
    }
    else {
        itemPrice = price;
    }
};
setItemPrice('50');
console.log("itemPrice: " + itemPrice);
