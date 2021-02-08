--JOIN
--여러 테이블에 흩어져 있는 데이터들을 조합해서 가져오는 기술
--ORACLE과 ANSI join 문법이 다름

--ORACLE JOIN
--SELECT t1.col1, t2.col1
--FROM table t1, table t2 //보통 alias를 지정
--WHERE t1.col1 = t2.col1
--join조건이 where에 붙음

--ANSI JOIN
--SELECT t1.col1, t2.col1
--FROM table t1 [INNER] JOIN table t2
--ON t1.col1 = t2.col1
--join 조건이 ON에 붙음

--JOIN에 사용되는 용어
--선행테이블(driving table, inner table)과 후행테이블(driven table, outer table)
--조인이 사용될 때 두 개 이상의 테이블이 사용되는데 이때 둘 중 하나의 테이블을 먼저 읽고(선행테이블)
--JOIN조건절을 이용해 나머지 테이블(후행테이블)에 가서 데이터를 가져옴
--선행테이블은 조회할 데이터가 적은 테이블로 선택해야 속도면에서 유리함

--CARTESIAN_PRODUCT
--JOIN 조건을 잘못 주거나 주지않았을 때 해당 테이블에 대한 모든 데이터를 가져오는 현상
--일부러 쓰기도 함
--데이터를 복제해서 원본 테이블을 반복해서 읽는 것을 피하기 위해

--1.연습용 테이블 생성
--CREATE TABLE은 COMMIT을 안해도 됨
--DROP TABLE CAT_A;
--CREATE TABLE CAT_A (
--	no NUMBER,
--	name VARCHAR2(1)
--);
--
--DROP TABLE CAT_B;
--CREATE TABLE CAT_B (
--	no NUMBER,
--	name VARCHAR2(1)
--);
--
--DROP TABLE CAT_C;
--CREATE TABLE CAT_C (
--	no NUMBER,
--	name VARCHAR2(1)
--);

--2.데이터 삽입
--INSERT INTO CAT_A VALUES (1,'A');
--INSERT INTO CAT_A VALUES (2,'B');
--
--INSERT INTO CAT_B VALUES (1,'C');
--INSERT INTO CAT_B VALUES (2,'D');
--						 
--INSERT INTO CAT_C VALUES (1,'E');
--INSERT INTO CAT_C VALUES (2,'F');

--COMMIT;

--3.데이터 조회
--COL NO FOR 99
--COL NAME FOR A4
--SELECT * FROM CAT_A;
--SELECT * FROM CAT_B;
--SELECT * FROM CAT_C;

-- NO NAME    NO NAME   NO NAME
----- ----   --- ----  --- ----
--  1 A        1 C       1 E
--  2 B        2 D       2 F

--JOIN 2개 테이블
SELECT t1.no
	,t1.name
	,t2.name
FROM cat_a t1, cat_b t2
WHERE t1.no = t2.no;
-- NO NAME NAME
----- ---- ----
--  1 A    C
--  2 B    D

--CARTESIAN PRODUCT
--WHERE로 JOIN 조건을 지정해 주지 않았기에 발생
SELECT t1.no
	,t1.name
	,t2.name
FROM cat_a t1, cat_b t2;
--WHERE t1.no = t2.no;
-- NO NAME NAME
----- ---- ----
--  1 A    C
--  1 A    D
--  2 B    C
--  2 B    D

--JOIN 3개 테이블
SELECT t1.no, t1.name, t2.name, t3.name
FROM cat_a t1, cat_b t2, cat_c t3
WHERE t1.no = t2.no AND t2.no = t3.no;
-- NO NAME NAME NAME
----- ---- ---- ----
--  1 A    C    E
--  2 B    D    F

--CARTESIAN PRODUCT
--WHERE로 JOIN 조건을 지정해 주지 않았기에 발생
SELECT t1.no, t1.name, t2.name, t3.name
FROM cat_a t1, cat_b t2, cat_c t3;
--WHERE t1.no = t2.no AND t2.no = t3.no;
-- NO NAME NAME NAME
----- ---- ---- ----
--  1 A    C    E
--  1 A    C    F
--  1 A    D    E
--  1 A    D    F
--  2 B    C    E
--  2 B    C    F
--  2 B    D    E
--  2 B    D    F

