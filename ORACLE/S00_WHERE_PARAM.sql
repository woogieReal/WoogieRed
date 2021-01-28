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