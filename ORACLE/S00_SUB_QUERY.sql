
--Sub Query(서브쿼리)
--하나의 쿼리안에 또 다른 쿼리가 있는 것
--SELECT COLUMN                  <- 메인쿼리(outer 쿼리)
--FROM TABLE
--WHERE 조건 (SELECT COLUMN FROM TABLE WHERE 조건)             <- 서브쿼리(inner 쿼리)
SELECT ename,
	comm
FROM emp
WHERE comm < (
	SELECT comm
	FROM emp
	WHERE ename = 'WARD'
	)
;
--ENAME                      COMM
---------------------- ----------
--ALLEN                       300
--TURNER                        0

--서브쿼리의 종류
--1. 단일행 서브쿼리: 서브쿼리의 수행결과 값이 1row만 출력
--연산자) <,>,=,<>같지 않음

--Anthony Hopkins와 같은 학과인 사람들의 이름과 학과이름 출력
SELECT t1.name, t2.dname
FROM student t1, department t2
WHERE deptno1 = (
	SELECT deptno1
	FROM student
	WHERE name = 'Anthony Hopkins'
)
AND t1.deptno1 = t2.deptno
;
--NAME                DNAME
--------------------- -----------------------------
--Anthony Hopkins     Software Engineering
--Sandra Bullock      Software Engineering

--Meg Ryan의 입사일보다 늦은 사람의 이름, 입사일, 부서명을 출력
SELECT t1.name, t1.hiredate, t2.dname
FROM professor t1, department t2
WHERE hiredate > (
	SELECT hiredate
	FROM professor
	WHERE name ='Meg Ryan'
	)
AND t1.deptno = t2.deptno
;
--NAME                       HIREDATE DNAME
---------------------------- -------- -----------------------------------------
--Angela Bassett             87/01/30 Computer Engineering
--Jessica Lange              98/03/22 Computer Engineering
--Winona Ryder               01/09/01 Multimedia Engineering
--Michelle Pfeiffer          85/11/30 Multimedia Engineering
--Julia Roberts              97/07/01 Software Engineering
--Sharon Stone               02/02/24 Software Engineering
--Susan Sarandon             09/08/30 Electronic Engineering
--Nicole Kidman              99/12/01 Mechanical Engineering
--Holly Hunter               09/01/28 Mechanical Engineering
--Andie Macdowell            10/06/28 Library and Information science
--Jodie Foster               01/05/23 Library and Information science

--학과번호 201의 평균몸무게보다 몸무게가 많은 학생의 이름과 몸무게 출력
SELECT name, weight
FROM student
WHERE weight > (
	SELECT AVG(weight)
	FROM student
	WHERE deptno1 = 201
	)
;
--NAME                           WEIGHT
---------------------------- ----------
--James Seo                          72
--Demi Moore                         83
--Danny Glover                       70
--Richard Dreyfus                    72
--Tim Robbins                        70
--Wesley Snipes                      82
--Christian Slater                   69
--Charlie Sheen                      81

--2. 다중행 서브쿼리: 서브쿼리의 수행결과 값이 2row이상
--연산자) exists, in, >any, <any, >all, <all
--IN: 서브쿼리의 결과와 같은 값을 찾음
--EXISTS: 서브쿼리 값이 존재할 경우 메인쿼리를 수행
-->ANY: 서브쿼리의 결과 중에 최소값
--<ANY: 서브쿼리의 결과 중에 최대값
-->ALL: 서브쿼리의 결과 중에 최대값
--<ALL: 서브쿼리의 결과 중에 최소값

--Section head 직급의 최소연봉자보다 더 많은 연봉을 받는 사람의 이름, 직급, 연봉을 출력
SELECT name, position, TO_CHAR(pay,'$9,999,999,999,999') SALARY
FROM emp2
WHERE pay > ANY (
	SELECT pay
	FROM emp2
	WHERE position = 'Section head'
	)
ORDER BY pay DESC
;
--NAME                  POSITION                  SALARY
----------------------- ------------------------- ----------------------
--Kurt Russell          Boss                             $100,000,000
--Kevin Bacon           Department head                   $75,000,000
--AL Pacino             Department head                   $72,000,000
--Val Kilmer            Department head                   $68,000,000
--Tommy Lee Jones       Deputy department head            $60,000,000
--Gene Hackman          Section head                      $56,000,000
--Hugh Grant            Section head                      $51,000,000
--Woody Harrelson       Section head                      $50,000,000

