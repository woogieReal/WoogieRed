--OLTP: B-Tree 인덱스 사용(실시간 데이터 입출력하는 용도)
--OLAP: BITMAP 인덱스 사용(대량의 데이터를 분석하는 용도)

--B-TREE 인덱스
--Root Block, Branch Block, Leaf Block으로 구성
--실제로 데이터가 들어있는 곳은 Leaf Block

--생성시: Leaf Block -> Branch Block -> Root Block
--데이터 조회시: Root Block -> Branch Block -> Leaf Block

--B-Tree의 B는 Binary란 의미도 있고 Balance라는 의미도 있다.
--Root Block을 기준으로 왼쪽과 오른쪽 데이터의 balance가 맞을 때 성능이 우수

--B-Tree 인덱스: 
--1. Unique Index
--2. NONE Unique Index
--3. Function Based Index(함수기반 인덱스)
--4. Descending Index(내림차순 인덱스)
--5. Composite Index(결합 인덱스)

--BITMAP INDEX
--OLAP에서 주로 쓰임
--B-TREE는 값의 종류가 많고 동일한 데이터가 적을 경우 사용
--BITMAP의 경우 값의 종류가 적고 동일한 데이터가 많을 경우 사용(ex.성별)

--문법
--CREATE BITMAP INDEX 인덱스명
--ON 테이블명(컬럼명1 [ASC(기본)|DESC],컬럼명2 [ASC(기본)|DESC]);

CREATE BITMAP INDEX idx_emp_deptno
ON emp(deptno)
;
-- Standard Edition 버전(유료버전)에서만 사용 가능
-- ORA-00439: feature not enabled: Bit-mapped indexes

--1. Unique Index
--key값에 중복되는 데이터가 없다.
--중복될 ?이 입력될 가능성이 있는 컬럼에는 사용할 수 없다.
--성능이 좋음

--문법
--CREATE UNIQUE INDEX 인덱스명(IX/IDX_테이블이름_컬럼)
--ON 테이블 (컬럼명1 [ASC(기본)|DESC], 컬럼명2 [ASC(기본)|DESC]);

--UNIQUE INDEX를 ename에 걸었기 때문에 같은 ename은 입력될 수 없다.
CREATE UNIQUE INDEX IDX_emp_ename
ON emp (ename ASC)
;
--Index created.

--데이터 입력
INSERT INTO emp
VALUES(7936,'WOOGIE','CLERCK',7902,'1980-12-17',880,100,20)
;
--ORA-00001: unique constraint (SCOTT.IDX_EMP_ENAME) violated

--2. NONE Unique Index
--중복될 데이터가 있는 컬럼일 경우 사용

--문법
--CREATE INDEX 인덱스명(IX/IDX_테이블이름_컬럼)
--ON 테이블 (컬럼명1 [ASC(기본)|DESC], 컬럼명2 [ASC(기본)|DESC]);

--NONE Unique Index이기 때문에 job칼럼에 중복값이 입력 될 수 있다.
CREATE INDEX IDX_emp_job
ON emp (job DESC)
;
--Index created.

--데이터 입력
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

--3. Function Based Index(함수기반 인덱스)
--인덱스는 WHERE 절에 오는 조건컬럼이나 조인컬럼 등에 만들어야 함(ex.WHERE empno = ?)
--하지만 WHERE 절의 조건을 다른형태로 가공시에는 인덱스를 활용할 수 없음
--(ex.WHERE empno * 100 = ? / WHERE empno != ?)

--Index Suppressing Error
--인덱스가 있지만 위와 같이 sql작성오류로 인덱스를 사용할 수 없는 경우

--이를 해결하기 위해 함수처럼 연산을 해서 인덱스 생성
--임시적인 해결책임을 주의

CREATE INDEX IDX_emp_deptno
ON emp(deptno/10)
;
--Index created.

--데이터 조회
SELECT *
FROM emp
WHERE deptno/10 = 1
;
--     EMPNO ENAME    JOB          MGR HIREDATE        SAL       COMM     DEPTNO
------------ -------- ---------- ----- -------- ---------- ---------- ----------
--      7782 CLARK    MANAGER     7839 81/06/09       2450                    10
--      7839 KING     PRESIDENT        81/11/17       5000                    10
--      7934 MILLER   CLERK       7782 82/01/23       1300                    10

--4. Descending Index(내림차순 인덱스)
--오름차순으로 정렬을 했는데 내림차순으로 데이터를 보고 싶은 경우 새로운 인덱스를 생성하면 좋지않음
--인덱스가 많으면 DML 성능에 악영향을 끼침
--오라클에서는 이를 해결하기 위해 '힌트'라는 방법을 제공, 이를 통해 정렬을 한 효과를 내고
--최솟값, 최댓값을 구하기도 함(뒤에서 배움)

