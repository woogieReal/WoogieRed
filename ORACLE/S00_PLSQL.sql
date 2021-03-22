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

--PL/SQL에서 SELECT로 데이터 조회하기
--문법: 반드시 한 건의 데이터만 출력 되어야 함
--SELECT selectlist
--INTO {VARIABLE NAME,,,,,}
--FROM table이름
--[WHERE 조건]

--employees테이블에서 employee_id=200인 사원의 이름과 사번을 출력
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

--변수 입력받기
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
--를 위한 테이블 생성
CREATE TABLE pl_test(
	no NUMBER,
	name VARCHAR2(10 BYTE)
);

--시퀀스 생성
CREATE SEQUENCE pl_seq;

--DML
DECLARE

BEGIN
	INSERT INTO pl_test
	VALUES(pl_seq.NEXTVAL, 'AAA');
END;
/

-- 위의 쿼리를 수행 후에 
-- / 를 또 한번 치면 앞에 수행한 명령 재수행

--      NO NAME
---------- --------------------
--       1 AAA
--       2 AAA

--DML 사용자에게 데이터를 입력 받아 처리

--pl_test2테이블 생성
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
--       2 AAA -> BBB 로 수정

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
--       1 AAA -> 삭제
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

--PL/SQL 식별자: PL/SQL 객체에서 부여되는 이름
--"" 사용

--권장하지 않음
--1. 식별자의 대소분 구분이 필요한 경우
--ex) "eClass"
--2. 공백문자가 포함될 경우
--ex) "a col"
--3. 예약어인 경우
--ex) "table"

--리터럴: 변수에 할당되는 값
--1. 문자 리터럴: CHAR, VARCHAR2 ex) abcd
--2. 숫자 리터럴: 정수, 또는 실수 ex) 1234, 1.234
--3. 부울 리터럴: TRUE, FALSE, NULL

--주석
--한줄: --
--여러줄 주석: /* */

--중첩된 PL/SQL 출력
--중첩된 쿼리에서 선언된 변수는 외부 쿼리에서는 사용할 수 없다.
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

--오류
--PLS-00201: identifier 'V_SECOND' must be declared
DBMS_OUTPUT.PUT_LINE(v_second);

END;
/

--PL/SQL 변수
--참조변수를 통한 데이터 조회
--CTAS를 통해 employees3 생성

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

--ROWTYPE 참조변수로 데이터 출력
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

--복합변수: 레코드 TYPE과 테이블 TYPE
--동일한 데이터 타입의 여러 건의 데이터를 저장하는 경우 테이블 TYPE(COLLECTION TYPE), 이것 외에는 레코드 TYPE
--1. 레코드 TYPE
--TYPE TYPE_NAME IS RECORD
--(fild declaration, filed declaration,,,)

--선언부 type선언
--TYPE emp_record_type IS RECORD
--(
--	emp_id employees.employee_id%TYPE,
--	emp_name employees.first_name%TYPE,
--	emp_sal employees.salary%TYPE
--);

--변수선언
--v_record emp_record_type;

DECLARE
	--레코드 타입 변수선언
	TYPE emp_record_type IS RECORD
	(
		emp_id employees.employee_id%TYPE,
		emp_name employees.first_name%TYPE,
		emp_sal employees.salary%TYPE
	);
	--emp_record_type를 v_record01로 변수선언
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











