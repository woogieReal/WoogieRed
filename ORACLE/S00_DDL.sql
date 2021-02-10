--DDL��ɾ� ��ųʸ�
--DDL(Data Discription Language)
--CREATE, ALTER, TRUNCATE, DROP

--DML(Data Manipulation Language)
--INSERT, UPDATE, DELETE, MERGE

--DCL(Data Control Language)
--GRANT, REVOKE

--TCL(transaction Control Language)
--COMMIT, ROLLBACK

--DQL(Data Query Language)
--SELECT

--CREATE
--NUMBER(3): �ִ���� 3�ڸ��� ���� ������
--VARCHAR2(10): �⺻���� 10���� ���ڿ� ������, �������̸� ����
--DATE: ��¥ ������ 
--CREATE TABLE new_table(
--	no NUMBER(3),
--	name VARCHAR2(10),
--	birth DATE
--);

--���̺���� �������
--���̺��̸��� �ݵ�� ���ڷ� �����ؾ� ��(���ڷ� ������ �� ����)
--���̺� �÷��� �̸��� 30BYTE���� ����
--���̺� �̸��� �� ���� ����ڰ� �ٸ� ������Ʈ�� �̸��� �ߺ����� ����� �� ����.
--���̺� �̸��̳� �÷��̸��� ����Ŭ Ű����� �����ؼ��� �ȵ�

--DEFAULT �����ϱ�
CREATE TABLE tt02(
	no NUMBER(3,1) DEFAULT 0,
	name VARCHAR2(10 BYTE) DEFAULT 'No NAME',
	hiredate DATE DEFAULT SYSDATE
);

--INSERT INTO tt02(no) VALUES(1);
--commit;
--SELECT * FROM tt02;

--�ѱ����̺� ����
--������ �����ϳ� ���� ���� ����.
CREATE TABLE �ѱ����̺�(
	�÷�1 NUMBER,
	�÷�2 VARCHAR2,
	�÷�3 DATE
);

--���̺� �����ϱ�(CTAS)
--����÷� ����,������ ����

CREATE
TABLE dept3
AS
SELECT * FROM dept;

--���̺� ���翩�� Ȯ��
SELECT *
FROM tab
WHERE tname LIKE 'DEPT3%';



--���̺� ������ ��������(CATA)
CREATE TABLE dept4
AS
SELECT * FROM dept
WHERE 1=2;



--Ư�� �÷��� ��������
CREATE TABLE dept5
AS
SELECT deptno, dname
FROM dept;


--ALTER
--OBJECT�� �����ϴ� ��ɾ�
--�÷� �߰�, ����, ������ Ÿ�Լ���
--���ϰ� ���� �ɸ��� ��ɾ�� ��뷮�� ���� �ð��� �����ϸ� �ȵ�

CREATE TABLE dept6
AS
SELECT dcode, dname
FROM dept2
WHERE dcode IN(1000,1001,1002)
;

--�÷� �߰�
--ALTER TABLE dept6
--ADD (LOC VARCHAR2(10 BYTE));

--�÷��߰�
ALTER TABLE dept6
ADD (LOCATION VARCHAR2(10 BYTE));

--�÷��߰�&����Ʈ��
ALTER TABLE dept6
ADD (LOCATION2 VARCHAR2(10 BYTE) DEFAULT 'SEOUL');

--���̺� �÷��̸� ����
ALTER TABLE dept6
RENAME COLUMN LOCATION2 TO LOC02
;

--���̺��̸� ����
RENAME TABLE dept6 TO dept7;

--�÷��� ������ũ�� ����
ALTER TABLE dept6
MODIFY (LOC VARCHAR2(20 BYTE))
;

--�÷� ����
ALTER TABLE dept6
DROP COLUMN LOC
;

--����Ű�� �ִ� �÷�����
ALTER TABLE dept6
DROP COLUMN LOC CASCADE CONSTRAINTS;

--TRUNCATE
--���̺��� �����͸� �����ϰ� ����ϰ� �ִ� ������ �ݳ�(DELETE�� �����͸� ������)
TRUNCATE TABLE dept6;

--read_only ���̺� ����

CREATE TABLE t_readonly(
	no NUMBER,
	name VARCHAR2(10 BYTE)
);

ALTER TABLE t_readonly read only;

