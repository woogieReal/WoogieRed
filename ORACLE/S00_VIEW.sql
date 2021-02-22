set linesize 200;
set pagesize 100;

--테이블 생성
--CREATE TABLE o_table(
--	a NUMBER,
--	b NUMBER
--);

--뷰 생성
CREATE OR REPLACE VIEW view1
AS 
SELECT a, b
FROM o_table
;

--뷰에 데이터 입력
--INSERT INTO view1 VALUES(1,2);

--뷰의 데이터 확인
--SELECT *
--FROM view1
--;
--         A          B
------------ ----------
--         1          2
		 
--테이블의 데이터 확인
--SELECT *
--FROM o_table
--;
--         A          B
------------ ----------
--         1          2

--WITH READ ONLY
--읽기전용 뷰 생성
CREATE OR REPLACE VIEW view2
AS
SELECT a,b
FROM o_table
WITH READ ONLY
;

--읽기전용 뷰에 데이터 입력불가
INSERT INTO view2 VALUES(1,2)
;
--ORA-42399: cannot perform a DML operation on a read-only view

--테이블에 데이터 입력후 view를 통해 조회
INSERT INTO o_table VALUES(1,2)
;
SELECT * FROM view2
;
--         A          B
------------ ----------
--         1          2

--WITH CHECK OPTION
--주어진 제약조건에 맞는 데이터만 입력 수정
INSERT INTO view1 VALUES(3,4)
;

--테이블에서 데이터 조회
select *
from o_table
;
--         A          B
------------ ----------
--         1          2
--         3          4

CREATE OR REPLACE VIEW view3
AS
SELECT a,b
FROM o_table
WHERE a = 3
WITH CHECK OPTION
;

select * from view3
;
--         A          B
------------ ----------
--         3          4

UPDATE view3
SET b = 5
WHERE a = 1
;
--0 rows updated.

--COMPLEX_VIEW
--여러 개의 테이블이 조인되어서 생성
--INTERSECT, MINUS, UNION 같은 집합연산자는 사용X(성능저하)
--emp, dept join한 v_emp
CREATE OR REPLACE VIEW v_emp
AS
SELECT t1.ename, t2.dname
FROM emp t1, dept t2
WHERE t1.deptno = t2.deptno
;

--view조회
SELECT *
FROM v_emp
;
--ENAME                DNAME
---------------------- ----------------------------
--SMITH                RESEARCH
--ALLEN                SALES
--WARD                 SALES
--JONES                RESEARCH
--MARTIN               SALES
--BLAKE                SALES
--CLARK                ACCOUNTING
--KING                 ACCOUNTING
--TURNER               SALES
--JAMES                SALES
--FORD                 RESEARCH
--MILLER               ACCOUNTING

--INLINE_VIEW
--1회용 뷰
--FROM절에 VIEW의 SUBQUERY를 바로 적어서 사용

--emp와 dept 테이블을 조회하여 부서번호, 부서별 최대급여 및 부서명
SELECT t1.deptno,
	t2.dname,
	t1.sal
FROM(
	SELECT deptno,MAX(sal) sal
	FROM emp
	GROUP BY deptno
)t1, dept t2
WHERE t1.deptno = t2.deptno
;
--    DEPTNO DNAME                 SAL
------------ -------------- ----------
--        30 SALES                2850
--        20 RESEARCH             3000
--        10 ACCOUNTING           5000

--professor 테이블에서 lag와 inline view를 활용해서 중복된 항목을 제거해서 보여주기
--중복된 deptno 제거하고 출력
SELECT deptno,
	profno,
	name
FROM professor
;

SELECT DECODE(deptno, ndeptno, null, deptno) deptno, profno, name
FROM(
	SELECT LAG(deptno) OVER(order by deptno) ndeptno, 
	deptno, 
	profno, 
	name
	FROM professor
)t1
;
--DEPTNO    PROFNO NAME                
---------- ------- --------------------
--101         1001 Audie Murphy        
--            1002 Angela Bassett      
--            1003 Jessica Lange       
--102         2001 Winona Ryder        
--            2002 Michelle Pfeiffer   
--            2003 Whoopi Goldberg     
--103         3001 Emma Thompson       
--            3002 Julia Roberts       
--            3003 Sharon Stone        
--201         4001 Meryl Streep        
--            4002 Susan Sarandon      
--202         4003 Nicole Kidman       
--            4004 Holly Hunter        
--203         4005 Meg Ryan            
--301         4006 Andie Macdowell     
--            4007 Jodie Foster      

--user_views: 사용자가 생성한 view조회
--dba_views: 모든 사용자가 생성한 view 조회
DROP VIEW v_emp
;

--MATERIALIZED_VIEW
--뷰는 데이터를 가지지 않고 SQL문장을 가지고 있기에 해당 테이블에 가서 데이터를 가져온 후 
--사용자에게 데이터를 반환하고 데이터를 삭제하는 데 대용량 뷰일 경우 성능 이슈가 발생함
--그래서 데이터를 가지고 있는 Mview를 사용한다.

--권한설정
GRANT QUERY REWRITE TO SCOTT;
GRANT CREATE MATERIALIZED VIEW TO SCOTT;

--MVIEW 생성
CREATE MATERIALIZED VIEW m_prof
BUILD IMMEDIATE
REFRESH
ON DEMAND
COMPLETE
ENABLE QUERY REWRITE
AS
SELECT profno, name, pay
FROM professor
;

--BUILD IMMEDIATE: 서브쿼리를 수행하면서 데이터를 가져오라
--ON DEMAND: 사용자가 수동으로 데이터 동기화
--ON COMMIT: 원본 테이블 변경 후 COMMIT이 발생하면 자동으로 동기화
--COMPLETE: MVIEW 내의 데이터 전체가 원본 테이블과 동기화 되는 방법
--ATOMIC_REFRESH = TRUE와 COMPLETE로 설정 되어 있어야함
--데이터가 많은 경우 시간이 많이 소요
--FAST: 원본 테이블에 새로운 데이터가 입력된 경우 그 부분만 MVIEW로 동기화
--FORCE: FAST방법이 가능한지 살펴보고 불가능하면 COMPLETE방법을 사용자가
--NEVER: 동기화 하지 않음

--MVIEW 에는 데이터가 존재하기 때문에 index도 생성가능
CREATE INDEX idx_m_prof_pay
ON m_prof(pay ASC)
;

--MVIEW 관리
--생성옵션에서 ON COMMIT을 설정하면 즉시 동기화가 되나 대량의 데이터가 변경될 경우 큰 부하를 유발
BEGIN
	DBMS_MVIEW.REFRESH('뷰이름');
END;
/

--모든 Mview를 동기화하는 구문
EXEC DMBS_MVIEW.REFRESH_ALL_MVIEW
;

