'use strict';
console.log('JS_12!');

// 1. Producer
const promise = new Promise((resolve, reject) => {
    //doing some heavy work
    console.log('doing something');
    setTimeout(() => {
        //resolve('woogie');
        reject(new Error('error!'));
    }, 2000);
});

//2. Consumer
//value는 promise가 정상수행되어 resolve 콜백 함수에서 전달된 값
promise
    .then(value => { // <- 성공시 
        console.log(value);
    })
    .catch(error => {// <- 실패시
        console.log(error);
    })
    .finally(() => {
        console.log('process over');
    });

//3. Promise chaining
const fetchNumber = new Promise((resolve, reject) => {
    setTimeout(() => resolve(1), 1000);
});

fetchNumber
    .then(num => num * 2)
    .then(num => num * 3)
    .then(num => {
        return new Promise((resolve, reject) => {
            setTimeout(() => resolve(num - 1), 1000);
        })
    })
    .then(num => console.log(num));

//4. Error Handling
class User {
    constructor(id, pw){
        this.id = id;
        this.pw = pw;
    }
    
    doShowList(list) {
        list.forEach(element => {
            console.log(element);
        });
    }

    doSignin(list, id, pw){
        return new Promise((resolve, reject) => {
            const flag = list.some(user => {
                return user.id === id && user.pw === pw;
            });
            if(flag){
                resolve(id);
            } else {
                reject('id or pw is not correct');
            }
        })
    }

    moveToMain(){
        console.log('main page');
    }

}

const userList = [
    new User('woogie1', '123'),
    new User('woogie2', '456'),
    new User('woogie3', '789')
];

const user = new User();

const id = prompt('id');
const pw = prompt('pw');

user.doSignin(userList, id, pw)
    .then(id => {
        console.log(`Welcome ${id}`);
        user.moveToMain();
    })
    .catch(error => {
        alert(error);
    })
    .finally(console.log('process over'))
;
    






