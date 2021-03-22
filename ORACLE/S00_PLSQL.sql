--SET SERVEROUTPUT ON;

DECLARE
	vno NUMBER(6);
	vname VARCHAR2(20);
	
BEGIN
	SELECT employee_id, first_name
		INTO vno, vname
	FROM employees
	WHERE employee_id = 200;
	
	DBMS_OUTPUT.PUT_LINE(vno ||','|| vname );
	
END;
/
--200,Jennifer

--PL/SQL���� SELECT�� ������ ��ȸ�ϱ�
--����: �ݵ�� �� ���� �����͸� ��� �Ǿ�� ��
--SELECT selectlist
--INTO {VARIABLE NAME,,,,,}
--FROM table�̸�
--[WHERE ����]

--employees���̺��� employee_id=200�� ����� �̸��� ����� ���
--employees.employee_id%TYPE, 
--employees.salary%TYPE,

DECLARE
	v_empid employees.employee_id%TYPE;
	v_salary employees.salary%TYPE;
BEGIN
	SELECT employee_id, salary
		INTO v_empid, v_salary
	FROM employees
	WHERE employee_id=197;
	DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_salary );
END;
/
--197, 3000

--���� �Է¹ޱ�
DECLARE
	v_empid employees.employee_id%TYPE;
	v_salary employees.salary%TYPE;
BEGIN
	SELECT employee_id, salary
		INTO v_empid, v_salary
	FROM employees
	WHERE employee_id=&id;
	DBMS_OUTPUT.PUT_LINE(v_empid ||','|| v_salary );
END;
/

--PL/SQL DML
--�� ���� ���̺� ����
CREATE TABLE pl_test(
	no NUMBER,
	name VARCHAR2(10 BYTE)
);

--������ ����
CREATE SEQUENCE pl_seq;

--DML
DECLARE

BEGIN
	INSERT INTO pl_test
	VALUES(pl_seq.NEXTVAL, 'AAA');
END;
/

-- ���� ������ ���� �Ŀ� 
-- / �� �� �ѹ� ġ�� �տ� ������ ��� �����

--      NO NAME
---------- --------------------
--       1 AAA
--       2 AAA

--DML ����ڿ��� �����͸� �Է� �޾� ó��

--pl_test2���̺� ����
CREATE TABLE pl_test2(
	no NUMBER,
	name VARCHAR2(10),
	addr VARCHAR2(10)
);

--INSERT
DECLARE
	v_no NUMBER := '&no';
	v_name VARCHAR2(10) := '&name';
	v_addr VARCHAR2(10) := '&addr';
BEGIN
	INSERT INTO pl_test2 VALUES(v_no, v_name, v_addr);
END;
/
--      NO NAME                 ADDR
---------- -------------------- --------------------
--       1 woogie               Incheon

--UPDATE
--      NO NAME
---------- --------------------
--       1 AAA
--       2 AAA
--       2 AAA -> BBB �� ����

DECLARE
	
BEGIN
	UPDATE pl_test
	SET name = 'BBB'
	WHERE no = 2;
END;
/
--      NO NAME
---------- --------------------
--       1 AAA
--       2 BBB

--DELETE
--      NO NAME
---------- --------------------
--       1 AAA -> ����
--       2 BBB

DECLARE

BEGIN
	DELETE
	FROM pl_test
	WHERE no = 1;
END;
/
--      NO NAME
---------- --------------------
--       2 BBB


--MERGE
CREATE TABLE pl_merge1(
	no NUMBER,
	name VARCHAR2(10)
);

CREATE
TABLE pl_merge2
AS
SELECT * FROM pl_merge1
;

INSERT INTO pl_merge1 VALUES(1,'AAA');
INSERT INTO pl_merge1 VALUES(2,'BBB');
INSERT INTO pl_merge2 VALUES(1,'CCC');
INSERT INTO pl_merge2 VALUES(3,'DDD');

----------------------pl_merge1
--      NO NAME
---------- --------------------
--       1 AAA
--       2 BBB

----------------------pl_merge2
--      NO NAME
---------- --------------------
--       1 CCC
--       3 DDD

DECLARE
	
BEGIN
	MERGE INTO pl_merge2 m2
	USING pl_merge1 m1
	ON (m1.no = m2.no)
	WHEN MATCHED THEN
		UPDATE SET m2.name = m1.name
	WHEN NOT MATCHED THEN
		INSERT VALUES(m1.no, m1.name)
	;
END;
/
--      NO NAME
---------- --------------------
--       1 AAA
--       2 BBB
--       3 DDD

--PL/SQL �ĺ���: PL/SQL ��ü���� �ο��Ǵ� �̸�
--"" ���

--�������� ����
--1. �ĺ����� ��Һ� ������ �ʿ��� ���
--ex) "eClass"
--2. ���鹮�ڰ� ���Ե� ���
--ex) "a col"
--3. ������� ���
--ex) "table"

