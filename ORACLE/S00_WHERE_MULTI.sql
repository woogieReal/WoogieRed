--�˻������� �� �� �̻�
--�켱������ AND, OR ��

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
