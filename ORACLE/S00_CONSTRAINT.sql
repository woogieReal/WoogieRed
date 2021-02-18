--Constraint ��������
--���̺� �ùٸ� �����͸� �Է¹ް� �߸��� ������ ������ ���ϵ���
--�÷����� ���ϴ� ��Ģ
--�ϳ��� ���������� ���� �÷��� �ߺ����� ����
--�ϳ��� �÷��� �������ǵ��� �ߺ����� ����

--�÷��� Ÿ�� CONSTRAINT ���������̸� ��������
--�÷��� Ÿ�� CONSTRAINT ���������̸� REFERENCES �������̺�(�����÷�)
--�������� �̸��� ���� ���: �������� ������ ������� �ִ�.
--not null ������� ����� ��� �������Ǹ��� ���ִ� ��찡 ����.
--pk, fk�� ������ �̸��� �ش�
DROP TABLE new_emp1;

CREATE TABLE new_emp1(
	no NUMBER(4)
		CONSTRAINT emp1_no_pk PRIMARY KEY,
	name VARCHAR2(20 BYTE)
		CONSTRAINT emp1_name_nn NOT NULL,
	jumin VARCHAR2(13 BYTE)
		CONSTRAINT emp1_jumin_nn NOT NULL
		CONSTRAINT emp1_jumin_uk UNIQUE,
	loc_code NUMBER(1)
		CONSTRAINT emp1_loc_code_ck CHECK(loc_code<5),
	deptno VARCHAR2(6 BYTE)
		CONSTRAINT emp1_deptno_fk REFERENCES dept2(dcode)
);

--���̺� ���� �� �������� �߰�
--new_emp3 name�÷��� UNIQUE�߰�
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_name_uk UNIQUE(name)
;

--new_emp3 hiredate�÷��� not null�������� ����
ALTER TABLE new_emp3
MODIFY(hiredate CONSTRAINT emp3_hiredate_nn NOT NULL)
;

--new_emp3 no�÷��� emp2���̺��� empno�÷��� �����ϵ��� ���������� ����
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_no_fk FOREIGN KEY(no)
REFERENCES emp2(empno)
;

--FK �ۼ��� PARENT���̺��� �ش� �÷��� UNIQUE KEY���� �Ѵ�.
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_name_fk FOREIGN KEY(name)
REFERENCES emp2(name)
;
--�����߻�
--ORA-02270: no matching unique or primary key for this column-list

--ON DELETE CASCADE
--�ܷ�Ű ������ �����ÿ� �θ� ���̺��� �����Ͱ� �������� �ڽ����̺��� �����͵� �Բ� ����

--���̺� ����
CREATE TABLE C_TEST1(
	no NUMBER,
	name VARCHAR2(20),
	deptno NUMBER
);

CREATE TABLE C_TEST2(
	no NUMBER,
	name VARCHAR2(20)
);

--C_TEST2�� no�÷��� ����ũŰ ����
ALTER TABLE C_TEST2
ADD CONSTRAINT c_test2_no_uk UNIQUE(no)
;

--C_TEST1�� deptno�� C_TEST2�� no�÷��� �����ϴ� �ܷ�Ű�� ����
ALTER TABLE C_TEST1
ADD CONSTRAINT c_test1_deptno_fk FOREIGN KEY(deptno)
REFERENCES C_TEST2(no)
;

--ON DELETE CASCADE �ɼ��� FK ����
ALTER TABLE C_TEST1
ADD CONSTRAINT c_test1_deptno_fk FOREIGN KEY(deptno)
REFERENCES C_TEST2(no)
ON DELETE CASCADE
;

--�������� ����
ALTER TABLE C_TEST1
DROP CONSTRAINT c_test1_deptno_fk
;

--C_TEST2�� ������ �Է�
INSERT INTO C_TEST2 VALUES(10, 'AAA');
INSERT INTO C_TEST2 VALUES(20, 'BBB');
INSERT INTO C_TEST2 VALUES(30, 'CCC');
COMMIT;
--   NO NAME
------- ---------
--   10 AAA
--   20 BBB
--   30 CCC

--C_TEST1�� ������ �Է�
--C_TEST2 ������ ������� C_TEST1�� deptno�� �Է�
INSERT INTO C_TEST1 VALUES(1, 'apple', 10);
INSERT INTO C_TEST1 VALUES(2, 'banana', 20);
INSERT INTO C_TEST1 VALUES(3, 'cherry', 30);
COMMIT;
--    NO NAME          DEPTNO
-------- --------- ----------
--     1 apple             10
--     2 banana            20
--     3 cherry            30

--�����ϴ� Į���� ���� �����͸� �Է½� ���� �߻�
INSERT INTO C_TEST1 VALUES(4, 'peach', 40);
--ORA-02291: 
--integrity constraint (SCOTT.C_TEST1_DEPTNO_FK) violated - parent key not found

--�����ϴ� �θ��� �����͸� ������ �ܷ�Ű�� ON DELETE CASCADE �����Ǿ��ֱ� ������
--�ش� �����͸� �����ϴ� �ڽ� ���̺��� �����͵� �����ȴ�.
DELETE FROM C_TEST2
WHERE no = 10
;
--1 row deleted.

SELECT * FROM c_test1
;
--   NO NAME            DEPTNO
------- ----------- ----------
--    2 banana              20
--    3 cherry              30

--ON DELETE SET NULL
--�ܷ�Ű ������ �����ÿ� �θ� ���̺��� �����Ͱ� �������� �ڽ����̺��� �����͸� NULLó��
--�ܷ�Ű�� NOT NULL ���������� �־�� �ȵȴ�.

--�������� ����
ALTER TABLE C_TEST1
DROP CONSTRAINT c_test1_deptno_fk
;

