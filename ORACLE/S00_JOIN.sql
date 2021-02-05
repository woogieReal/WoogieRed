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










