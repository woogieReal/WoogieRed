--숫자함수
--ROUND(num1, num2)
--TRUNC(num1, num2)
--MOD(num1, num2)
--CEIL(num1)
--FLOOR(num1)
--POWER(num1, num2)
--ABS(): 숫자의 절대값
--SIGN(): 숫자가 양수인지 음수인지, 0인지 구분

--ROUND(num1, num2): 주어진 숫자를 반올림한 후 출력함
--num1의 소숫점을 num2자리로 반올림. num2를 따로 지정안하면 소수 첫째자리에서 반올림
--ROUND(12.345,2) -> 12.35
SELECT ROUND(987.654), ROUND(987.654,1), ROUND(987.654,2), ROUND(987.654,-1)
FROM dual;
--ROUND(987.654) ROUND(987.654,1) ROUND(987.654,2) ROUND(987.654,-1)
---------------- ---------------- ---------------- -----------------
--           988            987.7           987.65               990

--TRUNC(num1, num2): 주어진 숫자를 올림한 후 출력함
--num1의 소숫값을 num2자리로 버리고 올림. num2를 따로 지정안하면 소수 첫째자리에서 올림
--TRUNC(12.345,2) -> 12.34
SELECT TRUNC(987.654), TRUNC(987.654,1), TRUNC(987.654,2), TRUNC(987.654,-1)
FROM dual;
--TRUNC(987.654) TRUNC(987.654,1) TRUNC(987.654,2) TRUNC(987.654,-1)
---------------- ---------------- ---------------- -----------------
--           987            987.6           987.65               980

--MOD(num1, num2): 주어진 숫자를 나눈 후 나머지 값을 출력함
--num1을 num2로 나눈 나머지
--MOD(12,2) -> 2
SELECT MOD(121,10)
FROM dual;
--MOD(121,10)
-------------
--          1

--CEIL(num1): 주어진 숫자와 가장 근접한 큰 정수를 출력함
--CELL(12.345) -> 13
SELECT CEIL(121.10)
FROM dual;
--CEIL(121.10)
--------------
--         122

--CEIL을 이용한 페이징
SELECT rownum, CEIL(rownum/3), ename
FROM emp;
--    ROWNUM CEIL(ROWNUM/3) ENAME
------------ -------------- --------------------
--         1              1 SMITH
--         2              1 ALLEN
--         3              1 WARD
--         4              2 JONES
--         5              2 MARTIN
--         6              2 BLAKE
--         7              3 CLARK
--         8              3 KING
--         9              3 TURNER
--        10              4 JAMES
--        11              4 FORD
--        12              4 MILLER

--FLOOR(num1): 주어진 숫자와 가장 근접한 작은 정수를 출력함
--FLOOR(12.345) -> 12
SELECT FLOOR(121.10)
FROM dual;
--FLOOR(121.10)
---------------
--          121

--POWER(num1, num2): 주어진 숫자 1의 숫자2제곱을 출력함.
--num1의 num2제곱
--POWER(3,2) -> 9
SELECT POWER(2,5)
FROM dual;
--POWER(2,5)
------------
--        32