--2학년 학생 중 가장 체중이 적게나가는 학생보다 더 적게나가는 학생의 이름과 학년, 몸무게 출력
SELECT name, grade, weight
FROM student
WHERE weight < all (
	SELECT weight
	FROM student
	WHERE grade = 2
	)
;
--NAME                    GRADE     WEIGHT
-------------------- ---------- ----------
--Billy Crystal               3         48
--Nicholas Cage               3         42
--Danny Devito                1         48

--가장 평균연봉이 낮은 부서의 평균연봉보다 적게 받는 직원들의 부서명, 직원명, 연봉을 출력
SELECT t2.dname, t1.name, t1.pay
FROM emp2 t1, dept2 t2
WHERE pay < all (
	SELECT AVG(pay) OVER(PARTITION BY deptno)
	FROM emp2
	)
AND t1.deptno = t2.dcode
;
--DNAME                  NAME                       PAY
------------------------ ------------------- ----------
--H/W Support Team       Harrison Ford         20000000
--S/W Support Team       Clint Eastwood        20000000
--Sales1 Team            JohnTravolta          22000000
--Sales2 Team            Robert De Niro        22000000
--Sales3 Team            Sly Stallone          22000000
--Sales4 Team            Tom Cruise            20000000

--IN
SELECT empno, name, deptno
FROM emp2
WHERE deptno IN (
	SELECT dcode
	FROM dept2
	WHERE area = 'Pohang Main Office'
	)
;
--     EMPNO NAME                      DEPTNO
------------ ------------------------- ------------
--  19900101 Kurt Russell              0001
--  19966102 Kevin Bacon               1003
--  19970112 Val Kilmer                1006
--  19960212 Chris O'Donnell           1007

--EXISTS
--서브쿼리의 내용을 먼저 수행하고 그 결과가 1건이라도 나옴면 메인쿼리 수행
--한 건도 나오지 않으면 메인쿼리가 수행 안됨
--서브쿼리는 true/false라고 보고 true면 메인쿼리가 수행되는 것
SELECT *
FROM dept
WHERE EXISTS(
	SELECT deptno
	FROM dept
	WHERE deptno = &deptno
	)
;

--3. 다중컬럼 서브쿼리
--서브쿼리의 수행결과가 여러 컬럼인 경우
--pk를 여러 컬럼에 잡은 경우 한꺼번에 비교하기 위해 사용
--각 학년별로 최대 몸무게를 가진 학생들의 이름과 몸무게 출력
SELECT t2.grade,
	t2.name,
	t2.weight
FROM student t2
WHERE (t2.grade, t2.weight) IN (
	SELECT grade, MAX(t1.weight)"max_weight"
	FROM student t1
	GROUP BY grade
	)
ORDER BY 1
;
--   GRADE NAME                 WEIGHT
---------- ---------------- ----------
--       1 Charlie Sheen            81
--       2 Wesley Snipes            82
--       3 Bill Murray              58
--       4 Demi Moore               83

--각 학과별로 입사일이 가장 오래된 교수의 교수번호와 이름, 학과명을 출력
SELECT t1.profno, t1.name, t1.hiredate, t2.dname
FROM professor t1, department t2
WHERE (t1.deptno, t1.hiredate) IN (
	SELECT deptno, MIN(hiredate) min_hire
	FROM professor
	GROUP BY deptno
	)
AND t1.deptno = t2.deptno
ORDER BY hiredate
;
--  PROFNO NAME               HIREDATE DNAME
---------- ------------------ -------- -------------------------------------
--    1001 Audie Murphy       80/06/23 Computer Engineering
--    4001 Meryl Streep       81/10/23 Electronic Engineering
--    3001 Emma Thompson      81/10/23 Software Engineering
--    2003 Whoopi Goldberg    82/04/29 Multimedia Engineering
--    4005 Meg Ryan           85/09/18 Chemical Engineering
--    4003 Nicole Kidman      99/12/01 Mechanical Engineering
--    4007 Jodie Foster       01/05/23 Library and Information science

--4. 상호연관_서브쿼리
--메인쿼리와 서브쿼리가 값을 주고 받으며 수행
--성능이 아주 나쁜 서브쿼리

--직원들 중 자신의 직급평균연봉과 같거나 많이 받는 사람들의 이름, 직급, 현재연봉 출력
SELECT t1.name,
	t1.position,
	TO_CHAR(t1.pay,'$999,999,999,999')"SALARY"