--CARTESIAN PRODUCT
--쿼리가 잘 작동하는지(속도가 빠른지) 테스트하기 위해서 대량의 데이터를 만드는 방법
--기존건수 X level 만큼 데이터가 나옴
SELECT *
FROM(
	SELECT empno, ename, job, sal
	FROM emp
	WHERE deptno = 10
)
,(
	SELECT LEVEL
	FROM dual
	CONNECT BY level <= 3
);
--  EMPNO ENAME       JOB             SAL  LEVEL
--------- ----------- ------------ ------ ------
--   7782 CLARK       MANAGER        2450      1
--   7839 KING        PRESIDENT      5000      1
--   7934 MILLER      CLERK          1300      1
--   7782 CLARK       MANAGER        2450      2
--   7839 KING        PRESIDENT      5000      2
--   7934 MILLER      CLERK          1300      2
--   7782 CLARK       MANAGER        2450      3
--   7839 KING        PRESIDENT      5000      3
--   7934 MILLER      CLERK          1300      3

--EQUI_JOIN: 등가조인(=)
--조인으로 선행 테이블에서 데이터를 가져온 후 조건절을 검사해서 동일 조건을 가진 데이터를
--후행테이블에서 꺼내 오는 방법

--emp테이블과 dept테이블을 조회하여 직원번호, 직원이름, 부서번호, 부서이름을 출력하시오.

--ORACLE
SELECT empno, ename, t1.deptno, t2.dname
FROM emp t1, dept t2
WHERE t1.deptno = t2.deptno;

--ANSI
SELECT empno, ename, t1.deptno, t2.dname
FROM emp t1 JOIN dept t2
ON t1.deptno = t2.deptno;
--  EMPNO ENAME          DEPTNO DNAME
--------- ---------- ---------- -------------
--   7839 KING               10 ACCOUNTING
--   7782 CLARK              10 ACCOUNTING
--   7934 MILLER             10 ACCOUNTING
--   7902 FORD               20 RESEARCH
--   7369 SMITH              20 RESEARCH
--   7566 JONES              20 RESEARCH
--   7900 JAMES              30 SALES
--   7844 TURNER             30 SALES
--   7654 MARTIN             30 SALES
--   7521 WARD               30 SALES
--   7499 ALLEN              30 SALES
--   7698 BLAKE              30 SALES


--학생테이블과 교수테이블을 조인, 학생이름과 교수이름을 조인
--ORACLE
SELECT t1.name"student", t2.name"professor"
FROM student t1, professor t2
WHERE t1.profno = t2.profno;

--ANSI
SELECT t1.name"student", t2.name"professor"
FROM student t1 JOIN professor t2
ON t1.profno = t2.profno;
--student             professor
--------------------  -------------------
--James Seo           Audie Murphy
--Billy Crystal       Angela Bassett
--Richard Dreyfus     Angela Bassett
--Tim Robbins         Winona Ryder
--Rene Russo          Winona Ryder
--Nicholas Cage       Michelle Pfeiffer
--Sandra Bullock      Julia Roberts
--Demi Moore          Meryl Streep
--Macaulay Culkin     Meryl Streep
--Wesley Snipes       Susan Sarandon
--Danny Glover        Nicole Kidman
--Micheal Keaton      Nicole Kidman
--Steve Martin        Nicole Kidman
--Daniel Day-Lewis    Jodie Foster
--Bill Murray         Jodie Foster

--ORACLE
--학생이름, 학과이름, 학생의 지도교수 이름
COL "student_name" FOR A20
COL "professor_name" FOR A20
COL "dept_name"  FOR A35
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t3.dname"dept_name" 
FROM student t1, professor t2, department t3
WHERE t1.profno = t2.profno
AND t1.deptno1 = t3.deptno
;
--student_name         professor_name       dept_name
---------------------- -------------------- -----------------------------------
--James Seo            Audie Murphy         Computer Engineering
--Billy Crystal        Angela Bassett       Computer Engineering
--Richard Dreyfus      Angela Bassett       Computer Engineering
--Tim Robbins          Winona Ryder         Multimedia Engineering
--Rene Russo           Winona Ryder         Multimedia Engineering
--Nicholas Cage        Michelle Pfeiffer    Multimedia Engineering
--Sandra Bullock       Julia Roberts        Software Engineering
--Macaulay Culkin      Meryl Streep         Electronic Engineering
--Demi Moore           Meryl Streep         Electronic Engineering
--Wesley Snipes        Susan Sarandon       Electronic Engineering
--Micheal Keaton       Nicole Kidman        Mechanical Engineering
--Danny Glover         Nicole Kidman        Mechanical Engineering
--Steve Martin         Nicole Kidman        Electronic Engineering
--Bill Murray          Jodie Foster         Library and Information science
--Daniel Day-Lewis     Jodie Foster         Library and Information science

