
--Sub Query(��������)
--�ϳ��� �����ȿ� �� �ٸ� ������ �ִ� ��
--SELECT COLUMN                  <- ��������(outer ����)
--FROM TABLE
--WHERE ���� (SELECT COLUMN FROM TABLE WHERE ����)             <- ��������(inner ����)
SELECT ename,
	comm
FROM emp
WHERE comm < (
	SELECT comm
	FROM emp
	WHERE ename = 'WARD'
	)
;
--ENAME                      COMM
---------------------- ----------
--ALLEN                       300
--TURNER                        0

--���������� ����
--1. ������ ��������: ���������� ������ ���� 1row�� ���
--������) <,>,=,<>���� ����

--Anthony Hopkins�� ���� �а��� ������� �̸��� �а��̸� ���
SELECT t1.name, t2.dname
FROM student t1, department t2
WHERE deptno1 = (
	SELECT deptno1
	FROM student
	WHERE name = 'Anthony Hopkins'
)
AND t1.deptno1 = t2.deptno
;
--NAME                DNAME
--------------------- -----------------------------
--Anthony Hopkins     Software Engineering
--Sandra Bullock      Software Engineering

--Meg Ryan�� �Ի��Ϻ��� ���� ����� �̸�, �Ի���, �μ����� ���
SELECT t1.name, t1.hiredate, t2.dname
FROM professor t1, department t2
WHERE hiredate > (
	SELECT hiredate
	FROM professor
	WHERE name ='Meg Ryan'
	)
AND t1.deptno = t2.deptno
;
--NAME                       HIREDATE DNAME
---------------------------- -------- -----------------------------------------
--Angela Bassett             87/01/30 Computer Engineering
--Jessica Lange              98/03/22 Computer Engineering
--Winona Ryder               01/09/01 Multimedia Engineering
--Michelle Pfeiffer          85/11/30 Multimedia Engineering
--Julia Roberts              97/07/01 Software Engineering
--Sharon Stone               02/02/24 Software Engineering
--Susan Sarandon             09/08/30 Electronic Engineering
--Nicole Kidman              99/12/01 Mechanical Engineering
--Holly Hunter               09/01/28 Mechanical Engineering
--Andie Macdowell            10/06/28 Library and Information science
--Jodie Foster               01/05/23 Library and Information science

--�а���ȣ 201�� ��ո����Ժ��� �����԰� ���� �л��� �̸��� ������ ���
SELECT name, weight
FROM student
WHERE weight > (
	SELECT AVG(weight)
	FROM student
	WHERE deptno1 = 201
	)
;
--NAME                           WEIGHT
---------------------------- ----------
--James Seo                          72
--Demi Moore                         83
--Danny Glover                       70
--Richard Dreyfus                    72
--Tim Robbins                        70
--Wesley Snipes                      82
--Christian Slater                   69
--Charlie Sheen                      81

--2. ������ ��������: ���������� ������ ���� 2row�̻�
--������) exists, in, >any, <any, >all, <all
--IN: ���������� ����� ���� ���� ã��
--EXISTS: �������� ���� ������ ��� ���������� ����
-->ANY: ���������� ��� �߿� �ּҰ�
--<ANY: ���������� ��� �߿� �ִ밪
-->ALL: ���������� ��� �߿� �ִ밪
--<ALL: ���������� ��� �߿� �ּҰ�

--Section head ������ �ּҿ����ں��� �� ���� ������ �޴� ����� �̸�, ����, ������ ���
SELECT name, position, TO_CHAR(pay,'$9,999,999,999,999') SALARY
FROM emp2
WHERE pay > ANY (
	SELECT pay
	FROM emp2
	WHERE position = 'Section head'
	)
ORDER BY pay DESC
;
--NAME                  POSITION                  SALARY
----------------------- ------------------------- ----------------------
--Kurt Russell          Boss                             $100,000,000
--Kevin Bacon           Department head                   $75,000,000
--AL Pacino             Department head                   $72,000,000
--Val Kilmer            Department head                   $68,000,000
--Tommy Lee Jones       Deputy department head            $60,000,000
--Gene Hackman          Section head                      $56,000,000
--Hugh Grant            Section head                      $51,000,000
--Woody Harrelson       Section head                      $50,000,000

--2�г� �л� �� ���� ü���� ���Գ����� �л����� �� ���Գ����� �л��� �̸��� �г�, ������ ���
SELECT name, grade, weight
FROM student
WHERE weight < all (
	SELECT weight
	FROM student
	WHERE grade = 2
	)
