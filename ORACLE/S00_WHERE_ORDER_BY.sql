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