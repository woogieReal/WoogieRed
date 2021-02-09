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