;
--NAME                    GRADE     WEIGHT
-------------------- ---------- ----------
--Billy Crystal               3         48
--Nicholas Cage               3         42
--Danny Devito                1         48

--���� ��տ����� ���� �μ��� ��տ������� ���� �޴� �������� �μ���, ������, ������ ���
SELECT t2.dname, t1.name, t1.pay
FROM emp2 t1, dept2 t2
WHERE pay < all (
	SELECT AVG(pay) OVER(PARTITION BY deptno)
	FROM emp2
	)
AND t1.deptno = t2.dcode
;
--DNAME                  NAME                       PAY
------------------------ ------------------- ----------
--H/W Support Team       Harrison Ford         20000000
--S/W Support Team       Clint Eastwood        20000000
--Sales1 Team            JohnTravolta          22000000
--Sales2 Team            Robert De Niro        22000000
--Sales3 Team            Sly Stallone          22000000
--Sales4 Team            Tom Cruise            20000000

--IN
SELECT empno, name, deptno
FROM emp2
WHERE deptno IN (
	SELECT dcode
	FROM dept2
	WHERE area = 'Pohang Main Office'
	)
;
--     EMPNO NAME                      DEPTNO
------------ ------------------------- ------------
--  19900101 Kurt Russell              0001
--  19966102 Kevin Bacon               1003
--  19970112 Val Kilmer                1006
--  19960212 Chris O'Donnell           1007

--EXISTS
--���������� ������ ���� �����ϰ� �� ����� 1���̶� ���ȸ� �������� ����
--�� �ǵ� ������ ������ ���������� ���� �ȵ�
--���������� true/false��� ���� true�� ���������� ����Ǵ� ��
SELECT *
FROM dept
WHERE EXISTS(
	SELECT deptno
	FROM dept
	WHERE deptno = &deptno
	)
;

--3. �����÷� ��������
--���������� �������� ���� �÷��� ���
--pk�� ���� �÷��� ���� ��� �Ѳ����� ���ϱ� ���� ���
--�� �г⺰�� �ִ� �����Ը� ���� �л����� �̸��� ������ ���
SELECT t2.grade,
	t2.name,
	t2.weight
FROM student t2
WHERE (t2.grade, t2.weight) IN (
	SELECT grade, MAX(t1.weight)"max_weight"
	FROM student t1
	GROUP BY grade
	)
ORDER BY 1
;
--   GRADE NAME                 WEIGHT
---------- ---------------- ----------
--       1 Charlie Sheen            81
--       2 Wesley Snipes            82
--       3 Bill Murray              58
--       4 Demi Moore               83

--�� �а����� �Ի����� ���� ������ ������ ������ȣ�� �̸�, �а����� ���
SELECT t1.profno, t1.name, t1.hiredate, t2.dname
FROM professor t1, department t2
WHERE (t1.deptno, t1.hiredate) IN (
	SELECT deptno, MIN(hiredate) min_hire
	FROM professor
	GROUP BY deptno
	)
AND t1.deptno = t2.deptno
ORDER BY hiredate
;
--  PROFNO NAME               HIREDATE DNAME
---------- ------------------ -------- -------------------------------------
--    1001 Audie Murphy       80/06/23 Computer Engineering
--    4001 Meryl Streep       81/10/23 Electronic Engineering
--    3001 Emma Thompson      81/10/23 Software Engineering
--    2003 Whoopi Goldberg    82/04/29 Multimedia Engineering
--    4005 Meg Ryan           85/09/18 Chemical Engineering
--    4003 Nicole Kidman      99/12/01 Mechanical Engineering
--    4007 Jodie Foster       01/05/23 Library and Information science

--4. ��ȣ����_��������
--���������� ���������� ���� �ְ� ������ ����
--������ ���� ���� ��������

--������ �� �ڽ��� ������տ����� ���ų� ���� �޴� ������� �̸�, ����, ���翬�� ���
SELECT t1.name,
	t1.position,
	TO_CHAR(t1.pay,'$999,999,999,999')"SALARY"
FROM emp2 t1
WHERE t1.pay >= (
	SELECT AVG(pay)
	FROM emp2 t2
	WHERE t1.position = t2.position
);
--NAME                POSITION                     SALARY
--------------------- ---------------------------- ---------------------
--Kurt Russell        Boss                              $100,000,000
--AL Pacino           Department head                    $72,000,000
--Tommy Lee Jones     Deputy department head             $60,000,000
--Gene Hackman        Section head                       $56,000,000
--Kevin Bacon         Department head                    $75,000,000
--Keanu Reeves        Deputy Section chief               $35,000,000

