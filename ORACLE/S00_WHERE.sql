--숫자 이외에는 꼭 작은 따옴표를 사용!
--문자는 대소문자를 구분하고, 날짜에는 대소문자 구분이 없다.

--1. =
SELECT empno, ename
FROM emp
WHERE empno = 7900;
--     EMPNO ENAME
------------ --------------------
--      7900 JAMES

--2. <,<=,>,>=
SELECT empno, sal
FROM emp
WHERE sal < 1000;
--     EMPNO        SAL
------------ ----------
--      7369        800
--      7900        950

--3. 문자 =
--작은따옴표 사용, 대소문자 구분
SELECT ename,empno
FROM emp
WHERE ename = 'SMITH';
--ENAME                     EMPNO
---------------------- ----------
--SMITH                      7369

--4. 날짜 =
--작은따옴표 사용, 대소문자 구분안함
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate = '80/12/17';
--     EMPNO ENAME                HIREDATE
------------ -------------------- --------
--      7369 SMITH                80/12/17

--5. 문자 <,<=,>,>=
SELECT empno, ename, sal
FROM emp
WHERE ename <= 'G';
--     EMPNO ENAME                       SAL
------------ -------------------- ----------
--      7499 ALLEN                      1600
--      7698 BLAKE                      2850
--      7782 CLARK                      2450
--      7902 FORD                       3000

--6. 날짜 <,<=,>,>=
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

--7. BETWEEN num AND num
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

--8. BETWEEN string AND string
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

--9. IN(a,b,c): a이거나 b이거나 c이거나
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

--10. LIKE
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

--1.AND
SELECT ename,hiredate,sal
FROM emp
WHERE hiredate >= '82/01/23' AND sal >= 1300;
--ENAME                HIREDATE        SAL
---------------------- -------- ----------
--MILLER               82/01/23       1300

--2.OR
SELECT ename,hiredate,sal
FROM emp
WHERE hiredate >= '82/01/23' OR sal >= 1300;
--ENAME                HIREDATE        SAL
---------------------- -------- ----------
--ALLEN                81/02/20       1600
--JONES                81/04/02       2975
--BLAKE                81/05/01       2850
--CLARK                81/06/09       2450
--KING                 81/11/17       5000
--TURNER               81/09/08       1500
--FORD                 81/12/03       3000
--MILLER               82/01/23       1300

--3.AND와 OR함께 사용
--우선순위는 AND > OR
--괄호를 통해 우선순위 지정가능
SELECT ename,hiredate,sal,comm
FROM emp
WHERE (sal > 1000 OR comm > 1000) AND comm IS NULL;
ENAME                HIREDATE        SAL       COMM
---------------------- -------- ---------- ----------
--JONES                81/04/02       2975
--BLAKE                81/05/01       2850
--CLARK                81/06/09       2450
--KING                 81/11/17       5000
--FORD                 81/12/03       3000
--MILLER               82/01/23       1300

--NULL: IS NULL/IS NOT NULL
--NULL 값은 사용주의 필요. 
--1+NULL 은 NULL이다.

--1.기본값 출력
SELECT empno,ename,comm,deptno
FROM emp;
--     EMPNO ENAME                      COMM     DEPTNO
------------ -------------------- ---------- ----------
--      7369 SMITH                                   20
--      7499 ALLEN                       300         30
--      7521 WARD                        500         30
--      7566 JONES                                   20
--      7654 MARTIN                     1400         30
--      7698 BLAKE                                   30
--      7782 CLARK                                   10
--      7839 KING                                    10
--      7844 TURNER                        0         30
--      7900 JAMES                                   30
--      7902 FORD                                    20
--      7934 MILLER                                  10

--2.comm이 null값인 데이터만 출력
SELECT empno,ename,comm,deptno
FROM emp
WHERE comm IS NULL;
--     EMPNO ENAME                      COMM     DEPTNO
------------ -------------------- ---------- ----------
--      7369 SMITH                                   20
--      7566 JONES                                   20
--      7698 BLAKE                                   30
--      7782 CLARK                                   10
--      7839 KING                                    10
--      7900 JAMES                                   30
--      7902 FORD                                    20
--      7934 MILLER                                  10

--3.comm이 null값이 아닌 데이터만 출력
--'0'은 null이 아니다.
SELECT empno,ename,comm,deptno
FROM emp
WHERE comm IS NOT NULL;
--     EMPNO ENAME                      COMM     DEPTNO
------------ -------------------- ---------- ----------
--      7499 ALLEN                       300         30
--      7521 WARD                        500         30
--      7654 MARTIN                     1400         30
--      7844 TURNER                        0         30

--PARAM
--사용자에게 조건을 입력받아서 출력
--7369 찾기

--1.WHERE 칼럼 = &칼럼
--위와 같이 입력하면 칼럼값을 입력받아 찾아 출력한다. 
SELECT ename,hiredate,sal,comm
FROM emp
WHERE empno = &empno;
--Enter value for empno: 7369
--ENAME                HIREDATE        SAL       COMM
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800

--2.SELECT에서도 조건받아 출력
SELECT ename,hiredate, sal,&age AS age
FROM emp
WHERE empno = &empno;
--ENAME                HIREDATE        SAL        AGE
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800         28

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