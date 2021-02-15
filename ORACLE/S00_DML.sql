--INSERT

--기본
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

--컬럼명 생략
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

--특정컬럼에만 값을 입력
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

--날짜 데이터 입력하기
--PROFNO
--NAME
--ID
--POSITION
--PAY
--HIREDATE

INSERT INTO professor(PROFNO, NAME, ID, POSITION, PAY, HIREDATE)
VALUES(5001, 'James Bond','Love me','a full professor', 500, '2014-10-23')
;

--NULL 처리
--1. 자동 NULL 값 입력
--데이터를 입력할 때 컬럼에 값을 입력하지 않으면 자동으로 NULL값이 들어간다.
--2. 수동 NULL 값 입력
--데이터를 입력할 때 NULL을 적어주면 된다.

--테이블 생성
CREATE TABLE t_minus(
	no1 NUMBER,
	no2 NUMBER(3),
	no3 NUMBER(3,2)
);

--정수값
INSERT INTO t_minus
VALUES(1,1,1)
;
COMMIT;

--소수값
--NUMBER라고만 데이터타입을 지정하면 소숫값 들어옴
--길이를 따로 지정하면 소수자리도 지정해 줘야함
INSERT INTO t_minus
VALUES(1.1,1.1,1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1

--음수값
--따로 지정할 필요없음
INSERT INTO t_minus
VALUES(-1.1,-1.1,-1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1
--      -1.1         -1       -1.1

--INSERT를 통한 다건 입력

--테이블 구조만 가져오기
CREATE
TABLE professor3
AS
SELECT * FROM professor
WHERE 1=2
;

SELECT COUNT(*) FROM professor3
;

--데이터 전부 복사
INSERT INTO professor3
SELECT * FROM professor
;
COMMIT
;
SELECT COUNT(*) FROM professor3
;

--INSERT ALL
--여러 테이블에 여러행 입력

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
--기존의 데이터를 다른 데이터로 변경할 때 사용
--UPDATE TABLE
--SET column = value
--WHERE 조건;
--(SELECT를 먼저 수행, 결과를 확인하고 수행할 것)
--실수한 경우: ROLLBACK;

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

--예2
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
--여러 테이블의 데이터를 합치는 병합을 의미

--MERGE INTO TABLE1
--USING TABLE2
--ON (병합조건)
--WHEN MATCHED THEN
--	UPDATE(DELETE) SET 업데이트내용
--WHEN NOT MATCHED THEN
--	INSERT VALUES(값)

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

--UPDATE 조인
--다른 테이블과 조인을 하는 UPDATE문

--WHERE절에만 다른 테이블과 조인을
--emp테이블에서 부서가 DALLAS에 위치하는 부서에 근무하는 사원의 급여를 10%인상 하세요.

--loc가 DALLAS인 직원
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

--TRANSACTION 관리
--논리적인 작업단위를 의미
--DML작업들을 하나의 단위로 묶어 둔 것을 의미
--해당 트랜잭션 내에 있는 모든 DML이 성공해야 해당 트랜잭션이 성공하는것이고
--만약 1개의 DML이라도 실패하면 전체가 실패하게 된다.
--DML작업을 한 후에는 반드시 COMMIT 이나 ROLLBACK 명령을 수행해야 작업이 마무리됨

--DELETE 이후 테이블 용량확인
--1. 테스트 테이블을 생성한다.
--1.1. 대량의 데이터 입력
--2. 테이블의 크기 측정
--3. 데이터 삭제 후 테이블의 크기 확인
--C:\oraclexe\app\oracle\oradata\XE\USERS.DBF

--USERS.DBF 자동으로 증가하도록 변경.
--ALTER DATABASE DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\USERS.DBF' AUTOEXTEND on;

--1. 테스트 테이블을 생성한다.
CREATE TABLE scott.reorg(
	no NUMBER,
	name VARCHAR2(20 BYTE),
	address VARCHAR2(20 BYTE)
);

--1.1. 대량의 데이터 입력
BEGIN 
	FOR i IN 1..500000 LOOP
		INSERT INTO scott.reorg VALUES(i, DBMS_RANDOM.STRING('U',19), DBMS_RANDOM.STRING('U',19));
	END LOOP;
	COMMIT;
	
END;
/

--DBMS_RANDOM.STRING
--랜던 문자열 생성한다
--SYSNTAX: DBMS_RANDOM.STRING opt IN CHAR, len IN NUMBER
--opt(옵션)은 아래와 같다.
--'u', 'U': 대문자
--'l', 'L': 소문자
--'a', 'A': 대소문자 구분없는 영문자
--'x', 'X': 영문자와 숫자 혼합
--'p', 'P': 문자 혼합

--2. 테이블의 크기 측정
SELECT bytes/(1024*1024) "MB"
FROM dba_segments
WHERE owner = 'SCOTT'
AND segment_name = 'REORG'
;
--        MB
------------
--        28

--2.1. dba_tables
--static dictionary 수동으로 정보 update
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

--3. 데이터 삭제 후 테이블의 크기 확인
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

--실제 사용하고 있는 block조회 
SELECT COUNT(DISTINCT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid)
	|| DBMS_ROWID.ROWID_RELATIVE_FNO(rowid)) "REAL_USED"
FROM scott.reorg
;
-- REAL_USED
------------
--         0

--테이블 reorg(재구성)수행.

--tablespace_name확인
SELECT table_name,
	tablespace_name
FROM dba_tables
WHERE owner = 'SCOTT'
AND table_name = 'REORG'
;
--TABLE_NAME     TABLESPACE_NAME
---------------- ------------------
--REORG          USERS


--테이블을 다른장소로 옮기는 명령어지만 현재 테이블 스페이스 이름만 적어주면 용량이 적어짐
ALTER TABLE scott.reorg MOVE TABLESPACE USERS;

SELECT bytes/(1024*1024) "MB"
FROM dba_segments
WHERE owner = 'SCOTT'
AND segment_name = 'REORG'
;
--        MB
------------
--     .0625