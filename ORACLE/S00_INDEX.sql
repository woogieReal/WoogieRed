--OLTP: B-Tree �ε��� ���(�ǽð� ������ ������ϴ� �뵵)
--OLAP: BITMAP �ε��� ���(�뷮�� �����͸� �м��ϴ� �뵵)

--B-TREE �ε���
--Root Block, Branch Block, Leaf Block���� ����
--������ �����Ͱ� ����ִ� ���� Leaf Block

--������: Leaf Block -> Branch Block -> Root Block
--������ ��ȸ��: Root Block -> Branch Block -> Leaf Block

--B-Tree�� B�� Binary�� �ǹ̵� �ְ� Balance��� �ǹ̵� �ִ�.
--Root Block�� �������� ���ʰ� ������ �������� balance�� ���� �� ������ ���

--B-Tree �ε���: 
--1. Unique Index
--2. NONE Unique Index
--3. Function Based Index(�Լ���� �ε���)
--4. Descending Index(�������� �ε���)
--5. Composite Index(���� �ε���)

--BITMAP INDEX
--OLAP���� �ַ� ����
--B-TREE�� ���� ������ ���� ������ �����Ͱ� ���� ��� ���
--BITMAP�� ��� ���� ������ ���� ������ �����Ͱ� ���� ��� ���(ex.����)

--����
--CREATE BITMAP INDEX �ε�����
--ON ���̺��(�÷���1 [ASC(�⺻)|DESC],�÷���2 [ASC(�⺻)|DESC]);

CREATE BITMAP INDEX idx_emp_deptno
ON emp(deptno)
;
-- Standard Edition ����(�������)������ ��� ����
-- ORA-00439: feature not enabled: Bit-mapped indexes

--1. Unique Index
--key���� �ߺ��Ǵ� �����Ͱ� ����.
--�ߺ��� ?�� �Էµ� ���ɼ��� �ִ� �÷����� ����� �� ����.
--������ ����

--����
--CREATE UNIQUE INDEX �ε�����(IX/IDX_���̺��̸�_�÷�)
--ON ���̺� (�÷���1 [ASC(�⺻)|DESC], �÷���2 [ASC(�⺻)|DESC]);

--UNIQUE INDEX�� ename�� �ɾ��� ������ ���� ename�� �Էµ� �� ����.
CREATE UNIQUE INDEX IDX_emp_ename
ON emp (ename ASC)
;
--Index created.

--������ �Է�
INSERT INTO emp
VALUES(7936,'WOOGIE','CLERCK',7902,'1980-12-17',880,100,20)
;
--ORA-00001: unique constraint (SCOTT.IDX_EMP_ENAME) violated

--2. NONE Unique Index
--�ߺ��� �����Ͱ� �ִ� �÷��� ��� ���

--����
--CREATE INDEX �ε�����(IX/IDX_���̺��̸�_�÷�)
--ON ���̺� (�÷���1 [ASC(�⺻)|DESC], �÷���2 [ASC(�⺻)|DESC]);

--NONE Unique Index�̱� ������ jobĮ���� �ߺ����� �Է� �� �� �ִ�.
CREATE INDEX IDX_emp_job
ON emp (job DESC)
;
--Index created.

--������ �Է�
INSERT INTO emp
VALUES(7937,'WOOGIE2','CLERCK',7902,'1980-12-17',880,100,20)
;
--     EMPNO ENAME     JOB           MGR HIREDATE        SAL       COMM     DEPTNO
------------ --------- ---------- ------ -------- ---------- ---------- ----------
--      7369 SMITH     CLERK        7902 80/12/17        880                    20
--      7499 ALLEN     SALESMAN     7698 81/02/20       1600        300         30
--      7521 WARD      SALESMAN     7698 81/02/22       1250        500         30
--      7566 JONES     MANAGER      7839 81/04/02     3272.5                    20
--      7654 MARTIN    SALESMAN     7698 81/09/28       1250       1400         30
--      7698 BLAKE     MANAGER      7839 81/05/01       2850                    30
--      7782 CLARK     MANAGER      7839 81/06/09       2450                    10
--      7839 KING      PRESIDENT         81/11/17       5000                    10
--      7844 TURNER    SALESMAN     7698 81/09/08       1500          0         30
--      7900 JAMES     CLERK        7698 81/12/03        950                    30
--      7902 FORD      ANALYST      7566 81/12/03       3300                    20
--      7934 MILLER    CLERK        7782 82/01/23       1300                    10
--      7935 WOOGIE    CLERCK       7902 80/12/17        880        100         20
--      7937 WOOGIE2   CLERCK       7902 80/12/17        880        100         20

