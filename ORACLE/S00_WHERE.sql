--숫자 이외에는 꼭 작은 따옴표를 사용!
--문자는 대소문자를 구분하고, 날짜에는 대소문자 구분이 없다.

--1. (=)
SELECT empno, ename
FROM emp
WHERE empno = 7900;
--     EMPNO ENAME
------------ --------------------
--      7900 JAMES

--2. (<,<=,>,>=)
SELECT empno, sal
FROM emp
WHERE sal < 1000;
--     EMPNO        SAL
------------ ----------
--      7369        800
--      7900        950

--3. (문자 =)
--작은따옴표 사용, 대소문자 구분
SELECT ename,empno
FROM emp
WHERE ename = 'SMITH';
--ENAME                     EMPNO
---------------------- ----------
--SMITH                      7369

--4. (날짜 =)
--작은따옴표 사용, 대소문자 구분안함
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate = '80/12/17';
--     EMPNO ENAME                HIREDATE
------------ -------------------- --------
--      7369 SMITH                80/12/17

--5. (문자 <,<=,>,>=)
SELECT empno, ename, sal
FROM emp
WHERE ename <= 'G';
--     EMPNO ENAME                       SAL
------------ -------------------- ----------
--      7499 ALLEN                      1600
--      7698 BLAKE                      2850
--      7782 CLARK                      2450
--      7902 FORD                       3000

--6. (날짜 <,<=,>,>=)
SELECT ename, hiredate
FROM emp
WHERE hiredate > '81/05/01';
--ENAME                HIREDATE
---------------------- --------
--MARTIN               81/09/28
--CLARK                81/06/09
--KING                 81/11/17
--TURNER               81/09/08
--JAMES                81/12/03
--FORD                 81/12/03
--MILLER               82/01/23

--7. (BETWEEN num AND num)
--BETWEEN 보다 부등호가 연산이 빠르다
SELECT empno, ename, sal
FROM emp
WHERE sal BETWEEN 2000 AND 3000
ORDER BY sal;
--    EMPNO ENAME                       SAL
------------ -------------------- ----------
--      7782 CLARK                      2450
--      7698 BLAKE                      2850
--      7566 JONES                      2975
--      7902 FORD                       3000

--8. (BETWEEN string AND string)
SELECT ename
FROM emp
WHERE ename BETWEEN 'JAMES' AND 'MARTIN'
ORDER BY ename;
ENAME
----------------------
--JAMES
--JONES
--KING
--MARTIN

--9. (IN(a,b,c): a이거나 b이거나 c이거나)
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN(10,20);
--     EMPNO ENAME                    DEPTNO
------------ -------------------- ----------
--      7369 SMITH                        20
--      7566 JONES                        20
--      7782 CLARK                        10
--      7839 KING                         10
--      7902 FORD                         20
--      7934 MILLER                       10

--10. (LIKE)
--%는 *와 같다(모든것)
--_는 한 글자(어떤 글자가 와도 상관없다.)
--작은따옴표로 감싸줘야함
SELECT empno, ename, sal
FROM emp
WHERE sal LIKE '1%';
--     EMPNO ENAME                       SAL
------------ -------------------- ----------
--      7499 ALLEN                      1600
--      7521 WARD                       1250
--      7654 MARTIN                     1250
--      7844 TURNER                     1500
--      7934 MILLER                     1300
