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