--3. Function Based Index(�Լ���� �ε���)
--�ε����� WHERE ���� ���� �����÷��̳� �����÷� � ������ ��(ex.WHERE empno = ?)
--������ WHERE ���� ������ �ٸ����·� �����ÿ��� �ε����� Ȱ���� �� ����
--(ex.WHERE empno * 100 = ? / WHERE empno != ?)

--Index Suppressing Error
--�ε����� ������ ���� ���� sql�ۼ������� �ε����� ����� �� ���� ���

--�̸� �ذ��ϱ� ���� �Լ�ó�� ������ �ؼ� �ε��� ����
--�ӽ����� �ذ�å���� ����

CREATE INDEX IDX_emp_deptno
ON emp(deptno/10)
;
--Index created.

--������ ��ȸ
SELECT *
FROM emp
WHERE deptno/10 = 1
;
--     EMPNO ENAME    JOB          MGR HIREDATE        SAL       COMM     DEPTNO
------------ -------- ---------- ----- -------- ---------- ---------- ----------
--      7782 CLARK    MANAGER     7839 81/06/09       2450                    10
--      7839 KING     PRESIDENT        81/11/17       5000                    10
--      7934 MILLER   CLERK       7782 82/01/23       1300                    10

--4. Descending Index(�������� �ε���)
--������������ ������ �ߴµ� ������������ �����͸� ���� ���� ��� ���ο� �ε����� �����ϸ� ��������
--�ε����� ������ DML ���ɿ� �ǿ����� ��ħ
--����Ŭ������ �̸� �ذ��ϱ� ���� '��Ʈ'��� ����� ����, �̸� ���� ������ �� ȿ���� ����
--�ּڰ�, �ִ��� ���ϱ⵵ ��(�ڿ��� ���)

--5. Composite Index(���� �ε���)
--�� �� �̻��� �÷��� ���ļ� �ε����� �����ϴ� ��
--�ַ� WHERE���� �÷��� 2���̻��� ���(AND�� ����� ��, OR�� �ȵ�)
--���� ���� ����ϴ� �ε�����, �ε��� �÷������� ���ɿ� ���� ������ ��ħ

CREATE INDEX idx_emp_comp
ON emp(ename, job)
;
--Index created.

--�ε��������ϱ�: DICTIONARY

--user: USER_INDEXES, USER_IND_COLUMNS
--DBA: DBA_INDEXES, DBA_IND_COLUMNS

--�ε��� Ȯ��
--WHERE������ ���̺���� �빮�ڷ� (EX.'EMP2')
SELECT t1.table_name,
    t1.column_name,
    t1.index_name
FROM user_ind_columns t1
WHERE t1.table_name = 'EMP2'
;
--table_name  column_name  index_name
-------------------------------------------
--EMP2	         EMPNO	   SYS_C007016
--EMP2	         NAME	   TMP2_NAME_UK

SELECT t1.table_name,
    t1.index_name
FROM user_indexes t1
WHERE t1.table_name = 'EMP2'
;
--TABLE_NAME    INDEX_NAME      
--------------- ----------------
--EMP2          SYS_C007016     
--EMP2          TMP2_NAME_UK    

--�ε��� ��뿩�� ����͸� �ϱ�
--������� �ʴ� �ε����� �����ϱ� ����
--����͸� �����ϱ�
--ALTER INDEX �ε����̸� MONITORING USAGE;
--����͸� �ߴ�
--ALTER INDEX �ε����̸� NOMONITORING USAGE;

--����͸� �����ϱ�
ALTER INDEX TMP2_NAME_UK MONITORING USAGE
;
--Index altered.

--����͸� ��뿩�� Ȯ��
SELECT index_name,
	used
FROM v$object_usage
WHERE index_name = 'TMP2_NAME_UK'
;
--INDEX_NAME       USED
------------------ ------
--TMP2_NAME_UK     NO

