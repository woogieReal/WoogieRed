--DISTINCT 중복제거

--1. 칼럼하나 중복제거
SELECT DISTINCT job
FROM emp
ORDER BY job;
--JOB
--------------------
--ANALYST
--CLERK
--MANAGER
--PRESIDENT
--SALESMAN

--2. 칼럼다중 중복제거
SELECT DISTINCT ename, job
FROM emp
ORDER BY 1,2;
--ENAME                JOB
---------------------- ------------------
--ALLEN                SALESMAN
--BLAKE                MANAGER
--CLARK                MANAGER
--FORD                 ANALYST
--JAMES                CLERK
--JONES                MANAGER
--KING                 PRESIDENT
--MARTIN               SALESMAN
--MILLER               CLERK
--SMITH                CLERK
--TURNER               SALESMAN
--WARD                 SALESMAN