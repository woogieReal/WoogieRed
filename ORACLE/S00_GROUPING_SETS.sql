--GROUPING_SETS: 그룹핑 조건이 여러개일 경우 유용하게 사용가능
--GROUPING SETS(expr1,expr2,expr3......)
--학년별로 학생들의 인원수, 학과별로 인원수를 한 테이블로 출력

--UNION ALL로 GROUPING SETS 원리구현
SELECT grade, COUNT(*)
FROM student
GROUP BY grade
UNION ALL
SELECT deptno1, COUNT(*)
FROM student
GROUP BY deptno1;
--     GRADE   COUNT(*)
------------ ----------
--         1          5
--         2          5
--         4          5
--         3          5
--       102          4
--       201          6
--       301          2
--       101          4
--       202          2
--       103          2

--학년별로 학생들의 인원수, 학과별로 인원수를 한 테이블로 출력
SELECT grade, deptno1, COUNT(*)
FROM student
GROUP BY GROUPING SETS(grade, deptno1);
--     GRADE    DEPTNO1   COUNT(*)
------------ ---------- ----------
--                  102          4
--                  201          6
--                  301          2
--                  101          4
--                  202          2
--                  103          2
--         1                     5
--         2                     5
--         4                     5
--         3                     5

--학년별로 인원수, 키 평균, 몸무게 평균을 구함
--이 경우 GROUP이 하나이기 때문에 GROUP BY로 가능
SELECT grade
	,COUNT(*)"NUMBER"
	,ROUND(AVG(NVL(height,0)))"AVG_HEIGHT"
	,ROUND(AVG(NVL(weight,0)))"AVG_WEIGHT"
FROM student
GROUP BY grade;
--     GRADE     NUMBER AVG_HEIGHT AVG_WEIGHT
------------ ---------- ---------- ----------
--         1          5        170         62
--         2          5        176         67
--         4          5        176         68
--         3          5        167         51

--학년별 + 학과별로 인원수, 키 평균, 몸무게 평균을 구할경우
--GROUPING SETS을 이용하면 한 테이블에 간단하게 출력가능
SELECT grade, deptno1
	,COUNT(*)"NUMBER"
	,ROUND(AVG(NVL(height,0)))"AVG_HEIGHT"
	,ROUND(AVG(NVL(weight,0)))"AVG_WEIGHT"
FROM student
GROUP BY GROUPING SETS(grade, deptno1);
--     GRADE    DEPTNO1     NUMBER AVG_HEIGHT AVG_WEIGHT
------------ ---------- ---------- ---------- ----------
--                  102          4        171         64
--                  201          6        173         67
--                  301          2        172         60
--                  101          4        172         60
--                  202          2        180         63
--                  103          2        166         52
--         1                     5        170         62
--         2                     5        176         67
--         4                     5        176         68
--         3                     5        167         51