--����͸� �ߴ�
ALTER INDEX TMP2_NAME_UK NOMONITORING USAGE
;
--Index altered.

--INDEX_REBUILD
--1. I_TEST ���̺� ����
--2. ������ 10000�� �Է�
--3. �ε���
--4. �ε��� ���� ��ȸ
--5. ���̺��� ������ ����
--6. �ε��� ���� ��ȸ
--7. �ε��� REBUILD
--8. �ε��� ���� ��ȸ

--1. I_TEST ���̺� ����
CREATE TABLE i_test(
	no NUMBER,
	name VARCHAR2(20)
);

--2. ������ 10000�� �Է�
BEGIN
	FOR i IN 1..10000 LOOP
		INSERT INTO i_test VALUES(i, 'eStudent'||i);
	END LOOP;
	COMMIT;
END;
/
--      NO NAME
---------- -----------------
--       1 eStudent1
--       2 eStudent2
--       3 eStudent3
--		...
--    9997 eStudent9997
--    9998 eStudent9998
--    9999 eStudent9999
--   10000 eStudent10000

--3. �ε���
CREATE INDEX idx_test_no
ON i_test(no DESC)
;
--Index created.

--4. �ε��� ���� ��ȸ
--STATIC DICTIONARY ��ȸ�ϹǷ� ��������� �����ؾ���
ANALYZE INDEX IDX_TEST_NO VALIDATE STRUCTURE
;
--Index analyzed.

--DESC index_stats;
--LF_ROWS_LEN
--DEL_LF_ROWS_LEN

--balance�� 0�� ����� ���� ���
SELECT lf_rows_len,
	del_lf_rows_len,
	(del_lf_rows_len/lf_rows_len)*100 balance
FROM index_stats
WHERE name = 'IDX_TEST_NO'
;
--LF_ROWS_LEN DEL_LF_ROWS_LEN    BALANCE
------------- --------------- ----------
--     159801               0          0

--5. ���̺��� ������ ����
DELETE 
FROM i_test
WHERE no BETWEEN 1 AND 4000
;
COMMIT;
--4000 rows deleted.
--Commit complete.

--6. �ε��� ���� ��ȸ
ANALYZE INDEX IDX_TEST_NO VALIDATE STRUCTURE
;
--Index analyzed.
SELECT lf_rows_len,
	del_lf_rows_len,
	(del_lf_rows_len/lf_rows_len)*100 balance
FROM index_stats
WHERE name = 'IDX_TEST_NO'
;
--LF_ROWS_LEN DEL_LF_ROWS_LEN    BALANCE
------------- --------------- ----------
--     159801           63861 39.9628288

--7. �ε��� REBUILD
ALTER INDEX IDX_TEST_NO REBUILD
;
--Index altered.

--8. �ε��� ���� ��ȸ
ANALYZE INDEX IDX_TEST_NO VALIDATE STRUCTURE
;
--Index analyzed.
SELECT lf_rows_len,
	del_lf_rows_len,
	(del_lf_rows_len/lf_rows_len)*100 balance
FROM index_stats
WHERE name = 'IDX_TEST_NO'
;
--LF_ROWS_LEN DEL_LF_ROWS_LEN    BALANCE
------------- --------------- ----------
--      95940               0          0

--INVISIBLE INDEX
--�ε����� �����ϱ� ���� ������ ���·� ����
--ALTER INDEX �ε����̸� INVISIBLE

--�ε������
--1. new_emp4���̺� ����(no, name, sal)
CREATE TABLE new_emp4(
	no NUMBER, 
	name VARCHAR2(20), 
	sal NUMBER
);

--2. �������Է�
--no		name		sal	
--1000		SMITH		300	
--1001		ALLEN		250	
--1002		KING		430	
--1003		BLAKE		220	
--1004		JAMES		620	
--1005		MILLER		810	
INSERT INTO new_emp4 VALUES(1000,		'SMITH',	300);
INSERT INTO new_emp4 VALUES(1001,		'ALLEN',	250);
INSERT INTO new_emp4 VALUES(1002,		'KING',	430    );
INSERT INTO new_emp4 VALUES(1003,		'BLAKE',	220);
INSERT INTO new_emp4 VALUES(1004,		'JAMES',	620);
INSERT INTO new_emp4 VALUES(1005,		'MILLER',	810);

