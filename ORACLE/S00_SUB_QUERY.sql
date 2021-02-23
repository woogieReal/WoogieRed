
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
