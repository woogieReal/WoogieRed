--sqlplus scott/sist@211.238.142.124:1521/xe

--432p
--1
CREATE OR REPLACE VIEW v_prof_dept2
AS
SELECT t1.profno,
	t1.name,
	t2.dname
FROM professor t1, department t2
WHERE t1.deptno = t2.deptno
;
--View created.

--2
SELECT t2.dname,
	t1.MAX_HEIGHT,
	t1.MIN_HEIGHT
FROM(
	SELECT deptno1, MAX(height) MAX_HEIGHT, MIN(height) MIN_HEIGHT
	FROM student
	GROUP BY deptno1
)t1, department t2
WHERE t1.deptno1 = t2.deptno
;
--DNAME                             MAX_HEIGHT MIN_HEIGHT
----------------------------------- ---------- ----------
--Multimedia Engineering                   179        161
--Electronic Engineering                   177        166
--Library and Information science          184        160
--Computer Engineering                     182        162
--Mechanical Engineering                   182        177
--Software Engineering                     168        163

--3
SELECT t2.dname,
	t1.deptno1,
	t1.name,
	height
FROM(
	SELECT NVL(LAG(deptno1) OVER(order by deptno1, height DESC),999) ldeptno1, deptno1, name, height
	FROM student
)t1, department t2
WHERE t1.deptno1 != t1.ldeptno1
AND t1.deptno1 = t2.deptno
;
--DNAME                                   DEPTNO1 NAME                    HEIGHT
-------------------------------------- ---------- ------------------- ----------
--Computer Engineering                        101 Richard Dreyfus            182
--Multimedia Engineering                      102 Charlie Sheen              179
--Software Engineering                        103 Sandra Bullock             168
--Electronic Engineering                      201 Demi Moore                 177
--Mechanical Engineering                      202 Danny Glover               182
--Library and Information science             301 Daniel Day-Lewis           184

--4
SELECT *
FROM(
SELECT grade, name, height, AVG(height) over(PARTITION BY grade) AVG_HEIGHT
FROM student
)t1
WHERE t1.height > t1.AVG_HEIGHT
;

--     GRADE NAME                                                             HEIGHT AVG_HEIGHT
------------ ------------------------------------------------------------ ---------- ----------
--         1 Sean Connery                                                        175      170.4
--         1 Christian Slater                                                    173      170.4
--         1 Charlie Sheen                                                       179      170.4
--         2 Richard Dreyfus                                                     182      175.6
--         2 Daniel Day-Lewis                                                    184      175.6
--         3 Micheal Keaton                                                      177      166.6
--         3 Macaulay Culkin                                                     171      166.6
--         4 Demi Moore                                                          177      175.8
--         4 James Seo                                                           180      175.8
--         4 Danny Glover                                                        182      175.8

--5
SELECT ROWNUM Ranking, t1.*
FROM(
	SELECT name,
		pay
	FROM professor
	ORDER BY pay DESC
)t1
WHERE ROWNUM < 6
;

--6
SELECT t2.num, t2.profno, t2.name, t2.pay, 
	SUM(pay) OVER(PARTITION BY t2.gro) "SUM(PAY)",
	ROUND(AVG(pay) OVER(PARTITION BY t2.gro),1) "AVG(PAY)"
FROM(
	SELECT CEIL(t1.num/3) gro,
		t1.num num,
		t1.profno profno,
		t1.name name,
		t1.pay pay
	FROM(
		SELECT ROWNUM num, profno, name, pay
		FROM professor
		ORDER BY profno
	)t1
)t2
;