--5. ��Į��_��������
--select���� ���� ���������� �� ���� ����� 1�྿ ��ȯ
--����ϰ��� �ϴ� �������� ���� ���� ���� ��Į�� ���������� join���� ����

--��Į�� ���������� ����� ������� �̸��� �μ� �̸��� ���
SELECT t1.name,
	(SELECT t2.dname 
	FROM dept2 t2 
	WHERE t2.dcode = t1.deptno
	)"dname"
FROM emp2 t1
;
--NAME                      dname
--------------------------- -------------------------------
--Kurt Russell              President
--AL Pacino                 Management Support Team
--Woody Harrelson           Management Support Team
--Tommy Lee Jones           Financial Management Team
--Gene Hackman              General affairs
--Kevin Bacon               Engineering division
--Hugh Grant                H/W Support Team
--Keanu Reeves              S/W Support Team
--Val Kilmer                Business Department
--Chris O'Donnell           Business Planning Team
--Jack Nicholson            Sales1 Team
--Denzel Washington         Sales2 Team
--Richard Gere              Sales3 Team
--Kevin Costner             Sales4 Team
--JohnTravolta              Sales1 Team
--Robert De Niro            Sales2 Team
--Sly Stallone              Sales3 Team
--Tom Cruise                Sales4 Team
--Harrison Ford             H/W Support Team
--Clint Eastwood            S/W Support Team

--6. with_��������
--with���� ����Ͽ� ���ϴ� ���̺��� �޸𸮿� ���� �� �����͸� �������� ���
--������ ��������� ������ �����

--1. ���� ���� ���̺�
WITH A AS
(
	SELECT Query
)

--2. ���� ���� ���̺�
WITH a AS(
	SELECT query
), b AS (
	SELECT query
)
SELECT * from a
SELECT * from b
;

--���ǻ���
--with������ select���常 ��밡��
--with���� �� �ٸ� with ���� ����� �� ����.

--1. ��뷮�� ���̺��� ������ �� �ִ밪�� �ּڰ��� ���̸� ���ϱ�
--1.1. ��뷮�� ���̺��� ����� ���� ������ �α���, ���� �뷮�� ���� ��Ű���� option ����
--1.2. SCOTT �������� �α���
--1.3. �׽�Ʈ�� ���̺� ���� 5,000,000�� ������ �Է�
--1.4. min, max�� �ִ� �ּҸ� ���ϰ� �ð� ����
--1.5. �ε����� ������ �� �ִ�/�ּҸ� ���ϰ� �ð� ����
--1.6. with���� ����Ͽ� �ִ�/�ּҸ� ���ϰ� �ð� ����

SELECT tablespace_name,
	bytes/(1024*1024) "MB",
	file_name
FROM dba_data_files
;
--TABLESPACE_NAME              MB FILE_NAME
---------------------- ---------- ----------------------------------------------
--USERS                       100 C:\APP\APP\ORACLE\ORADATA\XE\USERS.DBF
--SYSAUX                      660 C:\APP\APP\ORACLE\ORADATA\XE\SYSAUX.DBF
--UNDOTBS1                    380 C:\APP\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF
--SYSTEM                      360 C:\APP\APP\ORACLE\ORADATA\XE\SYSTEM.DBF

--1.1. ��뷮�� ���̺��� ����� ���� ������ �α���, ���� �뷮�� ���� ��Ű���� option ����
ALTER DATABASE DATAFILE 'C:\APP\APP\ORACLE\ORADATA\XE\USERS.DBF'
AUTOEXTEND ON
;
--Database altered.

--1.2. SCOTT �������� �α���
conn scott/sist
--Connected.

--1.3. �׽�Ʈ�� ���̺� ���� 5,000,000�� ������ �Է�
DROP TABLE with_test1;
CREATE TABLE with_test1(
	no NUMBER,
	name VARCHAR2(10),
	pay NUMBER(6)
)TABLESPACE USERS
;
--Table created.

BEGIN
	FOR i IN 1..5000000 LOOP
		INSERT INTO with_test1 VALUES(
			i,
			DBMS_RANDOM.STRING('A',5),
			DBMS_RANDOM.VALUE(6,999999)
		);
	END LOOP;
	COMMIT;
END;
/

SELECT COUNT(*) FROM with_test1
;
--  COUNT(*)
------------
--   5000000

