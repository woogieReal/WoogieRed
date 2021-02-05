--JOIN
--���� ���̺� ����� �ִ� �����͵��� �����ؼ� �������� ���
--ORACLE�� ANSI join ������ �ٸ�

--ORACLE JOIN
--SELECT t1.col1, t2.col1
--FROM table t1, table t2 //���� alias�� ����
--WHERE t1.col1 = t2.col1
--join������ where�� ����

--ANSI JOIN
--SELECT t1.col1, t2.col1
--FROM table t1 [INNER] JOIN table t2
--ON t1.col1 = t2.col1
--join ������ ON�� ����

--JOIN�� ���Ǵ� ���
--�������̺�(driving table, inner table)�� �������̺�(driven table, outer table)
--������ ���� �� �� �� �̻��� ���̺��� ���Ǵµ� �̶� �� �� �ϳ��� ���̺��� ���� �а�(�������̺�)
--JOIN�������� �̿��� ������ ���̺�(�������̺�)�� ���� �����͸� ������
--�������̺��� ��ȸ�� �����Ͱ� ���� ���̺�� �����ؾ� �ӵ��鿡�� ������

--CARTESIAN_PRODUCT
--JOIN ������ �߸� �ְų� �����ʾ��� �� �ش� ���̺� ���� ��� �����͸� �������� ����
--�Ϻη� ���⵵ ��
--�����͸� �����ؼ� ���� ���̺��� �ݺ��ؼ� �д� ���� ���ϱ� ����

--1.������ ���̺� ����
--CREATE TABLE�� COMMIT�� ���ص� ��
--DROP TABLE CAT_A;
--CREATE TABLE CAT_A (
--	no NUMBER,
--	name VARCHAR2(1)
--);
--
--DROP TABLE CAT_B;
--CREATE TABLE CAT_B (
--	no NUMBER,
--	name VARCHAR2(1)
--);
--
--DROP TABLE CAT_C;
--CREATE TABLE CAT_C (
--	no NUMBER,
--	name VARCHAR2(1)
--);

--2.������ ����
--INSERT INTO CAT_A VALUES (1,'A');
--INSERT INTO CAT_A VALUES (2,'B');
--
--INSERT INTO CAT_B VALUES (1,'C');
--INSERT INTO CAT_B VALUES (2,'D');
--						 
--INSERT INTO CAT_C VALUES (1,'E');
--INSERT INTO CAT_C VALUES (2,'F');

--COMMIT;

--3.������ ��ȸ
--COL NO FOR 99
--COL NAME FOR A4
--SELECT * FROM CAT_A;
--SELECT * FROM CAT_B;
--SELECT * FROM CAT_C;

-- NO NAME    NO NAME   NO NAME
----- ----   --- ----  --- ----
--  1 A        1 C       1 E
--  2 B        2 D       2 F

--JOIN 2�� ���̺�
SELECT t1.no
	,t1.name
	,t2.name
FROM cat_a t1, cat_b t2
WHERE t1.no = t2.no;
-- NO NAME NAME
----- ---- ----
--  1 A    C
--  2 B    D

--CARTESIAN PRODUCT
--WHERE�� JOIN ������ ������ ���� �ʾұ⿡ �߻�
SELECT t1.no
	,t1.name
	,t2.name
FROM cat_a t1, cat_b t2;
--WHERE t1.no = t2.no;
-- NO NAME NAME
----- ---- ----
--  1 A    C
--  1 A    D
--  2 B    C
--  2 B    D

--JOIN 3�� ���̺�
SELECT t1.no, t1.name, t2.name, t3.name
FROM cat_a t1, cat_b t2, cat_c t3
WHERE t1.no = t2.no AND t2.no = t3.no;
-- NO NAME NAME NAME
----- ---- ---- ----
--  1 A    C    E
--  2 B    D    F

--CARTESIAN PRODUCT
--WHERE�� JOIN ������ ������ ���� �ʾұ⿡ �߻�
SELECT t1.no, t1.name, t2.name, t3.name
FROM cat_a t1, cat_b t2, cat_c t3;
--WHERE t1.no = t2.no AND t2.no = t3.no;
-- NO NAME NAME NAME
----- ---- ---- ----
--  1 A    C    E
--  1 A    C    F
--  1 A    D    E
--  1 A    D    F
--  2 B    C    E
--  2 B    C    F
--  2 B    D    E
--  2 B    D    F

--CARTESIAN PRODUCT
--������ �� �۵��ϴ���(�ӵ��� ������) �׽�Ʈ�ϱ� ���ؼ� �뷮�� �����͸� ����� ���
--�����Ǽ� X level ��ŭ �����Ͱ� ����
SELECT *
FROM(
	SELECT empno, ename, job, sal
	FROM emp
	WHERE deptno = 10
)
,(
	SELECT LEVEL
	FROM dual
	CONNECT BY level <= 3
);
--  EMPNO ENAME       JOB             SAL  LEVEL
--------- ----------- ------------ ------ ------
--   7782 CLARK       MANAGER        2450      1
--   7839 KING        PRESIDENT      5000      1
--   7934 MILLER      CLERK          1300      1
--   7782 CLARK       MANAGER        2450      2
--   7839 KING        PRESIDENT      5000      2
--   7934 MILLER      CLERK          1300      2
--   7782 CLARK       MANAGER        2450      3
--   7839 KING        PRESIDENT      5000      3
--   7934 MILLER      CLERK          1300      3