FROM emp2 t1
WHERE t1.pay >= (
	SELECT AVG(pay)
	FROM emp2 t2
	WHERE t1.position = t2.position
);
--NAME                POSITION                     SALARY
--------------------- ---------------------------- ---------------------
--Kurt Russell        Boss                              $100,000,000
--AL Pacino           Department head                    $72,000,000
--Tommy Lee Jones     Deputy department head             $60,000,000
--Gene Hackman        Section head                       $56,000,000
--Kevin Bacon         Department head                    $75,000,000
--Keanu Reeves        Deputy Section chief               $35,000,000

--5. 스칼라_서브쿼리
--select절에 오는 서브쿼리로 한 번에 결과를 1행씩 반환
--출력하고자 하는 데이터의 양이 적을 때는 스칼라 서브쿼리가 join보다 빠름

--스칼라 서브쿼리를 사용해 사원들의 이름과 부서 이름을 출력
SELECT t1.name,
	(SELECT t2.dname 
	FROM dept2 t2 
	WHERE t2.dcode = t1.deptno
	)"dname"
FROM emp2 t1
;
--NAME                      dname
--------------------------- -------------------------------
--Kurt Russell              President
--AL Pacino                 Management Support Team
--Woody Harrelson           Management Support Team
--Tommy Lee Jones           Financial Management Team
--Gene Hackman              General affairs
--Kevin Bacon               Engineering division
--Hugh Grant                H/W Support Team
--Keanu Reeves              S/W Support Team
--Val Kilmer                Business Department
--Chris O'Donnell           Business Planning Team
--Jack Nicholson            Sales1 Team
--Denzel Washington         Sales2 Team
--Richard Gere              Sales3 Team
--Kevin Costner             Sales4 Team
--JohnTravolta              Sales1 Team
--Robert De Niro            Sales2 Team
--Sly Stallone              Sales3 Team
--Tom Cruise                Sales4 Team
--Harrison Ford             H/W Support Team
--Clint Eastwood            S/W Support Team

--6. with_서브쿼리
--with절을 사용하여 원하는 테이블을 메모리에 생성 후 데이터를 가져오는 기법
--성능은 우수하지만 사용법이 어려움

--1. 단일 가상 테이블
WITH A AS
(
	SELECT Query
)

--2. 다중 가상 테이블
WITH a AS(
	SELECT query
), b AS (
	SELECT query
)
SELECT * from a
SELECT * from b
;

--주의사항
--with절에는 select문장만 사용가능
--with절에 또 다른 with 절을 사용할 수 없다.

--1. 대용량의 테이블을 생성한 후 최대값과 최솟값의 차이를 구하기
--1.1. 대용량의 테이블을 만들기 위해 관리자 로그인, 파일 용량을 증가 시키도록 option 수정
--1.2. SCOTT 계정으로 로그인
--1.3. 테스트용 테이블 생성 5,000,000건 데이터 입력
--1.4. min, max로 최대 최소를 구하고 시간 측정
--1.5. 인덱스를 생성한 후 최대/최소를 구하고 시간 측정
--1.6. with문을 사용하여 최대/최소를 구하고 시간 측정

SELECT tablespace_name,
	bytes/(1024*1024) "MB",
	file_name
FROM dba_data_files
;
--TABLESPACE_NAME              MB FILE_NAME
---------------------- ---------- ----------------------------------------------
--USERS                       100 C:\APP\APP\ORACLE\ORADATA\XE\USERS.DBF
--SYSAUX                      660 C:\APP\APP\ORACLE\ORADATA\XE\SYSAUX.DBF
--UNDOTBS1                    380 C:\APP\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF
--SYSTEM                      360 C:\APP\APP\ORACLE\ORADATA\XE\SYSTEM.DBF

--1.1. 대용량의 테이블을 만들기 위해 관리자 로그인, 파일 용량을 증가 시키도록 option 수정
ALTER DATABASE DATAFILE 'C:\APP\APP\ORACLE\ORADATA\XE\USERS.DBF'
AUTOEXTEND ON
;
--Database altered.

--1.2. SCOTT 계정으로 로그인
conn scott/sist
--Connected.

--1.3. 테스트용 테이블 생성 5,000,000건 데이터 입력
DROP TABLE with_test1;
CREATE TABLE with_test1(
	no NUMBER,
	name VARCHAR2(10),
	pay NUMBER(6)
)TABLESPACE USERS
;
--Table created.

BEGIN
	FOR i IN 1..5000000 LOOP
		INSERT INTO with_test1 VALUES(
			i,
			DBMS_RANDOM.STRING('A',5),
			DBMS_RANDOM.VALUE(6,999999)
		);
	END LOOP;
	COMMIT;
