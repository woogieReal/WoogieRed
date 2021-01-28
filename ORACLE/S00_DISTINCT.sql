--DISTINCT �ߺ�����

--1. Į���ϳ� �ߺ�����
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

--2. Į������ �ߺ�����
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