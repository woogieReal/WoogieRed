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