--���ͷ�: ������ �Ҵ�Ǵ� ��
--1. ���� ���ͷ�: CHAR, VARCHAR2 ex) abcd
--2. ���� ���ͷ�: ����, �Ǵ� �Ǽ� ex) 1234, 1.234
--3. �ο� ���ͷ�: TRUE, FALSE, NULL

--�ּ�
--����: --
--������ �ּ�: /* */

--��ø�� PL/SQL ���
--��ø�� �������� ����� ������ �ܺ� ���������� ����� �� ����.
DECLARE
	v_first VARCHAR2(10) := 'FIRST';
BEGIN
	DECLARE
		v_second VARCHAR2(10) := 'SECOND';
	BEGIN
		DBMS_OUTPUT.PUT_LINE(v_first);
		DBMS_OUTPUT.PUT_LINE(v_second);
	END;
DBMS_OUTPUT.PUT_LINE(v_first);

--����
--PLS-00201: identifier 'V_SECOND' must be declared
DBMS_OUTPUT.PUT_LINE(v_second);

END;
/

--PL/SQL ����
--���������� ���� ������ ��ȸ
--CTAS�� ���� employees3 ����

CREATE
TABLE employees3
AS
SELECT employee_id,
	first_name,
	salary
FROM employees
;

--
DECLARE
	v_no employees3.employee_id%TYPE;
	v_name employees3.first_name%TYPE;
	v_sal employees3.salary%TYPE;
BEGIN
	SELECT employee_id, first_name, salary
		INTO v_no, v_name, v_sal
	FROM employees3
	WHERE employee_id = 180;
	
	DBMS_OUTPUT.PUT_LINE(v_no || '-----' || v_name || '--------' || v_sal);
END;
/
--180-----Winston--------3200

--ROWTYPE ���������� ������ ���
DECLARE
	v_row employees3%ROWTYPE;
BEGIN
	SELECT employee_id, first_name, salary
		INTO v_row
	FROM employees3
	WHERE employee_id = 180;
	
	DBMS_OUTPUT.PUT_LINE(
		v_row.employee_id || ', ' || 
		v_row.first_name || ',' || 
		v_row.salary
	);
END;
/
--180, Winston,3200

DECLARE
	v_empid employees.employee_id%TYPE;
	v_name employees.first_name%TYPE;
	v_deptno employees.department_id%TYPE;
	v_deptnm departments.department_name%TYPE;
BEGIN
	SELECT t1.employee_id, 
		t1.first_name, 
		t1.department_id,
		t2.department_name
	INTO v_empid, v_name, v_deptno, v_deptnm
	FROM employees t1, departments t2
	WHERE t1.department_id = t2.department_id
	AND t1.employee_id = 180;
	
	DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_name ||', '|| v_deptno ||', '|| v_deptnm);
	
END;
/
--180, Winston, 50, Shipping

-------------------------------------------------------------------------------------------


DECLARE
	v_no1 NUMBER := &NO1;
	v_no2 NUMBER := &NO2;
	v_sum NUMBER;
BEGIN
	v_sum := v_no1 + v_no2;
	
	DBMS_OUTPUT.PUT_LINE(v_sum ||' = '||v_no1 ||' + '||v_no2 );
END;
/
--Enter value for no1: 2
--old   2: v_no1 NUMBER := &NO1;
--new   2: v_no1 NUMBER := 2;
--Enter value for no2: 3
--old   3: v_no2 NUMBER := &NO2;
--new   3: v_no2 NUMBER := 3;
--5 = 2 + 3

--���պ���: ���ڵ� TYPE�� ���̺� TYPE
--������ ������ Ÿ���� ���� ���� �����͸� �����ϴ� ��� ���̺� TYPE(COLLECTION TYPE), �̰� �ܿ��� ���ڵ� TYPE
--1. ���ڵ� TYPE
--TYPE TYPE_NAME IS RECORD
--(fild declaration, filed declaration,,,)

--����� type����
--TYPE emp_record_type IS RECORD
--(
--	emp_id employees.employee_id%TYPE,
--	emp_name employees.first_name%TYPE,
--	emp_sal employees.salary%TYPE
--);

--��������
--v_record emp_record_type;

DECLARE
	--���ڵ� Ÿ�� ��������
	TYPE emp_record_type IS RECORD
	(
		emp_id employees.employee_id%TYPE,
		emp_name employees.first_name%TYPE,
		emp_sal employees.salary%TYPE
	);
	--emp_record_type�� v_record01�� ��������
	v_record01 emp_record_type;
	
BEGIN
	SELECT employee_id, first_name, salary
		INTO v_record01
	FROM employees
	WHERE employee_id = 180;
	
	DBMS_OUTPUT.PUT_LINE(v_record01.emp_id ||', '|| v_record01.emp_name ||', '|| v_record01.emp_sal);
END;
/
--180, Winston, 3200

--TABLE TYPE ����(�÷���)
--�����迭, ��ø���̺�, VARRAY

--�����迭�� ���� ���� ���
--key/value ����
--key <- ����: binary_integer, pls_integer, 
--		 ����: varchar2

