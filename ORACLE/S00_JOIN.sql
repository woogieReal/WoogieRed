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

--EQUI_JOIN: �����(=)
--�������� ���� ���̺��� �����͸� ������ �� �������� �˻��ؼ� ���� ������ ���� �����͸�
--�������̺��� ���� ���� ���

--emp���̺�� dept���̺��� ��ȸ�Ͽ� ������ȣ, �����̸�, �μ���ȣ, �μ��̸��� ����Ͻÿ�.

--ORACLE
SELECT empno, ename, t1.deptno, t2.dname
FROM emp t1, dept t2
WHERE t1.deptno = t2.deptno;

--ANSI
SELECT empno, ename, t1.deptno, t2.dname
FROM emp t1 JOIN dept t2
ON t1.deptno = t2.deptno;
--  EMPNO ENAME          DEPTNO DNAME
--------- ---------- ---------- -------------
--   7839 KING               10 ACCOUNTING
--   7782 CLARK              10 ACCOUNTING
--   7934 MILLER             10 ACCOUNTING
--   7902 FORD               20 RESEARCH
--   7369 SMITH              20 RESEARCH
--   7566 JONES              20 RESEARCH
--   7900 JAMES              30 SALES
--   7844 TURNER             30 SALES
--   7654 MARTIN             30 SALES
--   7521 WARD               30 SALES
--   7499 ALLEN              30 SALES
--   7698 BLAKE              30 SALES


--�л����̺�� �������̺��� ����, �л��̸��� �����̸��� ����
--ORACLE
SELECT t1.name"student", t2.name"professor"
FROM student t1, professor t2
WHERE t1.profno = t2.profno;

--ANSI
SELECT t1.name"student", t2.name"professor"
FROM student t1 JOIN professor t2
ON t1.profno = t2.profno;
--student             professor
--------------------  -------------------
--James Seo           Audie Murphy
--Billy Crystal       Angela Bassett
--Richard Dreyfus     Angela Bassett
--Tim Robbins         Winona Ryder
--Rene Russo          Winona Ryder
--Nicholas Cage       Michelle Pfeiffer
--Sandra Bullock      Julia Roberts
--Demi Moore          Meryl Streep
--Macaulay Culkin     Meryl Streep
--Wesley Snipes       Susan Sarandon
--Danny Glover        Nicole Kidman
--Micheal Keaton      Nicole Kidman
--Steve Martin        Nicole Kidman
--Daniel Day-Lewis    Jodie Foster
--Bill Murray         Jodie Foster

--ORACLE
--�л��̸�, �а��̸�, �л��� �������� �̸�
COL "student_name" FOR A20
COL "professor_name" FOR A20
COL "dept_name"  FOR A35
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t3.dname"dept_name" 
FROM student t1, professor t2, department t3
WHERE t1.profno = t2.profno
AND t1.deptno1 = t3.deptno
;
--student_name         professor_name       dept_name
---------------------- -------------------- -----------------------------------
--James Seo            Audie Murphy         Computer Engineering
--Billy Crystal        Angela Bassett       Computer Engineering
--Richard Dreyfus      Angela Bassett       Computer Engineering
--Tim Robbins          Winona Ryder         Multimedia Engineering
--Rene Russo           Winona Ryder         Multimedia Engineering
--Nicholas Cage        Michelle Pfeiffer    Multimedia Engineering
--Sandra Bullock       Julia Roberts        Software Engineering
--Macaulay Culkin      Meryl Streep         Electronic Engineering
--Demi Moore           Meryl Streep         Electronic Engineering
--Wesley Snipes        Susan Sarandon       Electronic Engineering
--Micheal Keaton       Nicole Kidman        Mechanical Engineering
--Danny Glover         Nicole Kidman        Mechanical Engineering
--Steve Martin         Nicole Kidman        Electronic Engineering
--Bill Murray          Jodie Foster         Library and Information science
--Daniel Day-Lewis     Jodie Foster         Library and Information science

