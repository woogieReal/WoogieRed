--
SELECT *
FROM tb_pivot;
--YEAR          MONTH
---------- ----------
--2021              1
--2021              2
--2021              3
--2021              4
--2021              5
--2021              6
--2021              7
--2021              8
--2021              9
--2021             10
--2021             11
--2021             12

COL "M01" FOR 99
COL "M02" FOR 99
COL "M03" FOR 99
COL "M04" FOR 99
COL "M05" FOR 99
COL "M06" FOR 99
COL "M07" FOR 99
COL "M08" FOR 99
COL "M09" FOR 99
COL "M10" FOR 99
COL "M11" FOR 99
COL "M12" FOR 99
SELECT year
	  ,MAX(DECODE(month,1,month,NULL))  "M01"
	  ,MAX(DECODE(month,2,month,NULL))  "M02"
	  ,MAX(DECODE(month,3,month,NULL))  "M03"
	  ,MAX(DECODE(month,4,month,NULL))  "M04"
	  ,MAX(DECODE(month,5,month,NULL))  "M05"
	  ,MAX(DECODE(month,6,month,NULL))  "M06"
	  ,MAX(DECODE(month,7,month,NULL))  "M07"
	  ,MAX(DECODE(month,8,month,NULL))  "M08"
	  ,MAX(DECODE(month,9,month,NULL))  "M09"
	  ,MAX(DECODE(month,10,month,NULL)) "M10"
	  ,MAX(DECODE(month,11,month,NULL)) "M11"
	  ,MAX(DECODE(month,12,month,NULL)) "M12"
FROM tb_pivot
GROUP BY year;
--YEAR     M01 M02 M03 M04 M05 M06 M07 M08 M09 M10 M11 M12
---------- --- --- --- --- --- --- --- --- --- --- --- ---
--2021       1   2   3   4   5   6   7   8   9  10  11  12

--SELECT * FROM (SELECT year,month FROM tb_pivot)
--PIVOT(
--	PIVOT절: 그룹함수 적용된 컬럼 MAX(month)
--	PIVOT FOR절: 피봇에 기준이 되는 컬럼 FOR month
--	IN(): PIVOT FOR에서 정의한 컬럼 필터링 1 AS M01
--);

SELECT * FROM (SELECT year,month FROM tb_pivot)
PIVOT(
	MAX(month) FOR month IN(
						 1 AS  "M01"
		                ,2 AS  "M02"
		                ,3 AS  "M03"
		                ,4 AS  "M04"
		                ,5 AS  "M05"
		                ,6 AS  "M06"
		                ,7 AS  "M07"
		                ,8 AS  "M08"
		                ,9 AS  "M09"
		                ,10 AS "M10"
		                ,11 AS "M11"
		                ,12 AS "M12"
	)
);

--DESC cal
--WEEKNO VARCHAR2(1)
--DAY VARCHAR2(5)
--DAYNO VARCHAR2(2)
COL weekno FOR A6
COL dayno FOR A5
SELECT weekno, day, dayno
FROM cal;
--WEEKNO DAY        DAYNO
-------- ---------- -----
--1      SUN        1
--1      MON        2
--1      TUE        3
--1      WED        4
--1      THU        5
--1      FRI        6
--1      SAT        7
--2      SUN        8
--2      MON        9
--2      TUE        10
--2      WED        11
--2      THU        12
--2      FRI        13
--2      SAT        14
--3      SUN        15
--3      MON        16
--3      TUE        17
--3      WED        18
--3      THU        19
--3      FRI        20
--3      SAT        21
--4      SUN        22
--4      MON        23
--4      TUE        24
--4      WED        25
--4      THU        26
--4      FRI        27
--4      SAT        28
--5      SUN        29
--5      MON        30
--5      TUE        31

--SELECT ASCII('1')
--	  ,ASCII('8')
--	  ,ASCII('15')
--	  ,ASCII('22')
--	  ,ASCII('29')
--FROM dual;
--문자 첫자만
--ASCII('1') ASCII('8') ASCII('15') ASCII('22') ASCII('29')
------------ ---------- ----------- ----------- -----------
--        49         56          49          50          50

SELECT DECODE(day,'SUN',dayno,NULL)"SUN"
	  ,DECODE(day,'MON',dayno,NULL)"MON"
	  ,DECODE(day,'TUE',dayno,NULL)"TUE"
	  ,DECODE(day,'WED',dayno,NULL)"WED"
	  ,DECODE(day,'THU',dayno,NULL)"THU"
	  ,DECODE(day,'FRI',dayno,NULL)"FRI"
	  ,DECODE(day,'SAT',dayno,NULL)"SAT"
FROM cal;
--SUN  MON  TUE  WED  THU  FRI  SAT
------ ---- ---- ---- ---- ---- ----
--1
--     2
--          3
--               4
--                    5
--                         6
--                              7
--8
--     9
--          10
--               11
--                    12
--                         13
--                              14
--15
--     16
--          17
--               18
--                    19
--                         20
--                              21
--22
--     23
--          24
--               25
--                    26
--                         27
--                              28
--29
--     30
--          31