--����
--TYPE type_name IS TABLE OF
--{column_type | variable%type | table.column_type%type [not null] }
--[index by binary_integer]

--����
--indentifier type_name;

--�ܰ�ó��
DECLARE
	--����
	TYPE tbl_emp_name IS TABLE OF
		employees.first_name%TYPE
		INDEX BY BINARY_INTEGER;
	--�����
	v_name tbl_emp_name;
	t_name VARCHAR2(20);
BEGIN
	SELECT first_name
		INTO t_name
	FROM employees
	WHERE employee_id = 180
	;
	
	v_name(0) := t_name;
	DBMS_OUTPUT.PUT_LINE(v_name(0));
END;
/
--Winston

--�ٰ�ó��
DECLARE
	--����
	TYPE tbl_emp_name IS TABLE OF
		employees.first_name%TYPE
		INDEX BY BINARY_INTEGER;
	--�����
	v_name tbl_emp_name;
	
	--INDEX
	a BINARY_INTEGER := 0;
BEGIN
	--�Ҵ�
	FOR i IN (SELECT first_name FROM employees) LOOP
		a:=a+1;
		v_name(a):=i.first_name;
	END LOOP;
	
	--���
	FOR j IN 1..a LOOP
		DBMS_OUTPUT.PUT_LINE(j||'. '||v_name(j));
	END LOOP;
	
END;
/
--1. Ellen
--2. Sundar
--3. Mozhe
--...
--105. Matthew
--106. Jennifer
--107. Eleni
  
--���
--1. ���ǹ�: IF, CASE
--2. �ݺ���: FOR, WHILE, BASIC LOOP

--PL/SQL_IF
--IF ���� THEN
--	���๮��
--END IF;


DECLARE
	v_empid employees.employee_id%TYPE;
	v_fname employees.first_name%TYPE;
	v_deptid employees.department_id%TYPE;
	v_dname VARCHAR2(30 BYTE);
BEGIN
	SELECT employee_id, first_name, department_id
		INTO v_empid, v_fname, v_deptid
	FROM employees
	WHERE employee_id = 203
	;
	
	IF(v_deptid = 10) THEN
		v_dname := 'Administration';
	END IF;
	
	IF(v_deptid = 20) THEN
		v_dname := 'Marketing';
	END IF;
	
	IF(v_deptid = 30) THEN
		v_dname := 'Purchasing';
	END IF;
	
	IF(v_deptid = 40) THEN
		v_dname := 'Human Resources';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||', '|| v_deptid ||', '|| v_dname);
	
END;
/
--203, Susan, 40, Human Resources

--PL/SQL_ELSIF
--IF ���� THEN
--	���๮��
--ELSIF ���� THEN
--	���๮��
--ELSIF ���� THEN
--	���๮��
--END IF;

DECLARE
	v_empid employees.employee_id%TYPE;
	v_fname employees.first_name%TYPE;
	v_deptid employees.department_id%TYPE;
	v_dname VARCHAR2(30 BYTE);
BEGIN
	SELECT employee_id, first_name, department_id
		INTO v_empid, v_fname, v_deptid
	FROM employees
	WHERE employee_id = 203
	;
	
	IF(v_deptid = 10) THEN
		v_dname := 'Administration';
		
	ELSIF(v_deptid = 20) THEN
		v_dname := 'Marketing';
		
	ELSIF(v_deptid = 30) THEN
		v_dname := 'Purchasing';
		
	ELSIF(v_deptid = 40) THEN
		v_dname := 'Human Resources';
		
	END IF;
	
	
	DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||', '|| v_deptid ||', '|| v_dname);
	
END;
/
--203, Susan, 40, Human Resources

--PL/SQL_ELSE
--IF ���� THEN
--	���๮��
--ELSE
--	���๮��
--END IF;

DECLARE
	v_empid employees.employee_id%TYPE;
	v_fname employees.first_name%TYPE;
	v_sal employees.salary%TYPE;
	v_comm employees.commission_pct%TYPE;
	v_total NUMBER;
BEGIN

	SELECT employee_id, first_name, salary, commission_pct, salary*commission_pct
		INTO v_empid, v_fname, v_sal, v_comm, v_total
	FROM employees
	WHERE employee_id = &empid
	;
	
	IF(v_comm > 0 AND v_comm <= 0.3) THEN
		DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||' ����� ���ʽ��� '|| v_total  ||' �Դϴ�.')
		;
	ELSIF(v_comm > 0.3) THEN
		DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||' ����� ���ʽ��� '|| v_total  ||' �̸�, 30%�� �ѽ��ϴ�.')
		;
	ELSE
		DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||' ����� ���ʽ��� �����ϴ�.')
		;
	END IF
	;

END;
/
--Enter value for empid: 145
--old  12: WHERE employee_id = &empid
--new  12: WHERE employee_id = 145
--145, John ����� ���ʽ��� 5600 �̸�, 30%�� �ѽ��ϴ�.









