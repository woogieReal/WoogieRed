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

--TABLE TYPE 변수(컬렉션)
--연관배열, 중첩테이블, VARRAY

--연관배열을 가장 많이 사용
--key/value 구조
--key <- 숫자: binary_integer, pls_integer, 
--		 문자: varchar2

--정의
--TYPE type_name IS TABLE OF
--{column_type | variable%type | table.column_type%type [not null] }
--[index by binary_integer]

--선언
--indentifier type_name;

--단건처리
DECLARE
	--정의
	TYPE tbl_emp_name IS TABLE OF
		employees.first_name%TYPE
		INDEX BY BINARY_INTEGER;
	--선언부
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

--다건처리
DECLARE
	--정의
	TYPE tbl_emp_name IS TABLE OF
		employees.first_name%TYPE
		INDEX BY BINARY_INTEGER;
	--선언부
	v_name tbl_emp_name;
	
	--INDEX
	a BINARY_INTEGER := 0;
BEGIN
	--할당
	FOR i IN (SELECT first_name FROM employees) LOOP
		a:=a+1;
		v_name(a):=i.first_name;
	END LOOP;
	
	--출력
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
  
--제어문
--1. 조건문: IF, CASE
--2. 반복문: FOR, WHILE, BASIC LOOP

--PL/SQL_IF
--IF 조건 THEN
--	실행문장
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
--IF 조건 THEN
--	실행문장
--ELSIF 조건 THEN
--	실행문장
--ELSIF 조건 THEN
--	실행문장
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
--IF 조건 THEN
--	실행문장
--ELSE
--	실행문장
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
		DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||' 사원의 보너스는 '|| v_total  ||' 입니다.')
		;
	ELSIF(v_comm > 0.3) THEN
		DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||' 사원의 보너스는 '|| v_total  ||' 이며, 30%를 넘습니다.')
		;
	ELSE
		DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||' 사원의 보너스는 없습니다.')
		;
	END IF
	;

END;
/
--Enter value for empid: 145
--old  12: WHERE employee_id = &empid
--new  12: WHERE employee_id = 145
--145, John 사원의 보너스는 5600 이며, 30%를 넘습니다.

--PL/SQL_CASE
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
	
	v_dname := CASE v_deptid
		WHEN 10 THEN 'Administration'
		WHEN 20 THEN 'Marketing'
		WHEN 30 THEN 'Purchasing'
		WHEN 40 THEN 'Human Resources'
	END;
	
	DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_fname ||', '|| v_deptid ||', '|| v_dname);
	
END;
/
--203, Susan, 40, Human Resources

--PL/SQL_BASIC_LOOP

DECLARE
	no01 NUMBER := 0;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE(no01);
		no01 := no01 + 1;
		EXIT WHEN no01 > 5;
	END LOOP;
END;
/
--0
--1
--2
--3
--4
--5

--PL/SQL_WHILE

DECLARE
	no01 NUMBER := 0;
BEGIN
	WHILE(no01 < 21) 
	LOOP
		DBMS_OUTPUT.PUT_LINE('no01: ' || no01);
		no01 := no01 + 4;
	END LOOP;
END;
/
--no01: 0
--no01: 4
--no01: 8
--no01: 12
--no01: 16
--no01: 20

--PL/SQL_FOR
DECLARE

BEGIN
	FOR i IN 0..20 LOOP
	--FOR i IN REVERSE 0..20 LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
/
--1
--2
--...
--20

--PL/SQL_CURSOR
--SQL CURSOR? ?????? ?????? ?? ? ??

--?????? ????? ????? ????? SQL????, ???? ?????
--? ? ??
--????
--SQL%ROWCOUNT
--SQL%FOUND
--SQL%NOTFOUND
--SQL%ISOPEN

--?????
--???? ???? ?? ? ??
--????
--????%ROWCOUNT
--????%FOUND
--????%NOTFOUND
--????%ISOPEN

DECLARE
	v_empid employees.employee_id%TYPE;
	v_fname employees.first_name%TYPE;
	
	CURSOR C1 IS
	SELECT employee_id, first_name
	FROM employees
	WHERE department_id = 30;
BEGIN
	OPEN C1;        
	LOOP
		FETCH C1 INTO v_empid, v_fname;
		EXIT WHEN C1%NOTFOUND; 
		DBMS_OUTPUT.PUT_LINE(v_empid||', '||v_fname);
	END LOOP;
	CLOSE C1;
	
END;
--114, Den
--115, Alexander
--116, Shelli
--117, Sigal
--118, Guy
--119, Karen