--ON DELETE SET NULL �Ӽ��� �ܷ�Ű ����
ALTER TABLE C_TEST1
ADD CONSTRAINT c_test1_deptno_fk FOREIGN KEY(deptno)
REFERENCES C_TEST2(no)
ON DELETE SET NULL
;

--�����ϴ� �θ��� �����͸� ������ �ܷ�Ű�� ON DELETE SET NULL �����Ǿ��ֱ� ������
--�ش� �����͸� �����ϴ� �ڽ� ���̺��� �����ʹ� NULL ó���ȴ�.
DELETE FROM C_TEST2
WHERE no = 20
;
--1 row deleted.

SELECT * FROM c_test1
;
--  NO NAME         DEPTNO
------ -------- ----------
--   2 banana
--   3 cherry           30

--�������� ��ȸ�ϱ�
--��ųʸ� USER_CONSTRAINTS, USER_CONS_COLUMNS
--DBA DBA_CONSTRAINTS, DBA_CONS_COLUMNS

--TABLE �̸��� �ݵ�� �빮�ڷ� ��ȸ

--CONSTRAINT Ÿ��: 
--          P -> PK
--          U -> UNIQUE
--          C-> CHECK
--          R -> FK

desc user_cons_columns;
--�̸�               ��?       ����             
-----------------  -------- -------------- 
--OWNER            NOT NULL VARCHAR2(30)   
--CONSTRAINT_NAME  NOT NULL VARCHAR2(30)   
--TABLE_NAME       NOT NULL VARCHAR2(30)   
--COLUMN_NAME               VARCHAR2(4000) 
--POSITION                  NUMBER         


SELECT t1.owner,
	t1.constraint_name
FROM user_constraints t1
WHERE t1.table_name = 'EMP'
;
--OWNER     CONSTRAINT_NAME    
----------- -------------------
--SCOTT     PK_EMP             
--SCOTT     FK_DEPTNO          

SELECT t1.owner,
	t1.constraint_name,
	t1.constraint_type,
	t1.status
FROM user_constraints t1
WHERE t1.table_name = 'EMP'
;
--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          PK_EMP                         P ENABLED 
--SCOTT                          FK_DEPTNO                      R ENABLED 

SELECT owner,
	constraint_name,
	table_name,
	column_name
FROM user_cons_columns
WHERE table_name = 'EMP'
;

--�������ǰ���
--C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\utlexcpt.sql


--361p
--1
DROP TABLE tcons;
CREATE TABLE tcons(
    no NUMBER(5) CONSTRAINT tcons_no_pk PRIMARY KEY,
    name VARCHAR2(20) CONSTRAINT tcons_name_nn NOT NULL,
    jumin VARCHAR2(13)
        CONSTRAINT tcons_jumin_nn NOT NULL
        CONSTRAINT tcons_jumin_uk UNIQUE,
    area number(1) CONSTRAINT tcons_area_ck CHECK(area between 1 AND 4),
    deptno VARCHAR2(6) 
        CONSTRAINT tcons_deptno_fk REFERENCES dept2(decode)
);

--2
ALTER TABLE emp2
ADD CONSTRAINT tmp2_name_uk UNIQUE(name)
;

ALTER TABLE tcons
ADD CONSTRAINT tcons_name_fk FOREIGN KEY(name)
REFERENCES emp2(name)
;

--3
SELECT t1.owner,
	t1.constraint_name,
	t1.constraint_type,
	t1.status
FROM user_constraints t1
WHERE t1.table_name = 'TCONS'
;
--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          TCONS_NAME_NN                  C ENABLED 
--SCOTT                          TCONS_JUMIN_NN                 C ENABLED 
--SCOTT                          TCONS_AREA_CK                  C ENABLED 
--SCOTT                          TCONS_NO_PK                    P ENABLED 
--SCOTT                          TCONS_JUMIN_UK                 U ENABLED 
--SCOTT                          TCONS_DEPTNO_FK                R ENABLED 
--SCOTT                          TCONS_NAME_FK                  R ENABLED 

ALTER TABLE tcons
DISABLE VALIDATE CONSTRAINT tcons_jumin_uk
;

--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          TCONS_NAME_NN                  C ENABLED 
--SCOTT                          TCONS_JUMIN_NN                 C ENABLED 
--SCOTT                          TCONS_AREA_CK                  C ENABLED 
--SCOTT                          TCONS_NO_PK                    P ENABLED 
--SCOTT                          TCONS_JUMIN_UK                 U DISABLED
--SCOTT                          TCONS_DEPTNO_FK                R ENABLED 
--SCOTT                          TCONS_NAME_FK                  R ENABLED 

ALTER TABLE tcons
ENABLE VALIDATE CONSTRAINT tcons_jumin_uk
;

--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          TCONS_NAME_NN                  C ENABLED 
--SCOTT                          TCONS_JUMIN_NN                 C ENABLED 
--SCOTT                          TCONS_AREA_CK                  C ENABLED 
--SCOTT                          TCONS_NO_PK                    P ENABLED 
--SCOTT                          TCONS_JUMIN_UK                 U ENABLED 
--SCOTT                          TCONS_DEPTNO_FK                R ENABLED 
--SCOTT                          TCONS_NAME_FK                  R ENABLED

--4
ALTER TABLE tcons
ENABLE VALIDATE CONSTRAINT tcons_jumin_uk
EXCEPTIONS INTO exceptions
;

--5
SELECT t1.owner,
	t1.table_name,
	t2.column_name,
	t1.constraint_name
FROM user_constraints t1, user_cons_columns t2
WHERE t1.table_name = 'EMP'
AND t1.constraint_name = t2.constraint_name
AND t1.constraint_type IN ('P','U','C')
;


