--ANSI
COL "student_name" FOR A20
COL "professor_name" FOR A20
COL "dept_name"  FOR A35
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t3.dname"dept_name" 
FROM student t1 JOIN professor t2
ON t1.profno = t2.profno
JOIN department t3
ON t1.deptno1 = t3.deptno
;

--ORACLE
--student테이블과 professor테이블을 조회하여 학생의 제1전공이 101번인 학생들의
--이름, 지도교수를 출력하세요.
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t1.deptno1 
FROM student t1, professor t2
WHERE t1.profno = t2.profno
AND t1.deptno1 = 101
;
--student_name         professor_name          DEPTNO1
---------------------- -------------------- ----------
--James Seo            Audie Murphy                101
--Richard Dreyfus      Angela Bassett              101
--Billy Crystal        Angela Bassett              101

--ANSI
SELECT t1.name"student_name"
	,t2.name"professor_name"
	,t1.deptno1 
FROM student t1 JOIN professor t2
ON t1.profno = t2.profno
WHERE t1.deptno1 = 101
;

--ORACLE
--NON_EQUI_JOIN: 비등가 조인
--CUSTOMER 테이블과, GIFT테이블을 조회하여 고객별로 마일리지 포인트를 조회하여,
--마일리지별 받을 수 있는 상품을 조회하여라.
COL "CUSTOMER_NAME" FOR A20
COL "GIFT_NAME" FOR A20
SELECT t1.gname"CUSTOMER_NAME", t1.point"POINT", t2.gname"GIFT_NAME"
FROM customer t1, gift t2
WHERE t1.point BETWEEN t2.g_start AND t2.g_end
;

--ANSI
COL "CUSTOMER_NAME" FOR A20
COL "GIFT_NAME" FOR A20
SELECT t1.gname"CUSTOMER_NAME", t1.point"POINT", t2.gname"GIFT_NAME"
FROM customer t1 JOIN gift t2
ON t1.point BETWEEN t2.g_start AND t2.g_end
--ON t1.point >= t2.g_start 
--AND t1.point <= t2.g_end
;

--ORACLE
--학생테이블과 SCORE테이블, HAKJUM테이블을 조회하여 학생이름, 점수, 학점을 출력하세요

--SCORE     TYPE    NULL     --HAKJUM    TYPE    NULL
--STUDNO    NUMBER  YES      --GRADE     CHAR(3) YES
--TOTAL     NUMBER  YES      --MIN_POINT NUMBER  YES
                             --MAX_POINT NUMBER  YES




COL "STUDENT_NAEM" FOR A20
SELECT t3.name"STUDENT_NAEM", t1.total"SCORE", t2.grade"GRADE"
FROM score t1, hakjum t2, student t3
WHERE t1.total BETWEEN t2.min_point AND t2.max_point
AND t1.studno = t3.studno
;
--STUDENT_NAEM              SCORE GRADE
---------------------- ---------- ------
--James Seo                    97 A+
--Macaulay Culkin              95 A0
--Billy Crystal                92 A0
--Danny Devito                 91 A0
--Richard Dreyfus              89 B+
--Sean Connery                 88 B+
--Danny Glover                 88 B+
--Nicholas Cage                87 B+
--Daniel Day-Lewis             87 B+
--Wesley Snipes                86 B+
--Anthony Hopkins              84 B0
--Sandra Bullock               83 B0
--Charlie Sheen                83 B0
--Steve Martin                 82 B0
--Christian Slater             82 B0
--Micheal Keaton               81 B0
--Bill Murray                  79 C+
--Rene Russo                   78 C+
--Tim Robbins                  77 C+
--Demi Moore                   62 D

--ANSI
COL "STUDENT_NAEM" FOR A20
SELECT t3.name"STUDENT_NAEM", t1.total"SCORE", t2.grade"GRADE"
FROM score t1 JOIN hakjum t2
ON t1.total BETWEEN t2.min_point AND t2.max_point
JOIN student t3
ON t1.studno = t3.studno
;