END;
/

SELECT COUNT(*) FROM with_test1
;
--  COUNT(*)
------------
--   5000000

--1.4. min, max로 최대 최소를 구하고 시간 측정
SELECT MAX(pay)-MIN(pay)
FROM with_test1
;
--MAX(PAY)-MIN(PAY)
-------------------
--           999993
--
--Elapsed: 00:00:00.20

--1.5. 인덱스를 생성한 후 최대/최소를 구하고 시간 측정
CREATE INDEX idx_with_pay
ON with_test1(pay)
;
--Elapsed: 00:00:03.53

--1.5.1. 인덱스가 항상 빠르지는 않다
SELECT MAX(pay)-MIN(pay)
FROM with_test1
WHERE pay > 0
;
--Elapsed: 00:00:01.33

--1.6. with문을 사용하여 최대/최소를 구하고 시간 측정

--a: 힌트를 사용하여 ASC 인덱스를 DESC로 하여 MAX값 출력
--b: MIN 값을 출력
WITH a AS (
	SELECT /*+ index_desc(t1 idx_with_pay)*/ pay
	FROM with_test1 t1
	WHERE pay > 0
	AND rownum = 1
),  b AS (
	SELECT /*+ index(t1 idx_with_pay)*/ pay
	FROM with_test1 t1
	WHERE pay > 0
	AND rownum = 1
)
SELECT a.pay, b.pay, a.pay - b.pay
FROM a, b
;
--       PAY        PAY A.PAY-B.PAY
------------ ---------- -----------
--    999999          6      999993

--Elapsed: 00:00:00.02 //--with 쿼리
--Elapsed: 00:00:00.20 //--일반 쿼리

--with_test1 테이블에서 no 120000번에서 130000사이인 사람들 중 가장 pay가
--적은 사람을 작은 후 그 사람보다 pay가 작은 사람 수를 세는 작업.
--1. no 컬럼에 인덱스 생성
--2. 서브쿼리를 이용해서 데이터 조회 및 시간 측정
--3. with절을 이용해서 데이터 조회 및 시간 측정.

--1. no 컬럼에 인덱스 생성
CREATE INDEX idx_with_no
ON with_test1(no)
;
--Index created.

--2. 서브쿼리를 이용해서 데이터 조회 및 시간 측정
SELECT COUNT(*)
FROM with_test1
WHERE pay < ALL (
	SELECT /*+ INDEX(t1 idx_with_no) */pay
	FROM with_test1
	WHERE no BETWEEN 120000 AND 130000
);
--  COUNT(*)
------------
--       257
--Elapsed: 00:00:02.33

--3. with절을 이용해서 데이터 조회 및 시간 측정.
WITH t AS (
	SELECT /*+ INDEX(t1 idx_with_no) */MIN(pay) min_pay
	FROM with_test1 t1
	WHERE no BETWEEN 120000 AND 130000
)
SELECT COUNT(*)
FROM with_test1 t1, t
WHERE t1.pay < t.min_pay
;
--  COUNT(*)
------------
--       257
--Elapsed: 00:00:00.01

--반복적인 테이블을 한 번만 수행하도록 하고 소요 시간 측정
--pay 중에 제일 작은 값과, 제일 큰 값, 그리고 제일 큰 값과 제일 작은 값 차이를 출력

--pay에 만든 인덱스 삭제
DROP INDEX idx_with_pay
;
--Index dropped.

--UNION ALL
SELECT 'MAX_PAY' C1, MAX(PAY) "RESULT" FROM with_test1
UNION ALL
SELECT 'MIN_PAY' C1, MIN(PAY) FROM with_test1
UNION ALL
SELECT 'MAX-MIN' C1, MAX(PAY) - MIN(PAY) FROM with_test1
;
--C1                 RESULT
---------------- ----------
--MAX_PAY            999999
--MIN_PAY                 6
--MAX-MIN            999993
--
--Elapsed: 00:00:00.41

WITH sub_pay AS (
	SELECT MAX(pay) max_pay, MIN(pay) min_pay
	FROM with_test1
)
SELECT 'MAX_PAY' C1, max_pay "RESULT" FROM sub_pay
UNION ALL
SELECT 'MIN_PAY' C1, min_pay FROM sub_pay
UNION ALL
SELECT 'MAX-MIN' C1, (max_pay - min_pay) FROM sub_pay
;
--C1                 RESULT
---------------- ----------
--MAX_PAY            999999
--MIN_PAY                 6
--MAX-MIN            999993
--
--Elapsed: 00:00:00.18



