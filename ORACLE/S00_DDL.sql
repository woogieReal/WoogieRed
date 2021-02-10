--DDL명령어 딕셔너리
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
--NUMBER(3): 최대길이 3자리의 숫자 데이터
--VARCHAR2(10): 기본길이 10자의 문자열 데이터, 가변길이를 가짐
--DATE: 날짜 데이터 
--CREATE TABLE new_table(
--	no NUMBER(3),
--	name VARCHAR2(10),
--	birth DATE
--);

--테이블생성 제약사항
--테이블이름은 반드시 문자로 시작해야 함(숫자로 시작할 수 없음)
--테이블 컬럼의 이름은 30BYTE까지 가능
--테이블 이름은 한 명의 사용자가 다른 오브젝트의 이름과 중복으로 사용할 수 없다.
--테이블 이름이나 컬럼이름을 오라클 키워드로 지정해서는 안됨

--DEFAULT 설정하기
CREATE TABLE tt02(
	no NUMBER(3,1) DEFAULT 0,
	name VARCHAR2(10 BYTE) DEFAULT 'No NAME',
	hiredate DATE DEFAULT SYSDATE
);

--INSERT INTO tt02(no) VALUES(1);
--commit;
--SELECT * FROM tt02;

--한글테이블 생성
--생성은 가능하나 쓰는 경우는 없다.
CREATE TABLE 한글테이블(
	컬럼1 NUMBER,
	컬럼2 VARCHAR2,
	컬럼3 DATE
);

--테이블 복사하기(CTAS)
--모든컬럼 복사,데이터 복사

CREATE
TABLE dept3
AS
SELECT * FROM dept;

--테이블 존재여부 확인
SELECT *
FROM tab
WHERE tname LIKE 'DEPT3%';



--테이블 구조만 가져오기(CATA)
CREATE TABLE dept4
AS
SELECT * FROM dept
WHERE 1=2;



--특정 컬럼만 가져오기
CREATE TABLE dept5
AS
SELECT deptno, dname
FROM dept;


--ALTER
--OBJECT를 변경하는 명령어
--컬럼 추가, 삭제, 데이터 타입수정
--부하가 많이 걸리는 명령어로 사용량이 많은 시간에 수행하면 안됨

CREATE TABLE dept6
AS
SELECT dcode, dname
FROM dept2
WHERE dcode IN(1000,1001,1002)
;

--컬럼 추가
--ALTER TABLE dept6
--ADD (LOC VARCHAR2(10 BYTE));

--컬럼추가
ALTER TABLE dept6
ADD (LOCATION VARCHAR2(10 BYTE));

--컬럼추가&디폴트값
ALTER TABLE dept6
ADD (LOCATION2 VARCHAR2(10 BYTE) DEFAULT 'SEOUL');

--테이블 컬럼이름 변경
ALTER TABLE dept6
RENAME COLUMN LOCATION2 TO LOC02
;

--테이블이름 변경
RENAME TABLE dept6 TO dept7;

--컬럼의 데이터크기 변경
ALTER TABLE dept6
MODIFY (LOC VARCHAR2(20 BYTE))
;

--컬럼 삭제
ALTER TABLE dept6
DROP COLUMN LOC
;

--참조키가 있는 컬럼삭제
ALTER TABLE dept6
DROP COLUMN LOC CASCADE CONSTRAINTS;

--TRUNCATE
--테이블의 데이터를 삭제하고 사용하고 있던 공간을 반납(DELETE는 데이터만 삭제함)
TRUNCATE TABLE dept6;

--read_only 테이블 설정

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

--가상컬럼
--테이블 생성시 가상 컬럼을 설정할 수 있다.

--1. 가상 컬럼을 가지는 테이블 생성: 두 컬럼을 더하기
CREATE TABLE vt01(
	COL1 NUMBER,
	COL2 NUMBER,
	COL3 NUMBER GENERATED ALWAYS AS (COL1+COL2)
);

--2. 데이터 입력

--가상컬럼에는 직접 값을 입력할 수 없음
INSERT INTO vt01 VALUES(1,2,3)
;
ORA-54013: INSERT operation disallowed on virtual columns

INSERT INTO vt01(COL1,COL2) VALUES(1,2)
;
--      COL1       COL2       COL3
------------ ---------- ----------
--         1          2          3

--3. 데이터 수정
UPDATE vt01 SET COL1 = 5
;
--      COL1       COL2       COL3
------------ ---------- ----------
--         5          2          7

--4. 새로운 가상컬럼 추가
ALTER TABLE vt01
ADD (COL4 GENERATED ALWAYS AS (COL1*COL2))
;
--      COL1       COL2       COL3       COL4
------------ ---------- ---------- ----------
--         5          2          7         10

--5. 가상컬럼을 DICTIONARY
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

--조건절(CASE)을 활용한 가상컬럼 생성
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
--오라클의 데이터베이스를 운영하기 위한 정보들을 모두 특정한 테이블에 모아두고 관리
--데이터베이스 메모리 구조
--오브젝트들이 사용하는 공간정보
--제약조건
--사용자에데한 정보
--권한이나 프로파일, 롤에대한 정보
--감사에 대한 정보

--DICTIONARY 구분
--STATIC DICTIONARY(수동): USER_XXX, ALL_XXX, DBA_XXX
--DYNAMIC DICTIONARY(동적반영): V$_XXX

--1. TABLE 생성
CREATE TABLE st_table(
	no number
);

--2. 데이터 입력
BEGIN
	FOR i IN 1..1000 LOOP
		INSERT INTO st_table VALUES(i);
	END LOOP;
	COMMIT;
END;
/

--3. STATIC조회: 반영되지 않은부분 확인
SELECT * FROM st_table
;

--4. 수동반영
SELECT num_rows,
	blocks
FROM user_tables
WHERE table_name = 'ST_TABLE'
;
--  NUM_ROWS     BLOCKS
------------ ----------

--4.1 딕셔너리를 관리자가 수동으로 반영
ANALYZE TABLE ST_TABLE COMPUTE STATISTICS
;
--  NUM_ROWS     BLOCKS
------------ ----------
--      1000          5





