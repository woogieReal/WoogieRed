--���� �̿ܿ��� �� ���� ����ǥ�� ���!
--���ڴ� ��ҹ��ڸ� �����ϰ�, ��¥���� ��ҹ��� ������ ����.

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

--3. ���� =
--��������ǥ ���, ��ҹ��� ����
SELECT ename,empno
FROM emp
WHERE ename = 'SMITH';
--ENAME                     EMPNO
---------------------- ----------
--SMITH                      7369

--4. ��¥ =
--��������ǥ ���, ��ҹ��� ���о���
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate = '80/12/17';
--     EMPNO ENAME                HIREDATE
------------ -------------------- --------
--      7369 SMITH                80/12/17

--5. ���� <,<=,>,>=
SELECT empno, ename, sal
FROM emp
WHERE ename <= 'G';
--     EMPNO ENAME                       SAL
------------ -------------------- ----------
--      7499 ALLEN                      1600
--      7698 BLAKE                      2850
--      7782 CLARK                      2450
--      7902 FORD                       3000

--6. ��¥ <,<=,>,>=
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

--9. IN(a,b,c): a�̰ų� b�̰ų� c�̰ų�
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

--3.AND�� OR�Բ� ���
--�켱������ AND > OR
--��ȣ�� ���� �켱���� ��������
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

--PARAM
--����ڿ��� ������ �Է¹޾Ƽ� ���
--7369 ã��

--1.WHERE Į�� = &Į��
--���� ���� �Է��ϸ� Į������ �Է¹޾� ã�� ����Ѵ�. 
SELECT ename,hiredate,sal,comm
FROM emp
WHERE empno = &empno;
--Enter value for empno: 7369
--ENAME                HIREDATE        SAL       COMM
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800

--2.SELECT������ ���ǹ޾� ���
SELECT ename,hiredate, sal,&age AS age
FROM emp
WHERE empno = &empno;
--ENAME                HIREDATE        SAL        AGE
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800         28

--�����Ͽ� ����ϱ�: ORDER BY �÷�,�÷�
--�����Ͽ� ����ϱ�: ORDER BY 1 ASC, 2 DESC
--DEFAULT�� ASC
--ORDER BY�� ������ ���Ͻ�Ű�Ƿ� ������� �ʴ� ���� ����.
--������ ���� ���� �������� ��쿡�� �ε����� ����� �ͺ��� ����

--ASC
--�ѱ�: ������
--����: ABC
--����: 1234
--��¥: ������¥����

--1.sal���� ������������ ����
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

--2.Į�������� ��������
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