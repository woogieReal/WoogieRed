--INSERT

--�⺻
INSERT INTO dept2(DCODE, DNAME, PDEPT, AREA)
VALUES(9000,'temp_1',1006,'temp_area')
;
--DCODE        DNAME                         PDEPT        AREA
-------------- ----------------------------- ------------ --------------------------
--0001         President                                  Pohang Main Office
--1000         Management Support Team       0001         Seoul Branch Office
--1001         Financial Management Team     1000         Seoul Branch Office
--1002         General affairs               1000         Seoul Branch Office
--1003         Engineering division          0001         Pohang Main Office
--1004         H/W Support Team              1003         Daejeon Branch Office
--1005         S/W Support Team              1003         Kyunggi Branch Office
--1006         Business Department           0001         Pohang Main Office
--1007         Business Planning Team        1006         Pohang Main Office
--1008         Sales1 Team                   1007         Busan Branch Office
--1009         Sales2 Team                   1007         Kyunggi Branch Office
--1010         Sales3 Team                   1007         Seoul Branch Office
--1011         Sales4 Team                   1007         Ulsan Branch Office
--9000         temp_1                        1006         temp_area

--�÷��� ����
INSERT INTO dept2
VALUES(9001,'temp_2',1006,'temp_area')
;
--DCODE        DNAME                          PDEPT        AREA
-------------- ------------------------------ ------------ -----------------------
--0001         President                                   Pohang Main Office
--1000         Management Support Team        0001         Seoul Branch Office
--1001         Financial Management Team      1000         Seoul Branch Office
--1002         General affairs                1000         Seoul Branch Office
--1003         Engineering division           0001         Pohang Main Office
--1004         H/W Support Team               1003         Daejeon Branch Office
--1005         S/W Support Team               1003         Kyunggi Branch Office
--1006         Business Department            0001         Pohang Main Office
--1007         Business Planning Team         1006         Pohang Main Office
--1008         Sales1 Team                    1007         Busan Branch Office
--1009         Sales2 Team                    1007         Kyunggi Branch Office
--1010         Sales3 Team                    1007         Seoul Branch Office
--1011         Sales4 Team                    1007         Ulsan Branch Office
--9000         temp_1                         1006         temp_area
--9001         temp_2                         1006         temp_area

--Ư���÷����� ���� �Է�
INSERT INTO dept2(DCODE, DNAME, PDEPT)
VALUES(9003,'temp_3',1006)
;
--DCODE        DNAME                         PDEPT        AREA
-------------- ----------------------------- ------------ ------------------------
--0001         President                                  Pohang Main Office
--1000         Management Support Team       0001         Seoul Branch Office
--1001         Financial Management Team     1000         Seoul Branch Office
--1002         General affairs               1000         Seoul Branch Office
--1003         Engineering division          0001         Pohang Main Office
--1004         H/W Support Team              1003         Daejeon Branch Office
--1005         S/W Support Team              1003         Kyunggi Branch Office
--1006         Business Department           0001         Pohang Main Office
--1007         Business Planning Team        1006         Pohang Main Office
--1008         Sales1 Team                   1007         Busan Branch Office
--1009         Sales2 Team                   1007         Kyunggi Branch Office
--1010         Sales3 Team                   1007         Seoul Branch Office
--1011         Sales4 Team                   1007         Ulsan Branch Office
--9000         temp_1                        1006         temp_area
--9001         temp_2                        1006         temp_area
--9003         temp_3                        1006

--��¥ ������ �Է��ϱ�
--PROFNO
--NAME
--ID
--POSITION
--PAY
--HIREDATE

INSERT INTO professor(PROFNO, NAME, ID, POSITION, PAY, HIREDATE)
VALUES(5001, 'James Bond','Love me','a full professor', 500, '2014-10-23')
;

--NULL ó��
--1. �ڵ� NULL �� �Է�
--�����͸� �Է��� �� �÷��� ���� �Է����� ������ �ڵ����� NULL���� ����.
--2. ���� NULL �� �Է�
--�����͸� �Է��� �� NULL�� �����ָ� �ȴ�.

--���̺� ����
CREATE TABLE t_minus(
	no1 NUMBER,
	no2 NUMBER(3),
	no3 NUMBER(3,2)
);

--������
INSERT INTO t_minus
VALUES(1,1,1)
;
COMMIT;