--PL/SQL_CURSOR_FOR
--??? OPEN/FETCH/CLOSE? ???? ???? ??
--?? ???

DECLARE
	CURSOR emp_cur IS
	SELECT employee_id, first_name
	FROM employees
	WHERE department_id = 100;
BEGIN
	FOR emp_rec IN emp_cur LOOP
		DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id ||', '|| emp_rec.first_name);
	END LOOP;
END;
/
--108, Nancy
--109, Daniel
--110, John
--111, Ismael
--112, Jose Manuel
--113, Luis

--???? ? ? ??.
--?? ??? ???? ?? ???? ???? ????
DECLARE
	
BEGIN
	FOR emp_rec IN (
		SELECT employee_id, first_name
		FROM employees
		WHERE department_id = 100) 
	LOOP
		DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id ||', '|| emp_rec.first_name);
	END LOOP;
END;
/

--PL/SQL_EXCEPTION
--PL/SQL??? ???? ?? ???? ?????

DECLARE
	v_fname employees.first_name%TYPE;
BEGIN
	SELECT first_name
	INTO v_fname
	FROM employees
	WHERE first_name like 'Z%';
	
	DBMS_OUTPUT.PUT_LINE(v_fname);
	
	EXCEPTION
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE('???? 2? ?????.');
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('????? ????.');
END;
/

--??? ?? EXCEPTION
--?? ????? ??? ?? ??? ???? ????
--PRAGMA EXCEPTION_INIT??? ???? ????
CREATE TABLE t_pragma(
	no NUMBER PRIMARY KEY,
	name VARCHAR2(20)
);

INSERT INTO t_pragma
VALUES(1, 'AAA');

INSERT INTO t_pragma
VALUES(1, 'BBB');
--ORA-00001: unique constraint (HR.SYS_C007154) violated

DECLARE
	new_msg EXCEPTION;
	PRAGMA EXCEPTION_INIT(new_msg, -1);
BEGIN
	INSERT INTO t_pragma
	VALUES(1, 'BBB');
	
	EXCEPTION
		WHEN new_msg THEN
		DBMS_OUTPUT.PUT_LINE('? ??. ?? ?????.');
END;
/

--PROCEDURE
--?? CREATE PROCEDURE ??
--?? DROP PROCEDURE ??
--?? ALTER PROCEDURE ??

--CREATE OR REPLACE PROCEDURE procedure_name
--[(
--	parameter datatype1,
--	parameter datatype2,
--	parameter datatype3,
--	...
--)]
--IS|AS
--PL/SQL BLOCK

--PARAMETER
--IN: ?????? ??
--OUT: RETURN
--IN OUT: ?/?? ?? ??

--????? ???? ?? ??? ??? 10000 UPDATE??

SELECT employee_id, salary
FROM employees
WHERE employee_id = 206;
--
--EMPLOYEE_ID     SALARY
------------- ----------
--        206       8300

--???? ??
CREATE OR REPLACE PROCEDURE up_sal
( 
	vempid employees.employee_id%TYPE
)  
IS
BEGIN
	UPDATE employees
	SET salary = 10000
	WHERE employee_id = vempid;
END;
/
--Procedure created.

--???? ??
EXEC up_sal(206);
--
--EMPLOYEE_ID     SALARY
------------- ----------
--        206      10000


--FUNCTION
--??? ??? ???? ??? ????.
--?????? ???? ?? ???? ?? ?
--
--?? CREATE FUNCTION ??
--?? DROP FUNCTION ??
--?? ALTER FUNCTION ??

--CREATE OR REPLACE FUNCTION function_name
--[(
--	parameter datatype1,
--	parameter datatype2,
--	parameter datatype3,
--	...
--)]
--RETURN DATA;
--IS|AS
--PL/SQL BLOCK

SELECT MAX(salary)
FROM employees
WHERE department_id = 10;
--
--MAX(SALARY)
-------------
--       4400

--????
CREATE OR REPLACE FUNCTION max_sal
(
	s_deptno employees.department_id%TYPE
)
RETURN NUMBER
IS
	max_sal employees.salary%TYPE;
BEGIN
	SELECT MAX(salary)
	INTO max_sal
	FROM employees
	WHERE department_id = s_deptno;
	
	RETURN max_sal;
END;
/
--Function created.

SELECT max_sal(10) FROM dual;
--
--MAX_SAL(10)
-------------
--       4400


--????
--SELECT name, text
--FROM USER_SOURCE
--WHERE type='FUNCTION'
--AND name='MAX_SAL';