--OUTER_JOIN
--한쪽 테이블에는 데이터가 있고 다른쪽에는 데이터가 없는 경우
--데이터가 있는 쪽에 테이블의 내용을 모두 출력

--유형1. 지도교수가 결정되지 않은 학생의 명단도 출력

--STU_NAME                   PROF_NAME
---------------------------- ---------------------
--James Seo                  Audie Murphy
--Richard Dreyfus            Angela Bassett
--Billy Crystal              Angela Bassett
--Tim Robbins                Winona Ryder
--Rene Russo                 Winona Ryder
--Nicholas Cage              Michelle Pfeiffer
--Sandra Bullock             Julia Roberts
--Macaulay Culkin            Meryl Streep
--Demi Moore                 Meryl Streep
--Wesley Snipes              Susan Sarandon
--Steve Martin               Nicole Kidman
--Micheal Keaton             Nicole Kidman
--Danny Glover               Nicole Kidman
--Daniel Day-Lewis           Jodie Foster
--Bill Murray                Jodie Foster
--Anthony Hopkins
--Charlie Sheen
--Christian Slater
--Sean Connery
--Danny Devito

--ORACLE
--데이터가 없는 쪽 조인조건에 (+)
SELECT t1.name"STU_NAME"
	,t2.name"PROF_NAME"
FROM student t1, professor t2
WHERE t1.profno = t2.profno(+);

--ANSI
--LEFT OUTER JOIN: 데이터가 있는 쪽이 왼쪽
--RIGHT OUTER JOIN: 데이터가 있는 쪽이 오른쪽
SELECT t1.name"STU_NAME"
	,t2.name"PROF_NAME"
--FROM student t1 LEFT OUTER JOIN professor t2
FROM professor t2 RIGHT OUTER JOIN student t1
ON t1.profno = t2.profno;

--유형2. 지도학생이 결정되지 않은 교수의 명단도 출력

--STU_NAME                                                     PROF_NAME
-------------------------------------------------------------- -------------------
--James Seo                                                    Audie Murphy
--Billy Crystal                                                Angela Bassett
--Richard Dreyfus                                              Angela Bassett
--                                                             Jessica Lange
--Tim Robbins                                                  Winona Ryder
--Rene Russo                                                   Winona Ryder
--Nicholas Cage                                                Michelle Pfeiffer
--                                                             Whoopi Goldberg
--                                                             Emma Thompson
--Sandra Bullock                                               Julia Roberts
--                                                             Sharon Stone
--Demi Moore                                                   Meryl Streep
--Macaulay Culkin                                              Meryl Streep
--Wesley Snipes                                                Susan Sarandon
--Danny Glover                                                 Nicole Kidman
--Micheal Keaton                                               Nicole Kidman
--Steve Martin                                                 Nicole Kidman
--                                                             Holly Hunter
--                                                             Meg Ryan
--                                                             Andie Macdowell
--Daniel Day-Lewis                                             Jodie Foster
--Bill Murray                                                  Jodie Foster

--ORACLE
SELECT t1.name"STU_NAME"
	,t2.name"PROF_NAME"
FROM student t1, professor t2
WHERE t1.profno(+) = t2.profno;

--ANSI
SELECT t1.name"STU_NAME"
	,t2.name"PROF_NAME"
--FROM student t1 LEFT OUTER JOIN professor t2
FROM student t1 RIGHT OUTER JOIN professor t2
ON t1.profno = t2.profno;

--유형3. 지도학생이 결정되지 않은 교수들, 지도교수가 결정되지 않은 학생들의 이름 전부 출력

--STU_NAME                 PROF_NAME
-------------------------- -------------------------
--Anthony Hopkins
--Bill Murray              Jodie Foster
--Billy Crystal            Angela Bassett
--Charlie Sheen
--Christian Slater
--Daniel Day-Lewis         Jodie Foster
--Danny Devito
--Danny Glover             Nicole Kidman
--Demi Moore               Meryl Streep
--James Seo                Audie Murphy
--Macaulay Culkin          Meryl Streep
--Micheal Keaton           Nicole Kidman
--Nicholas Cage            Michelle Pfeiffer
--Rene Russo               Winona Ryder
--Richard Dreyfus          Angela Bassett
--Sandra Bullock           Julia Roberts
--Sean Connery
--Steve Martin             Nicole Kidman
--Tim Robbins              Winona Ryder
--Wesley Snipes            Susan Sarandon
--                         Andie Macdowell
--                         Emma Thompson
--                         Holly Hunter
--                         Jessica Lange
--                         Meg Ryan
--                         Sharon Stone
--                         Whoopi Goldberg