SELECT MAX(DECODE(day,'SUN',dayno,NULL))"SUN"
	  ,MAX(DECODE(day,'MON',dayno,NULL))"MON"
	  ,MAX(DECODE(day,'TUE',dayno,NULL))"TUE"
	  ,MAX(DECODE(day,'WED',dayno,NULL))"WED"
	  ,MAX(DECODE(day,'THU',dayno,NULL))"THU"
	  ,MAX(DECODE(day,'FRI',dayno,NULL))"FRI"
	  ,MAX(DECODE(day,'SAT',dayno,NULL))"SAT"
FROM cal
GROUP BY weekno
ORDER BY weekno;
--SUN  MON  TUE  WED  THU  FRI  SAT
------ ---- ---- ---- ---- ---- ----
--1    2    3    4    5    6    7
--8    9    10   11   12   13   14
--15   16   17   18   19   20   21
--22   23   24   25   26   27   28
--29   30   31

SELECT * FROM(SELECT weekno"Wn",day,dayno FROM cal)
PIVOT(
	MAX(dayno) FOR day IN(
		 'SUN' AS "토"
		,'MON' AS "MON"
		,'TUE' AS "TUE"
		,'WED' AS "WED"
		,'THU' AS "THU"
		,'FRI' AS "FRI"
		,'SAT' AS "일"
	)
)
ORDER BY "Wn";
--Wn 토   MON  TUE  WED  THU  FRI  일
---- ---- ---- ---- ---- ---- ---- ----
--1  1    2    3    4    5    6    7
--2  8    9    10   11   12   13   14
--3  15   16   17   18   19   20   21
--4  22   23   24   25   26   27   28
--5  29   30   31

--JOB
--------------------
--CLERK
--SALESMAN
--PRESIDENT
--MANAGER
--ANALYST

COL "CLERK"     FOR 999999
COL "SALESMAN"  FOR 999999
COL "PRESIDENT" FOR 999999
COL "MANAGER"   FOR 999999
COL "ANALYST"   FOR 999999
SELECT deptno
	  ,COUNT(DECODE(job,'CLERK','1')    )"CLERK"
	  ,COUNT(DECODE(job,'SALESMAN','1') )"SALESMAN"
	  ,COUNT(DECODE(job,'PRESIDENT','1'))"PRESIDENT"
	  ,COUNT(DECODE(job,'MANAGER','1')  )"MANAGER"
	  ,COUNT(DECODE(job,'ANALYST','1')  )"ANALYST"
FROM emp
GROUP BY deptno
ORDER BY deptno
;

SELECT * FROM(SELECT deptno,job,empno FROM emp)
PIVOT(
	COUNT(empno) FOR job IN(
		 'CLERK'     AS "CLERK"
		,'SALESMAN'  AS "SALESMAN"
		,'PRESIDENT' AS "PRESIDENT"
		,'MANAGER'   AS "MANAGER"
		,'ANALYST'   AS "ANALYST"
	)
)
ORDER BY deptno;
--    DEPTNO   CLERK SALESMAN PRESIDENT MANAGER ANALYST
------------ ------- -------- --------- ------- -------
--        10       1        0         1       1       0
--        20       1        0         0       1       1
--        30       1        4         0       1       0

SELECT * FROM(SELECT deptno,job,empno,sal FROM emp)
PIVOT(
	COUNT(empno) AS CNT,
	SUM(sal) AS sum FOR job IN(
		 'CLERK'     AS "CLERK"
		,'SALESMAN'  AS "SALESMAN"
		,'PRESIDENT' AS "PRESIDENT"
		,'MANAGER'   AS "MANAGER"
		,'ANALYST'   AS "ANALYST"
	)
)
ORDER BY deptno;
--    DEPTNO  CLERK_CNT  CLERK_SUM SALESMAN_CNT SALESMAN_SUM PRESIDENT_CNT PRESIDENT_SUM MANAGER_CNT MANAGER_SUM ANALYST_CNT ANALYST_SUM
------------ ---------- ---------- ------------ ------------ ------------- ------------- ----------- ----------- ----------- -----------
--        10          1       1300            0                          1          5000           1        2450           0
--        20          1        800            0                          0                         1        2975           1        3000
--        30          1        950            4         5600             0                         1        2850           0


SELECT * FROM(SELECT weekno"Wn",day,dayno FROM cal)
PIVOT(
	MAX(dayno) FOR day IN(
		 'MON' AS "MON"
		,'TUE' AS "TUE"
		,'WED' AS "WED"
		,'THU' AS "THU"
		,'FRI' AS "FRI"
	)
)
ORDER BY "Wn";
--Wn MON  TUE  WED  THU  FRI
---- ---- ---- ---- ---- ----
--1  2    3    4    5    6
--2  9    10   11   12   13
--3  16   17   18   19   20
--4  23   24   25   26   27
--5  30   31

SELECT * FROM(SELECT weekno"Wn",day,dayno FROM cal)
PIVOT(
	MAX(dayno) FOR day IN(
		 NULL AS "SUN"
		,'MON' AS "MON"
		,'TUE' AS "TUE"
		,'WED' AS "WED"
		,'THU' AS "THU"
		,'FRI' AS "FRI"
		,NULL AS "SAT"
	)
)
ORDER BY "Wn";
--Wn SUN  MON  TUE  WED  THU  FRI  SAT
---- ---- ---- ---- ---- ---- ---- ----
--1       2    3    4    5    6
--2       9    10   11   12   13
--3       16   17   18   19   20
--4       23   24   25   26   27
--5       30   31





