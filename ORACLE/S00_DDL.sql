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