--ORACLE
SELECT t1.name"STU_NAME"
	,t2.name"PROF_NAME"
FROM student t1, professor t2
WHERE t1.profno = t2.profno(+)
UNION
SELECT t1.name"STU_NAME"
	,t2.name"PROF_NAME"
FROM student t1, professor t2
WHERE t1.profno(+) = t2.profno;

--ANSI
SELECT t1.name"STU_NAME"
	,t2.name"PROF_NAME"
--FROM student t1 LEFT OUTER JOIN professor t2
FROM student t1 FULL OUTER JOIN professor t2
ON t1.profno = t2.profno;

--ORACLE OUTER JOIN 주의사항
--1.OUTER JOIN이 되는 컬럼들에 대해서는 전부 아우터 조인 연산자(+)를 붙여햐 한다.
--하나라도 누락이 되면 일반 조인과 동일한 결과를 출력하게 된다.

--ORACLE
SELECT t1.deptno
	,t2.dname
	,t1.empno
	,t1.ename
	,t1.sal
FROM emp t1, dept t2
WHERE t1.deptno(+) = t2.deptno
AND t1.deptno(+) = 20;
--    DEPTNO DNAME                             EMPNO        SAL
------------ ---------------------------- ---------- ----------
--           ACCOUNTING
--        20 RESEARCH                           7369        800
--        20 RESEARCH                           7902       3000
--        20 RESEARCH                           7566       2975
--           SALES
--           OPERATIONS

--ANSI
--직업이 CLERK인 사원정보(사원번호, 이름ㅁ, 직업)을 출력하고 그 중에 'CHICAGO'에 위치한 부서에
--소속된 사원의 부서정보를 출력하세요
--emp, dept
--ANSI OUTER JOIN에서 WHERE절에 기술한 조건은 기준 테이블의
--집합수를 결정하고 ON절에 기술한 조건은 기준 집합 중에 아우터 조인 대상이 되는
--집합을 말하는 것으로 전체 집합에는 아무러 영향을 주지 않는다.
SELECT t1.empno, t1.ename, t1.job, t2.deptno, t2.dname, t2.loc
FROM emp t1 LEFT OUTER JOIN dept t2
ON(
	t1.deptno = t2.deptno
	AND t2.loc = 'CHICAGO'
	AND t1.job = 'CLERK'
)
--WHERE t1.job = 'CLERK'
;
--     EMPNO ENAME       JOB             DEPTNO DNAME   LOC
------------ ----------- ----------- ---------- ------- ---------
--      7900 JAMES       CLERK               30 SALES   CHICAGO
--      2000 Cat
--      1000 Tiger
--      7369 SMITH       CLERK
--      7782 CLARK       MANAGER
--      7844 TURNER      SALESMAN
--      7654 MARTIN      SALESMAN
--      7521 WARD        SALESMAN
--      7499 ALLEN       SALESMAN
--      7566 JONES       MANAGER
--      7934 MILLER      CLERK
--      7902 FORD        ANALYST
--      7839 KING        PRESIDENT
--      7698 BLAKE       MANAGER

--SELF_JOIN: 한 개의 테이블을 가지고 JOIN
--사원과 해당 사원의 매니저의 이름을 출력

--ENAME                ENAME
---------------------- ------------
--FORD                 JONES
--JAMES                BLAKE
--TURNER               BLAKE
--WARD                 BLAKE
--MARTIN               BLAKE
--ALLEN                BLAKE
--MILLER               CLARK
--CLARK                KING
--JONES                KING
--BLAKE                KING
--SMITH                FORD

--ORACLE
SELECT t1.ename
	,t2.ename
FROM emp t1, emp t2
WHERE t1.mgr = t2.empno
;

--ANSI
SELECT t1.ename
	,t2.ename
FROM emp t1 INNER JOIN emp t2
ON t1.mgr = t2.empno
;







