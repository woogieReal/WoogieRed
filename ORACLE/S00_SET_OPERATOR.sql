--집합연산자
--합집합 UNION(중복값제거와 정렬), UNION ALL(그냥 합침)
--교집합 INTERSECT
--차집합 MINUS + 정렬

--집합연산자 사용조건
--1.두 집합의 SELECT 절에 오는 컬럼수 동일
--2.두 집합의 SELECT 절에 오는 데이터타입 동일
--3.두 집합의 SELECT 절에 오는 컬럼명은 달라도 됨

--1.UNION -> 중복값제거와 정렬
--ORDER BY가 들어가 있기때문에 성능 많이 먹음
SELECT studno,name
FROM student
WHERE deptno1 = 101
UNION
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9411 James Seo
--      9511 Billy Crystal
--      9512 Nicholas Cage
--      9611 Richard Dreyfus
--      9711 Danny Devito

--2.UNION ALL -> 그냥합침
SELECT studno,name
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9411 James Seo
--      9511 Billy Crystal
--      9611 Richard Dreyfus
--      9711 Danny Devito
--      9411 James Seo
--      9512 Nicholas Cage

--3.INTERSECT -> 교집합
SELECT studno,name
FROM student
WHERE deptno1 = 101
INTERSECT
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9411 James Seo

--4.MINUS -> 차집합
SELECT studno,name
FROM student
WHERE deptno1 = 101
MINUS
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9511 Billy Crystal
--      9611 Richard Dreyfus
--      9711 Danny Devito