--1.4. min, max�� �ִ� �ּҸ� ���ϰ� �ð� ����
SELECT MAX(pay)-MIN(pay)
FROM with_test1
;
--MAX(PAY)-MIN(PAY)
-------------------
--           999993
--
--Elapsed: 00:00:00.20

--1.5. �ε����� ������ �� �ִ�/�ּҸ� ���ϰ� �ð� ����
CREATE INDEX idx_with_pay
ON with_test1(pay)
;
--Elapsed: 00:00:03.53

--1.5.1. �ε����� �׻� �������� �ʴ�
SELECT MAX(pay)-MIN(pay)
FROM with_test1
WHERE pay > 0
;
--Elapsed: 00:00:01.33

--1.6. with���� ����Ͽ� �ִ�/�ּҸ� ���ϰ� �ð� ����

--a: ��Ʈ�� ����Ͽ� ASC �ε����� DESC�� �Ͽ� MAX�� ���
--b: MIN ���� ���
WITH a AS (
	SELECT /*+ index_desc(t1 idx_with_pay)*/ pay
	FROM with_test1 t1
	WHERE pay > 0
	AND rownum = 1
),  b AS (
	SELECT /*+ index(t1 idx_with_pay)*/ pay
	FROM with_test1 t1
	WHERE pay > 0
	AND rownum = 1
)
SELECT a.pay, b.pay, a.pay - b.pay
FROM a, b
;
--       PAY        PAY A.PAY-B.PAY
------------ ---------- -----------
--    999999          6      999993

--Elapsed: 00:00:00.02 //--with ����
--Elapsed: 00:00:00.20 //--�Ϲ� ����

--with_test1 ���̺��� no 120000������ 130000������ ����� �� ���� pay��
--���� ����� ���� �� �� ������� pay�� ���� ��� ���� ���� �۾�.
--1. no �÷��� �ε��� ����
--2. ���������� �̿��ؼ� ������ ��ȸ �� �ð� ����
--3. with���� �̿��ؼ� ������ ��ȸ �� �ð� ����.

--1. no �÷��� �ε��� ����
CREATE INDEX idx_with_no
ON with_test1(no)
;
--Index created.

--2. ���������� �̿��ؼ� ������ ��ȸ �� �ð� ����
SELECT COUNT(*)
FROM with_test1
WHERE pay < ALL (
	SELECT /*+ INDEX(t1 idx_with_no) */pay
	FROM with_test1
	WHERE no BETWEEN 120000 AND 130000
);
--  COUNT(*)
------------
--       257
--Elapsed: 00:00:02.33

--3. with���� �̿��ؼ� ������ ��ȸ �� �ð� ����.
WITH t AS (
	SELECT /*+ INDEX(t1 idx_with_no) */MIN(pay) min_pay
	FROM with_test1 t1
	WHERE no BETWEEN 120000 AND 130000
)
SELECT COUNT(*)
FROM with_test1 t1, t
WHERE t1.pay < t.min_pay
;
--  COUNT(*)
------------
--       257
--Elapsed: 00:00:00.01

--�ݺ����� ���̺��� �� ���� �����ϵ��� �ϰ� �ҿ� �ð� ����
--pay �߿� ���� ���� ����, ���� ū ��, �׸��� ���� ū ���� ���� ���� �� ���̸� ���

--pay�� ���� �ε��� ����
DROP INDEX idx_with_pay
;
--Index dropped.

--UNION ALL
SELECT 'MAX_PAY' C1, MAX(PAY) "RESULT" FROM with_test1
UNION ALL
SELECT 'MIN_PAY' C1, MIN(PAY) FROM with_test1
UNION ALL
SELECT 'MAX-MIN' C1, MAX(PAY) - MIN(PAY) FROM with_test1
;
--C1                 RESULT
---------------- ----------
--MAX_PAY            999999
--MIN_PAY                 6
--MAX-MIN            999993
--
--Elapsed: 00:00:00.41

WITH sub_pay AS (
	SELECT MAX(pay) max_pay, MIN(pay) min_pay
	FROM with_test1
)
SELECT 'MAX_PAY' C1, max_pay "RESULT" FROM sub_pay
UNION ALL
SELECT 'MIN_PAY' C1, min_pay FROM sub_pay
UNION ALL
SELECT 'MAX-MIN' C1, (max_pay - min_pay) FROM sub_pay
;
--C1                 RESULT
---------------- ----------
--MAX_PAY            999999
--MIN_PAY                 6
--MAX-MIN            999993
--
--Elapsed: 00:00:00.18



