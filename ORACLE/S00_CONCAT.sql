--연결연산자: ||
--컬럼을 붙여서 출력
--작은 따옴표를 쓰기 위해서는 ' '(') ' ()안의 작은따옴표만 출력

1. example01
SELECT ename || ' ''s job is ' || job AS "NAME AND JOB"
FROM emp;
--NAME AND JOB
--------------------------------------------------------------
--SMITH 's job is CLERK
--ALLEN 's job is SALESMAN
--WARD 's job is SALESMAN
--JONES 's job is MANAGER
--MARTIN 's job is SALESMAN
--BLAKE 's job is MANAGER
--CLARK 's job is MANAGER
--KING 's job is PRESIDENT
--TURNER 's job is SALESMAN
--JAMES 's job is CLERK
--FORD 's job is ANALYST
--MILLER 's job is CLERK

--2. example02
SELECT name ||' ''s ID : ' || id ||', WEIGHT is ' || weight ||'Kg' AS "ID AND WEIGHT"
FROM student;
--
--ID AND WEIGHT
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--James Seo 's ID : 75true, WEIGHT is 72Kg
--Rene Russo 's ID : Russo, WEIGHT is 64Kg
--Sandra Bullock 's ID : Bullock, WEIGHT is 52Kg
--Demi Moore 's ID : Moore, WEIGHT is 83Kg
--Danny Glover 's ID : Glover, WEIGHT is 70Kg
--Billy Crystal 's ID : Crystal, WEIGHT is 48Kg
--Nicholas Cage 's ID : Cage, WEIGHT is 42Kg
--Micheal Keaton 's ID : Keaton, WEIGHT is 55Kg
--Bill Murray 's ID : Murray, WEIGHT is 58Kg
--Macaulay Culkin 's ID : Culkin, WEIGHT is 54Kg
--Richard Dreyfus 's ID : Dreyfus, WEIGHT is 72Kg
--Tim Robbins 's ID : Robbins, WEIGHT is 70Kg
--Wesley Snipes 's ID : Snipes, WEIGHT is 82Kg
--Steve Martin 's ID : Martin, WEIGHT is 51Kg
--Daniel Day-Lewis 's ID : Day-Lewis, WEIGHT is 62Kg
--Danny Devito 's ID : Devito, WEIGHT is 48Kg
--Sean Connery 's ID : Connery, WEIGHT is 63Kg
--Christian Slater 's ID : Slater, WEIGHT is 69Kg
--Charlie Sheen 's ID : Sheen, WEIGHT is 81Kg
--Anthony Hopkins 's ID : Hopkins, WEIGHT is 51Kg
--



