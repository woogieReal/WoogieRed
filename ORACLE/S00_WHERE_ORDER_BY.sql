--정렬하여 출력하기: ORDER BY 컬럼,컬럼
--정렬하여 출력하기: ORDER BY 1 ASC, 2 DESC
--DEFAULT는 ASC
--ORDER BY는 성능을 저하시키므로 사용하지 않는 것이 좋다.
--하지만 적은 수의 데이터의 경우에는 인덱스를 만드는 것보다 나음

--ASC
--한글: 가나다
--영문: ABC
--숫자: 1234
--날짜: 예전날짜부터

--1.sal값을 오름차순으로 정렬
SELECT ename,sal,hiredate
FROM emp
ORDER BY sal DESC;
--ENAME                       SAL HIREDATE
---------------------- ---------- --------
--KING                       5000 81/11/17
--FORD                       3000 81/12/03
--JONES                      2975 81/04/02
--BLAKE                      2850 81/05/01
--CLARK                      2450 81/06/09
--ALLEN                      1600 81/02/20
--TURNER                     1500 81/09/08
--MILLER                     1300 82/01/23
--MARTIN                     1250 81/09/28
--WARD                       1250 81/02/22
--JAMES                       950 81/12/03
--SMITH                       800 80/12/17

--2.칼럼순서로 정렬지정
SELECT deptno,ename,sal,hiredate
FROM emp
ORDER BY 1 DESC, 3ASC;
   -- DEPTNO ENAME                       SAL HIREDATE
------------ -------------------- ---------- --------
   --     30 JAMES                       950 81/12/03
   --     30 WARD                       1250 81/02/22
   --     30 MARTIN                     1250 81/09/28
   --     30 TURNER                     1500 81/09/08
   --     30 ALLEN                      1600 81/02/20
   --     30 BLAKE                      2850 81/05/01
   --     20 SMITH                       800 80/12/17
   --     20 JONES                      2975 81/04/02
   --     20 FORD                       3000 81/12/03
   --     10 MILLER                     1300 82/01/23
   --     10 CLARK                      2450 81/06/09
   --     10 KING                       5000 81/11/17