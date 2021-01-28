--NULL: IS NULL/IS NOT NULL
--NULL ���� ������� �ʿ�. 
--1+NULL �� NULL�̴�.

--1.�⺻�� ���
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

--2.comm�� null���� �����͸� ���
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

--3.comm�� null���� �ƴ� �����͸� ���
--'0'�� null�� �ƴϴ�.
SELECT empno,ename,comm,deptno
FROM emp
WHERE comm IS NOT NULL;
--     EMPNO ENAME                      COMM     DEPTNO
------------ -------------------- ---------- ----------
--      7499 ALLEN                       300         30
--      7521 WARD                        500         30
--      7654 MARTIN                     1400         30
--      7844 TURNER                        0         30