--ANSI
COL "student_name" FOR A20
COL "professor_name" FOR A20
COL "dept_name"  FOR A35
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t3.dname"dept_name" 
FROM student t1 JOIN professor t2
ON t1.profno = t2.profno
JOIN department t3
ON t1.deptno1 = t3.deptno
;

--ORACLE
--student���̺�� professor���̺��� ��ȸ�Ͽ� �л��� ��1������ 101���� �л�����
--�̸�, ���������� ����ϼ���.
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t1.deptno1 
FROM student t1, professor t2
WHERE t1.profno = t2.profno
AND t1.deptno1 = 101
;
--student_name         professor_name          DEPTNO1
---------------------- -------------------- ----------
--James Seo            Audie Murphy                101
--Richard Dreyfus      Angela Bassett              101
--Billy Crystal        Angela Bassett              101

--ANSI
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t1.deptno1 
FROM student t1 JOIN professor t2
ON t1.profno = t2.profno
WHERE t1.deptno1 = 101
;

--ORACLE
--NON_EQUI_JOIN: �� ����
--CUSTOMER ���̺��, GIFT���̺��� ��ȸ�Ͽ� ������ ���ϸ��� ����Ʈ�� ��ȸ�Ͽ�,
--���ϸ����� ���� �� �ִ� ��ǰ�� ��ȸ�Ͽ���.
COL "CUSTOMER_NAME" FOR A20
COL "GIFT_NAME" FOR A20
SELECT t1.gname"CUSTOMER_NAME", t1.point"POINT", t2.gname"GIFT_NAME"
FROM customer t1, gift t2
WHERE t1.point BETWEEN t2.g_start AND t2.g_end
;

--ANSI
COL "CUSTOMER_NAME" FOR A20
COL "GIFT_NAME" FOR A20
SELECT t1.gname"CUSTOMER_NAME", t1.point"POINT", t2.gname"GIFT_NAME"
FROM customer t1 JOIN gift t2
ON t1.point BETWEEN t2.g_start AND t2.g_end
--ON t1.point >= t2.g_start 
--AND t1.point <= t2.g_end
;

--ORACLE
--�л����̺�� SCORE���̺�, HAKJUM���̺��� ��ȸ�Ͽ� �л��̸�, ����, ������ ����ϼ���

--SCORE     TYPE    NULL     --HAKJUM    TYPE    NULL
--STUDNO    NUMBER  YES      --GRADE     CHAR(3) YES
--TOTAL     NUMBER  YES      --MIN_POINT NUMBER  YES
                             --MAX_POINT NUMBER  YES




COL "STUDENT_NAEM" FOR A20
SELECT t3.name"STUDENT_NAEM", t1.total"SCORE", t2.grade"GRADE"
FROM score t1, hakjum t2, student t3
WHERE t1.total BETWEEN t2.min_point AND t2.max_point
AND t1.studno = t3.studno
;
--STUDENT_NAEM              SCORE GRADE
---------------------- ---------- ------
--James Seo                    97 A+
--Macaulay Culkin              95 A0
--Billy Crystal                92 A0
--Danny Devito                 91 A0
--Richard Dreyfus              89 B+
--Sean Connery                 88 B+
--Danny Glover                 88 B+
--Nicholas Cage                87 B+
--Daniel Day-Lewis             87 B+
--Wesley Snipes                86 B+
--Anthony Hopkins              84 B0
--Sandra Bullock               83 B0
--Charlie Sheen                83 B0
--Steve Martin                 82 B0
--Christian Slater             82 B0
--Micheal Keaton               81 B0
--Bill Murray                  79 C+
--Rene Russo                   78 C+
--Tim Robbins                  77 C+
--Demi Moore                   62 D

--ANSI
COL "STUDENT_NAEM" FOR A20
SELECT t3.name"STUDENT_NAEM", t1.total"SCORE", t2.grade"GRADE"
FROM score t1 JOIN hakjum t2
ON t1.total BETWEEN t2.min_point AND t2.max_point
JOIN student t3
ON t1.studno = t3.studno
;