INSERT INTO t_readonly VALUES(1,'CCC')
;
ORA-12081: update operation not allowed on table "SCOTT"."T_READONLY"

ALTER TABLE t_readonly
ADD (tel VARCHAR2(15))
;
ORA-12081: update operation not allowed on table "SCOTT"."T_READONLY"

--�����÷�
--���̺� ������ ���� �÷��� ������ �� �ִ�.

--1. ���� �÷��� ������ ���̺� ����: �� �÷��� ���ϱ�
CREATE TABLE vt01(
	COL1 NUMBER,
	COL2 NUMBER,
	COL3 NUMBER GENERATED ALWAYS AS (COL1+COL2)
);

--2. ������ �Է�

--�����÷����� ���� ���� �Է��� �� ����
INSERT INTO vt01 VALUES(1,2,3)
;
ORA-54013: INSERT operation disallowed on virtual columns

INSERT INTO vt01(COL1,COL2) VALUES(1,2)
;
--      COL1       COL2       COL3
------------ ---------- ----------
--         1          2          3

--3. ������ ����
UPDATE vt01 SET COL1 = 5
;
--      COL1       COL2       COL3
------------ ---------- ----------
--         5          2          7

--4. ���ο� �����÷� �߰�
ALTER TABLE vt01
ADD (COL4 GENERATED ALWAYS AS (COL1*COL2))
;
--      COL1       COL2       COL3       COL4
------------ ---------- ---------- ----------
--         5          2          7         10

--5. �����÷��� DICTIONARY
COL column_name FOR A11
COL data_type FOR A10
COL data_default FOR A20
SELECT column_name,
	data_type,
	data_default
FROM user_tab_columns
WHERE table_name = 'VT01'
ORDER BY column_id
;
--COLUMN_NAME DATA_TYPE  DATA_DEFAULT
------------- ---------- -----------------
--COL1        NUMBER
--COL2        NUMBER
--COL3        NUMBER     "COL1"+"COL2"
--COL4        NUMBER     "COL1"*"COL2"

--������(CASE)�� Ȱ���� �����÷� ����
CREATE TABLE sales10(
	NO NUMBER,
	PCODE CHAR(4),
	PDATE CHAR(8),
	PQTY NUMBER,
	PBUNGI NUMBER(1) GENERATED ALWAYS AS(
		CASE
			WHEN SUBSTR(PDATE,5,2) IN('01','02','03') THEN 1
			WHEN SUBSTR(PDATE,5,2) IN('04','05','06') THEN 2
			WHEN SUBSTR(PDATE,5,2) IN('07','08','09') THEN 3
			WHEN SUBSTR(PDATE,5,2) IN('10','11','12') THEN 4
			END
	)virtual
)
;

INSERT INTO sales10(NO, PCODE, PDATE, PQTY) VALUES(1,'1000','20210210',1)
;
--        NO PCODE    PDATE                  PQTY     PBUNGI
------------ -------- ---------------- ---------- ----------
--         1 1000     20210210                  1          1

--DATA_DICTIONARY
--����Ŭ�� �����ͺ��̽��� ��ϱ� ���� �������� ��� Ư���� ���̺� ��Ƶΰ� ����
--�����ͺ��̽� �޸� ����
--������Ʈ���� ����ϴ� ��������
--��������
--����ڿ����� ����
--�����̳� ��������, �ѿ����� ����
--���翡 ���� ����

--DICTIONARY ����
--STATIC DICTIONARY(����): USER_XXX, ALL_XXX, DBA_XXX
--DYNAMIC DICTIONARY(�����ݿ�): V$_XXX

--1. TABLE ����
CREATE TABLE st_table(
	no number
);

--2. ������ �Է�
BEGIN
	FOR i IN 1..1000 LOOP
		INSERT INTO st_table VALUES(i);
	END LOOP;
	COMMIT;
END;
/

--3. STATIC��ȸ: �ݿ����� �����κ� Ȯ��
SELECT * FROM st_table
;

--4. �����ݿ�
SELECT num_rows,
	blocks
FROM user_tables
WHERE table_name = 'ST_TABLE'
;
--  NUM_ROWS     BLOCKS
------------ ----------

--4.1 ��ųʸ��� �����ڰ� �������� �ݿ�
ANALYZE TABLE ST_TABLE COMPUTE STATISTICS
;
--  NUM_ROWS     BLOCKS
------------ ----------
--      1000          5