--5. Composite Index(결합 인덱스)
--두 개 이상의 컬럼을 합쳐서 인덱스를 생성하는 것
--주로 WHERE조건 컬럼이 2개이상인 경우(AND로 연결될 때, OR는 안됨)
--아주 많이 사용하는 인덱스로, 인덱스 컬럼순서가 성능에 많은 영향을 끼침

CREATE INDEX idx_emp_comp
ON emp(ename, job)
;
--Index created.

--인덱스관리하기: DICTIONARY

--user: USER_INDEXES, USER_IND_COLUMNS
--DBA: DBA_INDEXES, DBA_IND_COLUMNS

--인덱스 확인
--WHERE절에서 테이블명은 대문자로 (EX.'EMP2')
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

--인덱스 사용여부 모니터링 하기
--사용하지 않는 인덱스를 삭제하기 위함
--모니터링 시작하기
--ALTER INDEX 인덱스이름 MONITORING USAGE;
--모니터링 중단
--ALTER INDEX 인덱스이름 NOMONITORING USAGE;

--모니터링 시작하기
ALTER INDEX TMP2_NAME_UK MONITORING USAGE
;
--Index altered.

--모니터링 사용여부 확인
SELECT index_name,
	used
FROM v$object_usage
WHERE index_name = 'TMP2_NAME_UK'
;
--INDEX_NAME       USED
------------------ ------
--TMP2_NAME_UK     NO

--모니터링 중단
ALTER INDEX TMP2_NAME_UK NOMONITORING USAGE
;
--Index altered.

--INDEX_REBUILD
--1. I_TEST 테이블 생성
--2. 데이터 10000건 입력
--3. 인덱스
--4. 인덱스 상태 조회
--5. 테이블에서 데이터 삭제
--6. 인덱스 상태 조회
--7. 인덱스 REBUILD
--8. 인덱스 상태 조회

--1. I_TEST 테이블 생성
CREATE TABLE i_test(
	no NUMBER,
	name VARCHAR2(20)
);

--2. 데이터 10000건 입력
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

--3. 인덱스
CREATE INDEX idx_test_no
ON i_test(no DESC)
;
--Index created.

--4. 인덱스 상태 조회
--STATIC DICTIONARY 조회하므로 통계정보를 갱신해야함
ANALYZE INDEX IDX_TEST_NO VALIDATE STRUCTURE
;
--Index analyzed.

--DESC index_stats;
--LF_ROWS_LEN
--DEL_LF_ROWS_LEN

--balance가 0에 가까울 수록 우수
SELECT lf_rows_len,
	del_lf_rows_len,
	(del_lf_rows_len/lf_rows_len)*100 balance
FROM index_stats
WHERE name = 'IDX_TEST_NO'
;
--LF_ROWS_LEN DEL_LF_ROWS_LEN    BALANCE
------------- --------------- ----------
--     159801               0          0

--5. 테이블에서 데이터 삭제
DELETE 
FROM i_test
WHERE no BETWEEN 1 AND 4000
;
COMMIT;
--4000 rows deleted.
--Commit complete.

--6. 인덱스 상태 조회
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

--7. 인덱스 REBUILD
ALTER INDEX IDX_TEST_NO REBUILD
;
--Index altered.

--8. 인덱스 상태 조회
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
--인덱스를 삭제하기 전에 사용안함 상태로 만듬
--ALTER INDEX 인덱스이름 INVISIBLE

--인덱스사용
--1. new_emp4테이블 생성(no, name, sal)
CREATE TABLE new_emp4(
	no NUMBER, 
	name VARCHAR2(20), 
	sal NUMBER
);

--2. 데이터입력
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

--3. name컬럼에 인덱스 생성
CREATE INDEX IDX_EMP4_NAME
ON new_emp4(name ASC)
;

--4. 인덱스 사용 vs 미사용
--미사용
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

--사용
--NAME 컬럼에 있는 인덱스를 써라(name > '0')
--0보다 다 크므로
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

--4.1 실행계획
--미사용
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

--사용
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

--5. 최소/최대값을 min/max를 인덱스 사용으로 대처
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
--INDEX 힌트를 이용
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
--오라클에서 데이터의 주소를 주소라 하지 않고 ROWID라 한다.
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

--AAAE+6 :데이터 오브젝트 번호
--LAA :파일번호
--EAAAAK : 블록번호
--AAN :로우번호

SELECT ROWID,
	empno,
	ename
FROM emp
WHERE ROWID = 'AAAE6LAAEAAAAK+AAN'
;
--ROWID                   EMPNO ENAME
-------------------- ---------- ----------------
--AAAE6LAAEAAAAK+AAN       7937 WOOGIE2







