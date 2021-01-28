--���� �̿ܿ��� �� ���� ����ǥ�� ���!
--���ڴ� ��ҹ��ڸ� �����ϰ�, ��¥���� ��ҹ��� ������ ����.

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

--3. (���� =)
--��������ǥ ���, ��ҹ��� ����
SELECT ename,empno
FROM emp
WHERE ename = 'SMITH';
--ENAME                     EMPNO
---------------------- ----------
--SMITH                      7369

--4. (��¥ =)
--��������ǥ ���, ��ҹ��� ���о���
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate = '80/12/17';
--     EMPNO ENAME                HIREDATE
------------ -------------------- --------
--      7369 SMITH                80/12/17

--5. (���� <,<=,>,>=)
SELECT empno, ename, sal
FROM emp
WHERE ename <= 'G';
--     EMPNO ENAME                       SAL
------------ -------------------- ----------
--      7499 ALLEN                      1600
--      7698 BLAKE                      2850
--      7782 CLARK                      2450
--      7902 FORD                       3000

--6. (��¥ <,<=,>,>=)
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
--BETWEEN ���� �ε�ȣ�� ������ ������
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

--9. (IN(a,b,c): a�̰ų� b�̰ų� c�̰ų�)
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
--%�� *�� ����(����)
--_�� �� ����(� ���ڰ� �͵� �������.)
--��������ǥ�� ���������
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