--3. name�÷��� �ε��� ����
CREATE INDEX IDX_EMP4_NAME
ON new_emp4(name ASC)
;

--4. �ε��� ��� vs �̻��
--�̻��
SELECT *
FROM new_emp4
;
--        NO NAME             SAL
------------ --------- ----------
--      1000 SMITH            300
--      1001 ALLEN            250
--      1002 KING             430
--      1003 BLAKE            220
--      1004 JAMES            620
--      1005 MILLER           810

--���
--NAME �÷��� �ִ� �ε����� ���(name > '0')
--0���� �� ũ�Ƿ�
SELECT *
FROM new_emp4
WHERE name > '0' 
;
--     NO NAME                SAL
--------- ------------ ----------
--   1001 ALLEN               250
--   1003 BLAKE               220
--   1004 JAMES               620
--   1002 KING                430
--   1005 MILLER              810
--   1000 SMITH               300

--4.1 �����ȹ
--�̻��
explain plan for
SELECT *
FROM new_emp4
;
col plan_table_output format a80;
select * from table(dbms_xplan.display)
;
--PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------
--Plan hash value: 574968521
--
--------------------------------------------------------------------------------
--| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT  |          |     6 |   228 |     3   (0)| 00:00:01 |
--|   1 |  TABLE ACCESS FULL| NEW_EMP4 |     6 |   228 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------------

--���
explain plan for
SELECT *
FROM new_emp4
WHERE name > '0' 
;
col plan_table_output format a80;
select * from table(dbms_xplan.display)
;
--PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------
--Plan hash value: 1208544499
-- 
-----------------------------------------------------------------------------------------------
--| Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT            |               |     6 |   228 |     2   (0)| 00:00:01 |
--|   1 |  TABLE ACCESS BY INDEX ROWID| NEW_EMP4      |     6 |   228 |     2   (0)| 00:00:01 |
--|*  2 |   INDEX RANGE SCAN          | IDX_EMP4_NAME |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------

--5. �ּ�/�ִ밪�� min/max�� �ε��� ������� ��ó
--min
SELECT name
FROM new_emp4
WHERE name > '0'
AND ROWNUM = 1
;
--NAME
------------
--ALLEN

--max
--INDEX ��Ʈ�� �̿�
SELECT /*+ INDEX_DESC(new_emp4 idx_emp4_name) */
	name
FROM new_emp4
WHERE name > '0'
AND ROWNUM = 1
;
--NAME
---------------
--ALLEN

--ROWID
--����Ŭ���� �������� �ּҸ� �ּҶ� ���� �ʰ� ROWID�� �Ѵ�.
SELECT ROWID,
	empno,
	ename
FROM emp
;
--ROWID                   EMPNO ENAME
-------------------- ---------- --------------
--AAAE6LAAEAAAAK+AAA       7369 SMITH
--AAAE6LAAEAAAAK+AAB       7499 ALLEN
--AAAE6LAAEAAAAK+AAC       7521 WARD
--AAAE6LAAEAAAAK+AAD       7566 JONES
--AAAE6LAAEAAAAK+AAE       7654 MARTIN
--AAAE6LAAEAAAAK+AAF       7698 BLAKE
--AAAE6LAAEAAAAK+AAG       7782 CLARK
--AAAE6LAAEAAAAK+AAH       7839 KING
--AAAE6LAAEAAAAK+AAI       7844 TURNER
--AAAE6LAAEAAAAK+AAJ       7900 JAMES
--AAAE6LAAEAAAAK+AAK       7902 FORD
--AAAE6LAAEAAAAK+AAL       7934 MILLER
--AAAE6LAAEAAAAK+AAM       7935 WOOGIE
--AAAE6LAAEAAAAK+AAN       7937 WOOGIE2

--AAAE+6 :������ ������Ʈ ��ȣ
--LAA :���Ϲ�ȣ
--EAAAAK : ��Ϲ�ȣ
--AAN :�ο��ȣ

SELECT ROWID,
	empno,
	ename
FROM emp
WHERE ROWID = 'AAAE6LAAEAAAAK+AAN'
;
--ROWID                   EMPNO ENAME
-------------------- ---------- ----------------
--AAAE6LAAEAAAAK+AAN       7937 WOOGIE2