--�Ҽ���
--NUMBER��� ������Ÿ���� �����ϸ� �Ҽ��� ����
--���̸� ���� �����ϸ� �Ҽ��ڸ��� ������ �����
INSERT INTO t_minus
VALUES(1.1,1.1,1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1

--������
--���� ������ �ʿ����
INSERT INTO t_minus
VALUES(-1.1,-1.1,-1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1
--      -1.1         -1       -1.1

--INSERT�� ���� �ٰ� �Է�

--���̺� ������ ��������
CREATE
TABLE professor3
AS
SELECT * FROM professor
WHERE 1=2
;

SELECT COUNT(*) FROM professor3
;

--������ ���� ����
INSERT INTO professor3
SELECT * FROM professor
;
COMMIT
;
SELECT COUNT(*) FROM professor3
;

--INSERT ALL
--���� ���̺� ������ �Է�

--CREATE TABLE prof_4(
--	profno NUMBER,
--	name VARCHAR2(25)
--);

--SELECT profno
--	,name
--FROM professor;

INSERT ALL
WHEN profno BETWEEN 1000 AND 1999 THEN
	INTO prof_3 VALUES(profno, name)
WHEN profno BETWEEN 2000 AND 2999 THEN
	INTO prof_4 VALUES(profno, name)
SELECT profno
	,name
FROM professor
;

INSERT ALL
INTO prof_3 VALUES(profno, name)
INTO prof_4 VALUES(profno, name)
SELECT profno
	,name
FROM professor
WHERE profno BETWEEN 3000 AND 3999
;

--UPDATE
--������ �����͸� �ٸ� �����ͷ� ������ �� ���
--UPDATE TABLE
--SET column = value
--WHERE ����;
--(SELECT�� ���� ����, ����� Ȯ���ϰ� ������ ��)
--�Ǽ��� ���: ROLLBACK;

--UPDATE professor
--SET bonus = 200
--WHERE position = 'assistant professor'
--;

--SELECT profno,
--	name,
--	bonus
--FROM professor
--WHERE position = 'assistant professor'
--;

--��2
--SELECT profno,
--	name,
--	position,
--	pay
--FROM professor
--WHERE position = (
--	SELECT position
--	FROM professor
--	WHERE name = 'Sharon Stone'
--)
--AND pay < 250
--;

UPDATE professor
SET pay = pay*1.15
WHERE position = (
	SELECT position
	FROM professor
	WHERE name = 'Sharon Stone'
)
AND pay < 250
;

--DELETE
--SELECT dcode,
--	dname
--FROM dept2
--WHERE dcode BETWEEN 9000 AND 9999
--;

--DELETE
--FROM dept2
--WHERE dcode BETWEEN 9000 AND 9999
--;

--MERGE
--���� ���̺��� �����͸� ��ġ�� ������ �ǹ�

--MERGE INTO TABLE1
--USING TABLE2
--ON (��������)
--WHEN MATCHED THEN
--	UPDATE(DELETE) SET ������Ʈ����
--WHEN NOT MATCHED THEN
--	INSERT VALUES(��)

--CREATE TABLE charge01 (
--	u_date VARCHAR2(6),
--	cust_no NUMBER,
--	u_time NUMBER,
--	change NUMBER
--);
--
--CREATE TABLE charge02 (
--	u_date VARCHAR2(6),
--	cust_no NUMBER,
--	u_time NUMBER,
--	change NUMBER
--);

--INSERT INTO charge01 VALUES('141001', 1000, 2, 1000);
--INSERT INTO charge01 VALUES('141001', 1001, 2, 1000);
--INSERT INTO charge01 VALUES('141001', 1002, 1, 500);

--INSERT INTO charge02 VALUES('141002', 1000, 3, 1500);
--INSERT INTO charge02 VALUES('141002', 1001, 4, 2000);
--INSERT INTO charge02 VALUES('141002', 1003, 1, 500);

--CREATE
--TABLE ch_total
--AS
--SELECT *
--FROM charge01
--WHERE 1=2
--;

MERGE INTO ch_total t1
USING charge01 t2
ON (t1.u_date = t2.u_date)
WHEN MATCHED THEN
	UPDATE SET t1.cust_no = t2.cust_no
WHEN NOT MATCHED THEN
	INSERT VALUES(t2.u_date, t2.cust_no, t2.u_time, t2.change
);

--MERGE INTO ch_total t1
--USING charge02 t2
--ON (t1.u_date = t2.u_date)
--WHEN MATCHED THEN
--	UPDATE SET t1.cust_no = t2.cust_no
--WHEN NOT MATCHED THEN
--	INSERT VALUES(t2.u_date, t2.cust_no, t2.u_time, t2.change
--);

--UPDATE ����
--�ٸ� ���̺�� ������ �ϴ� UPDATE��

--WHERE������ �ٸ� ���̺�� ������
--emp���̺��� �μ��� DALLAS�� ��ġ�ϴ� �μ��� �ٹ��ϴ� ����� �޿��� 10%�λ� �ϼ���.

--loc�� DALLAS�� ����
--SELECT *
--FROM emp t1
--WHERE EXISTS(
--	SELECT *
--	FROM dept t2
--	WHERE t2.loc = 'DALLAS'
--	AND t1.deptno = t2.deptno
--);
--
UPDATE emp t1
SET sal = sal*1.10
WHERE EXISTS(
	SELECT *
	FROM dept t2
	WHERE t2.loc = 'DALLAS'
	AND t1.deptno = t2.deptno
);
--
--SELECT *
--FROM emp t1
--WHERE EXISTS(
--	SELECT *
--	FROM dept t2
--	WHERE t2.loc = 'DALLAS'
--	AND t1.deptno = t2.deptno
--);

--TRANSACTION ����
--������ �۾������� �ǹ�
--DML�۾����� �ϳ��� ������ ���� �� ���� �ǹ�
--�ش� Ʈ����� ���� �ִ� ��� DML�� �����ؾ� �ش� Ʈ������� �����ϴ°��̰�
--���� 1���� DML�̶� �����ϸ� ��ü�� �����ϰ� �ȴ�.
--DML�۾��� �� �Ŀ��� �ݵ�� COMMIT �̳� ROLLBACK ����� �����ؾ� �۾��� ��������

--DELETE ���� ���̺� �뷮Ȯ��
--1. �׽�Ʈ ���̺��� �����Ѵ�.
--1.1. �뷮�� ������ �Է�
--2. ���̺��� ũ�� ����
--3. ������ ���� �� ���̺��� ũ�� Ȯ��
--C:\oraclexe\app\oracle\oradata\XE\USERS.DBF

--USERS.DBF �ڵ����� �����ϵ��� ����.
--ALTER DATABASE DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\USERS.DBF' AUTOEXTEND on;

--1. �׽�Ʈ ���̺��� �����Ѵ�.
CREATE TABLE scott.reorg(
	no NUMBER,
	name VARCHAR2(20 BYTE),
	address VARCHAR2(20 BYTE)
);

--1.1. �뷮�� ������ �Է�
BEGIN 
	FOR i IN 1..500000 LOOP
		INSERT INTO scott.reorg VALUES(i, DBMS_RANDOM.STRING('U',19), DBMS_RANDOM.STRING('U',19));
	END LOOP;
	COMMIT;
	
END;
/

--DBMS_RANDOM.STRING
--���� ���ڿ� �����Ѵ�
--SYSNTAX: DBMS_RANDOM.STRING opt IN CHAR, len IN NUMBER
--opt(�ɼ�)�� �Ʒ��� ����.
--'u', 'U': �빮��
--'l', 'L': �ҹ���
--'a', 'A': ��ҹ��� ���о��� ������
--'x', 'X': �����ڿ� ���� ȥ��
--'p', 'P': ���� ȥ��

--2. ���̺��� ũ�� ����
SELECT bytes/(1024*1024) "MB"
FROM dba_segments
WHERE owner = 'SCOTT'
AND segment_name = 'REORG'
;
--        MB
------------
--        28

--2.1. dba_tables
--static dictionary �������� ���� update
ANALYZE TABLE scott.reorg COMPUTE STATISTICS;
SELECT table_name,
	num_rows,
	blocks
FROM dba_tables
WHERE owner = 'SCOTT'
AND table_name = 'REORG'
;
--TABLE_NAME     NUM_ROWS     BLOCKS
-------------- ---------- ----------
--REORG            500000       3520

--3. ������ ���� �� ���̺��� ũ�� Ȯ��
DELETE
FROM scott.reorg;
commit
;

SELECT COUNT(*) FROM scott.reorg;
--  COUNT(*)
------------
--         0

SELECT bytes/(1024*1024) "MB"
FROM dba_segments
WHERE owner = 'SCOTT'
AND segment_name = 'REORG'
;
--        MB
------------
--        28

--���� ����ϰ� �ִ� block��ȸ 
SELECT COUNT(DISTINCT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid)
	|| DBMS_ROWID.ROWID_RELATIVE_FNO(rowid)) "REAL_USED"
FROM scott.reorg
;
-- REAL_USED
------------
--         0

--���̺� reorg(�籸��)����.

--tablespace_nameȮ��
SELECT table_name,
	tablespace_name
FROM dba_tables
WHERE owner = 'SCOTT'
AND table_name = 'REORG'
;
--TABLE_NAME     TABLESPACE_NAME
---------------- ------------------
--REORG          USERS


--���̺��� �ٸ���ҷ� �ű�� ��ɾ����� ���� ���̺� �����̽� �̸��� �����ָ� �뷮�� ������
ALTER TABLE scott.reorg MOVE TABLESPACE USERS;

SELECT bytes/(1024*1024) "MB"
FROM dba_segments
WHERE owner = 'SCOTT'
AND segment_name = 'REORG'
;
--        MB
------------
--     .0625