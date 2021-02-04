--COUNT:입력데이터의 총 건수 출력
--복수행 함수에 *를 사용하면 NULL을 포함
--복수행 함수에 이름을 쓰면 NULL을 포함하지 않음
SELECT COUNT(*), COUNT(comm)
FROM emp;
--  COUNT(*) COUNT(COMM)
------------ -----------
--        12           4

--SUM:입력데이터의 합계
SELECT SUM(comm)"SUM_comm"
	,COUNT(comm)"COUNT_comm"
FROM emp;
--  SUM_comm COUNT_comm
------------ ----------
--      2200          4

--AVG: 입력데이터의 평균
--전체인원에 대한 평균을 구하기 위해서는 
SELECT AVG(comm)"WRONG"
	,AVG(NVL(comm,0))"CORRECT"
	,ROUND(AVG(NVL(comm,0)),2)"ROUND"
FROM emp;
--     WRONG    CORRECT      ROUND
------------ ---------- ----------
--       550 183.333333     183.33

--MAX | MIN: 입력데이터의 최대값&최소값
--내부적으로 ORDER BY를 돌려서 값을 구함
SELECT MAX(sal),MIN(sal)
FROM emp;
--  MAX(SAL)   MIN(SAL)
------------ ----------
--      5000        800

--VARIANCE: 입력데이터의 분산
--분산이란 평균에 대한 편차제곱의 평균을 구한 것이다.
--STDDEV: 입력데이터의 표준편차
--표준편차란 분산의 양의 제곱근으로 정의된다.
SELECT VARIANCE(sal),STDDEV(sal),AVG(NVL(sal,0))
FROM emp;
--VARIANCE(SAL) STDDEV(SAL) AVG(NVL(SAL,0))
--------------- ----------- ---------------
--   1488347.54   1219.9785      2077.08333

--GROUP_BY: 특정조건으로 세부적인 그룹을 지정
--원리: GROUP BY 뒤에오는 컬럼값을 기준으로 먼저 데이터를 모아놓고,
--SELECT절에 있는 그룹함수를 적용.

--GROUP BY 주의사항
--SELECT절에 사용된 그룹함수 이외의 칼럼이나 표현식은 GROUP BY절에 사용되어야 한다.
--GROUP BY절에는 반드시 컬럼명이 사용되어야 한다.
SELECT deptno,AVG(NVL(sal,0))"AVERAGE"
FROM emp
GROUP BY deptno;
--    DEPTNO    AVERAGE
------------ ----------
--        30 1566.66667
--        20 2258.33333
--        10 2916.66667

--GROUP BY 2개
SELECT deptno, job, AVG(NVL(sal,0))"AVERAGE"
FROM emp
GROUP BY deptno, job
ORDER BY 1,3 DESC;
--    DEPTNO JOB                   AVERAGE
------------ ------------------ ----------
--        10 PRESIDENT                5000
--        10 MANAGER                  2450
--        10 CLERK                    1300
--        20 ANALYST                  3000
--        20 MANAGER                  2975
--        20 CLERK                     800
--        30 MANAGER                  2850
--        30 SALESMAN                 1400
--        30 CLERK                     950

--HAVING: 그룹핑한 조건으로 검색
SELECT deptno, AVG(NVL(sal,0))"AVERAGE"
FROM emp
GROUP BY deptno
HAVING AVG(NVL(sal,0)) > 2000
ORDER BY 1;
--    DEPTNO    AVERAGE
------------ ----------
--        10 2916.66667
--        20 2258.33333

--분석함수(ANALYTIC FUNCTION, WINDOW FUNCTION)
--ROLLUP: 입력데이터의 소계를 계산해 출력
--ROLLUP에 지정된 컬럼들은 소계의 기준이 되는 컬럼이다.
--N+1 LEVEL에 소계출력

--유형1. 부서와 직급별 평균급여 및 사원, 부서별 평군 급여와 사원 수, 전체 사원의 평균급여와 사원수 
--
--부서와 직급별 평균급여 및 사원 수
--UNION ALL
--부서별 평군 급여와 사원 수
--UNION ALL
--전체 사원의 평균급여와 사원수
--
--1. 부서와 직급별 평균급여 및 사원 수
SELECT deptno
	, job
	, AVG(NVL(sal,0))"AVERAGE"
	, COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno, job;
--    DEPTNO JOB                   AVERAGE THE NUMBER OF EMPLOYEE
------------ ------------------ ---------- ----------------------
--        20 CLERK                     800                      1
--        30 SALESMAN                 1400                      4
--        20 MANAGER                  2975                      1
--        30 CLERK                     950                      1
--        10 PRESIDENT                5000                      1
--        30 MANAGER                  2850                      1
--        10 CLERK                    1300                      1
--        10 MANAGER                  2450                      1
--        20 ANALYST                  3000                      1

--2. 부서별 평군 급여와 사원 수
SELECT deptno
	, NULL job
	, AVG(NVL(sal,0))"AVERAGE"
	, COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno;
--    DEPTNO J    AVERAGE THE NUMBER OF EMPLOYEE
------------ - ---------- ----------------------
--        30   1566.66667                      6
--        20   2258.33333                      3
--        10   2916.66667                      3

--3. 전체 사원의 평균급여와 사원수
SELECT NULL deptno
	, NULL job
	, AVG(NVL(sal,0))"AVERAGE"
	, COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
ORDER BY deptno, job;
--D J    AVERAGE THE NUMBER OF EMPLOYEE
--- - ---------- ----------------------
--    2077.08333                     12

--UNION ALL을 사용
SELECT deptno, job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno, job
UNION ALL
SELECT deptno, NULL job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL deptno, NULL job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
ORDER BY deptno, job;
--    DEPTNO JOB                   AVERAGE THE NUMBER OF EMPLOYEE
------------ ------------------ ---------- ----------------------
--        10 CLERK                    1300                      1
--        10 MANAGER                  2450                      1
--        10 PRESIDENT                5000                      1
--        10                    2916.66667                      3
--        20 ANALYST                  3000                      1
--        20 CLERK                     800                      1
--        20 MANAGER                  2975                      1
--        20                    2258.33333                      3
--        30 CLERK                     950                      1
--        30 MANAGER                  2850                      1
--        30 SALESMAN                 1400                      4
--        30                    1566.66667                      6
--                              2077.08333                     12

--ROLLUP을 사용
--deptno,job 두 개를 넣었으므로 3개의 LEVEL이 나온다.
--부서별 평균, 직급별 평균, 총 평균 3개
SELECT deptno, job, AVG(NVL(sal,0))"AVG", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY ROLLUP(deptno,job); 
--    DEPTNO JOB                       AVG THE NUMBER OF EMPLOYEE
------------ ------------------ ---------- ----------------------
--        10 CLERK                    1300                      1
--        10 MANAGER                  2450                      1
--        10 PRESIDENT                5000                      1
--        10                    2916.66667                      3
--        20 CLERK                     800                      1
--        20 ANALYST                  3000                      1
--        20 MANAGER                  2975                      1
--        20                    2258.33333                      3
--        30 CLERK                     950                      1
--        30 MANAGER                  2850                      1
--        30 SALESMAN                 1400                      4
--        30                    1566.66667                      6
--                              2077.08333                     12

--유형2. 
--직급별 합계
SELECT position
	, SUM(pay)
FROM professor
GROUP BY position;
--POSITION                                                       SUM(PAY)
-------------------------------------------------------------- ----------
--instructor                                                         1290
--assistant professor                                                1990
--a full professor                                                   2640

--부서번호를 포함한 직급별 합계
COL position FOR A20
SELECT deptno
	, position
	, COUNT(*)
	, SUM(pay)
FROM professor
GROUP BY position, ROLLUP(deptno);
--    DEPTNO POSITION               COUNT(*)   SUM(PAY)
------------ -------------------- ---------- ----------
--       101 instructor                    1        270
--       102 instructor                    1        250
--       103 instructor                    1        290
--       202 instructor                    1        260
--       301 instructor                    1        220
--           instructor                    5       1290
--       101 a full professor              1        550
--       102 a full professor              1        490
--       103 a full professor              1        530
--       201 a full professor              1        570
--       203 a full professor              1        500
--           a full professor              5       2640
--       101 assistant professor           1        380
--       102 assistant professor           1        350
--       103 assistant professor           1        330
--       201 assistant professor           1        330
--       202 assistant professor           1        310
--       301 assistant professor           1        290
--           assistant professor           6       1990

--직급을 포함한 부서별 합계
COL position FOR A20
SELECT deptno
	, position
	, COUNT(*)
	, SUM(pay)
FROM professor
GROUP BY deptno, ROLLUP(position);
--    DEPTNO POSITION               COUNT(*)   SUM(PAY)
------------ -------------------- ---------- ----------
--       101 instructor                    1        270
--       101 a full professor              1        550
--       101 assistant professor           1        380
--       101                               3       1200
--       102 instructor                    1        250
--       102 a full professor              1        490
--       102 assistant professor           1        350
--       102                               3       1090
--       103 instructor                    1        290
--       103 a full professor              1        530
--       103 assistant professor           1        330
--       103                               3       1150
--       201 a full professor              1        570
--       201 assistant professor           1        330
--       201                               2        900
--       202 instructor                    1        260
--       202 assistant professor           1        310
--       202                               2        570
--       203 a full professor              1        500
--       203                               1        500
--       301 instructor                    1        220
--       301 assistant professor           1        290
--       301                               2        510

--CUBE: 입력데이터의 소계 및 전체 총계를 계산
--GROUP BY CUBE(컬럼1, 컬럼2, ....)
--2^n LEVEL의 소계출력
--모든 경우에 대한 소계를 구하기 때문에 컬럼의 순서는 중요하지 않음

--부서별 평균급여와 사원수, 직급별 평균급여와 사원수, 부서와 직급별 평균급여와 사원수, 전체 평균 급여와 사원수
--1. 부서별 평균급여와 사원수
--UNION ALL
--2. 직급별 평균급여와 사원수
--UNION ALL
--3. 부서와 직급별 평균급여와 사원수
--UNION ALL
--4. 전체 평균 급여와 사원수
----> CUBE

--1. 부서별 평균급여와 사원수
SELECT deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno;
--    DEPTNO JOB                     AVERAGE   COUNT(*)
------------ -------------------- ---------- ----------
--        30                          1566.7          6
--        20                          2258.3          3
--        10                          2916.7          3

--2. 직급별 평균급여와 사원수
SELECT NULL deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY job;
--D JOB                   AVERAGE   COUNT(*)
--- ------------------ ---------- ----------
--  CLERK                  1016.7          3
--  SALESMAN                 1400          4
--  PRESIDENT                5000          1
--  MANAGER                2758.3          3
--  ANALYST                  3000          1

--3. 부서와 직급별 평균급여와 사원수
SELECT deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno,job;
--    DEPTNO JOB                   AVERAGE   COUNT(*)
------------ ------------------ ---------- ----------
--        20 CLERK                     800          1
--        30 SALESMAN                 1400          4
--        20 MANAGER                  2975          1
--        30 CLERK                     950          1
--        10 PRESIDENT                5000          1
--        30 MANAGER                  2850          1
--        10 CLERK                    1300          1
--        10 MANAGER                  2450          1
--        20 ANALYST                  3000          1

--4. 전체 평균 급여와 사원수
SELECT NULL deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp;
--D J    AVERAGE   COUNT(*)
--- - ---------- ----------
--        2077.1         12

--UNIONALL로 재현한 CUBE의 원리
SELECT deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY job
UNION ALL
SELECT deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno,job
UNION ALL
SELECT NULL deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
ORDER BY deptno, job;
--    DEPTNO JOB                   AVERAGE   COUNT(*)
------------ ------------------ ---------- ----------
--        30                        1566.7          6
--        20                        2258.3          3
--        10                        2916.7          3
--           CLERK                  1016.7          3
--           SALESMAN                 1400          4
--           PRESIDENT                5000          1
--           MANAGER                2758.3          3
--           ANALYST                  3000          1
--        20 CLERK                     800          1
--        30 SALESMAN                 1400          4
--        20 MANAGER                  2975          1
--        30 CLERK                     950          1
--        10 PRESIDENT                5000          1
--        30 MANAGER                  2850          1
--        10 CLERK                    1300          1
--        10 MANAGER                  2450          1
--        20 ANALYST                  3000          1
--                                  2077.1         12

--CUBE 사용예
SELECT deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;
--    DEPTNO JOB                   AVERAGE   COUNT(*)
------------ ------------------ ---------- ----------
--        10 CLERK                    1300          1
--        10 MANAGER                  2450          1
--        10 PRESIDENT                5000          1
--        10                        2916.7          3
--        20 ANALYST                  3000          1
--        20 CLERK                     800          1
--        20 MANAGER                  2975          1
--        20                        2258.3          3
--        30 CLERK                     950          1
--        30 MANAGER                  2850          1
--        30 SALESMAN                 1400          4
--        30                        1566.7          6
--           ANALYST                  3000          1
--           CLERK                  1016.7          3
--           MANAGER                2758.3          3
--           PRESIDENT                5000          1
--           SALESMAN                 1400          4
--                                  2077.1         12

--1.CTAS
--CREATE TABLE unpivot
--AS
--SELECT * FROM(SELECT deptno,job,empno FROM emp)
--PIVOT(
--	COUNT(empno) FOR job IN(
--		 'CLERK'     AS "CLERK"
--		,'SALESMAN'  AS "SALESMAN"
--		,'PRESIDENT' AS "PRESIDENT"
--		,'MANAGER'   AS "MANAGER"
--		,'ANALYST'   AS "ANALYST"
--	)
--)
--ORDER BY deptno;

--2.생성된 TABLE 데이터 확인
SELECT *
FROM unpivot;
--   DEPTNO      CLERK   SALESMAN  PRESIDENT    MANAGER    ANALYST
----------- ---------- ---------- ---------- ---------- ----------
--       10          1          0          1          1          0
--       20          1          0          0          1          1
--       30          1          4          0          1          0

--3. UNPIVOT
--PIVOT된 결과를 되돌리는 기능이 아닌 합쳐있는 것을 단지 풀어서 보여주는 역할
SELECT * FROM unpivot
UNPIVOT(
	empno FOR job IN(
		CLERK,SALESMAN,PRESIDENT,MANAGER,ANALYST
	)
);
--    DEPTNO JOB                     EMPNO
------------ ------------------ ----------
--        10 CLERK                       1
--        10 SALESMAN                    0
--        10 PRESIDENT                   1
--        10 MANAGER                     1
--        10 ANALYST                     0
--        20 CLERK                       1
--        20 SALESMAN                    0
--        20 PRESIDENT                   0
--        20 MANAGER                     1
--        20 ANALYST                     1
--        30 CLERK                       1
--        30 SALESMAN                    4
--        30 PRESIDENT                   0
--        30 MANAGER                     1
--        30 ANALYST                     0

--========================================================
--LAG: 이전 행 값을 가져올 때 사용
--LAG(출력할 컬럼명,OFFSET,기본출력값)
--OVER(Query_partition구문,ORDER BY 정렬할 컬럼)
SELECT ename
	,hiredate
	,sal
	,LAG(sal,1,0) OVER(ORDER BY hiredate)"LAG"
FROM emp;
--ENAME                HIREDATE        SAL        LAG
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800          0
--ALLEN                81/02/20       1600        800
--WARD                 81/02/22       1250       1600
--JONES                81/04/02       2975       1250
--BLAKE                81/05/01       2850       2975
--CLARK                81/06/09       2450       2850
--TURNER               81/09/08       1500       2450
--MARTIN               81/09/28       1250       1500
--KING                 81/11/17       5000       1250
--JAMES                81/12/03        950       5000
--FORD                 81/12/03       3000        950
--MILLER               82/01/23       1300       3000

--OFFSET은 3번째 전 것으로 설정
--기본값은 999
SELECT ename
	,hiredate
	,sal
	,LAG(sal,3,999) OVER(ORDER BY hiredate)"LAG"
FROM emp;
--ENAME                HIREDATE        SAL        LAG
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800        999
--ALLEN                81/02/20       1600        999
--WARD                 81/02/22       1250        999
--JONES                81/04/02       2975        800
--BLAKE                81/05/01       2850       1600
--CLARK                81/06/09       2450       1250
--TURNER               81/09/08       1500       2975
--MARTIN               81/09/28       1250       2850
--KING                 81/11/17       5000       2450
--JAMES                81/12/03        950       1500
--FORD                 81/12/03       3000       1250
--MILLER               82/01/23       1300       5000

--LEAD: 이후 행의 값을 가져옴
--LEAD(출력할 컬럼명,OFFSET,기본출력값)
--OVER(Query_partition구문,ORDER BY 정렬할 컬럼)
SELECT ename
	,hiredate
	,sal
	,LEAD(sal,1,0) OVER(ORDER BY hiredate)"LEAD"
FROM emp;
--ENAME                HIREDATE        SAL        LEAD
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800       1600
--ALLEN                81/02/20       1600       1250
--WARD                 81/02/22       1250       2975
--JONES                81/04/02       2975       2850
--BLAKE                81/05/01       2850       2450
--CLARK                81/06/09       2450       1500
--TURNER               81/09/08       1500       1250
--MARTIN               81/09/28       1250       5000
--KING                 81/11/17       5000        950
--JAMES                81/12/03        950       3000
--FORD                 81/12/03       3000       1300
--MILLER               82/01/23       1300          0

--OFFSET은 4번째 이후로 설정
--기본값은 5609
SELECT ename
	,hiredate
	,sal
	,LEAD(sal,4,5609) OVER(ORDER BY hiredate)"LEAD"
FROM emp;
--ENAME                HIREDATE        SAL       LEAD
---------------------- -------- ---------- ----------
--SMITH                80/12/17        800       2850
--ALLEN                81/02/20       1600       2450
--WARD                 81/02/22       1250       1500
--JONES                81/04/02       2975       1250
--BLAKE                81/05/01       2850       5000
--CLARK                81/06/09       2450        950
--TURNER               81/09/08       1500       3000
--MARTIN               81/09/28       1250       1300
--KING                 81/11/17       5000       5609
--JAMES                81/12/03        950       5609
--FORD                 81/12/03       3000       5609
--MILLER               82/01/23       1300       5609

--RANK: 특정데이터의 순위를 출력
--RANK(조건값) WITHIN GROUP (ORDER BY 조건값 컬럼명 [ASC | DESC] )
SELECT RANK('SMITH') WITHIN GROUP (ORDER BY ename)"RANK"
FROM emp
ORDER BY ename;
--      RANK
------------
--        10

--RANK_OVER: 전체데이터의 순위를 출력
--RANK() OVER (ORDER BY sal)
--ex.2위 3개 뒤에는 5위
SELECT empno,ename,sal
	,RANK() OVER(ORDER BY sal DESC)"RANK OVER"
FROM emp;
--     EMPNO ENAME                       SAL  RANK OVER
------------ -------------------- ---------- ----------
--      7839 KING                       5000          1
--      7902 FORD                       3000          2
--      7566 JONES                      2975          3
--      7698 BLAKE                      2850          4
--      7782 CLARK                      2450          5
--      7499 ALLEN                      1600          6
--      7844 TURNER                     1500          7
--      7934 MILLER                     1300          8
--      7654 MARTIN                     1250          9
--      7521 WARD                       1250          9
--      7900 JAMES                       950         11
--      7369 SMITH                       800         12

--특정부서의 월급순위를 출력
SELECT empno,ename,sal
	,RANK() OVER(ORDER BY sal DESC)"RANK OVER"
FROM emp
WHERE deptno = 10;
--     EMPNO ENAME                       SAL  RANK OVER
------------ -------------------- ---------- ----------
--      7839 KING                       5000          1
--      7782 CLARK                      2450          2
--      7934 MILLER                     1300          3

--모든 부서별로 월급순위를 출력
--PARTITION BY 사용
SELECT deptno,empno,ename,sal
	,RANK() OVER(PARTITION BY deptno ORDER BY sal DESC)"RANK OVER"
FROM emp;
--    DEPTNO      EMPNO ENAME                       SAL  RANK OVER
------------ ---------- -------------------- ---------- ----------
--        10       7839 KING                       5000          1
--        10       7782 CLARK                      2450          2
--        10       7934 MILLER                     1300          3
--        20       7902 FORD                       3000          1
--        20       7566 JONES                      2975          2
--        20       7369 SMITH                       800          3
--        30       7698 BLAKE                      2850          1
--        30       7499 ALLEN                      1600          2
--        30       7844 TURNER                     1500          3
--        30       7521 WARD                       1250          4
--        30       7654 MARTIN                     1250          4
--        30       7900 JAMES                       950          6

--DENSE_RANK
--순위 출력함수(ex.2위 3개 뒤에는 3위)
SELECT empno,ename,sal
	,DENSE_RANK() OVER(ORDER BY sal DESC)"DENSE_RANK"
FROM emp;
--     EMPNO ENAME                       SAL DENSE_RANK
------------ -------------------- ---------- ----------
--      7839 KING                       5000          1
--      7902 FORD                       3000          2
--      7566 JONES                      2975          3
--      7698 BLAKE                      2850          4
--      7782 CLARK                      2450          5
--      7499 ALLEN                      1600          6
--      7844 TURNER                     1500          7
--      7934 MILLER                     1300          8
--      7654 MARTIN                     1250          9
--      7521 WARD                       1250          9
--      7900 JAMES                       950         10
--      7369 SMITH                       800         11

--ROW_NUMBER: 순위출력
--RANK와 DENSE_RANK와 다르게 동일순위 없이 같은 값이라도 다른 순위를 부여
--동일 값이면 ROWID 순으로 순위부여(P405참고)
SELECT empno,ename,sal,ROWID
	,RANK() OVER (ORDER BY sal DESC)"RANK"
	,DENSE_RANK() OVER(ORDER BY sal DESC)"DENSE_RANK"
	,ROW_NUMBER() OVER(ORDER BY sal DESC)"ROW_NUMBER"
FROM emp;
-- EMPNO ENAME        SAL ROWID                 RANK DENSE_RANK ROW_NUMBER
-------- -------- ------- ------------------ ------- ---------- ----------
--  7839 KING        5000 AAAE6LAAEAAAAK+AAH       1          1          1
--  7902 FORD        3000 AAAE6LAAEAAAAK+AAK       2          2          2
--  7566 JONES       2975 AAAE6LAAEAAAAK+AAD       3          3          3
--  7698 BLAKE       2850 AAAE6LAAEAAAAK+AAF       4          4          4
--  7782 CLARK       2450 AAAE6LAAEAAAAK+AAG       5          5          5
--  7499 ALLEN       1600 AAAE6LAAEAAAAK+AAB       6          6          6
--  7844 TURNER      1500 AAAE6LAAEAAAAK+AAI       7          7          7
--  7934 MILLER      1300 AAAE6LAAEAAAAK+AAL       8          8          8
--  7654 MARTIN      1250 AAAE6LAAEAAAAK+AAE       9          9          9
--  7521 WARD        1250 AAAE6LAAEAAAAK+AAC       9          9         10
--  7900 JAMES        950 AAAE6LAAEAAAAK+AAJ      11         10         11
--  7369 SMITH        800 AAAE6LAAEAAAAK+AAA      12         11         12

--SUM() OVER: 누계 구하기
SELECT *
FROM panmae;
--P_DATE               P_CODE      P_QTY    P_TOTAL P_STORE
------------------ ---------- ---------- ---------- ----------
--20110101                100          3       2400 1000
--20110101                101          5       4500 1001
--20110101                102          2       2000 1003
--20110101                103          6       5400 1004
--20110102                102          2       2000 1000
--20110102                103          5       4500 1002
--20110102                104          3       2400 1002
--20110102                105          2       3000 1000
--20110103                100         10       8000 1004
--20110103                100          2       1600 1000
--20110103                100          3       2400 1001
--20110103                101          4       3600 1003
--20110104                100          2       1600 1002
--20110104                100          4       3200 1003
--20110104                100          5       4000 1004
--20110104                101          3       2700 1001
--20110104                101          4       3600 1002
--20110104                101          3       2700 1003
--20110104                102          4       4000 1001
--20110104                102          2       2000 1002
--20110104                103          2       1800 1003

SELECT P_DATE, P_CODE, P_QTY, P_TOTAL
	,SUM(P_TOTAL) OVER(PARTITION BY P_CODE ORDER BY P_TOTAL)"SUM()_OVER"
FROM panmae
WHERE P_STORE = 1000;
--P_DATE               P_CODE      P_QTY    P_TOTAL SUM()_OVER
------------------ ---------- ---------- ---------- ----------
--20110103                100          2       1600       1600
--20110101                100          3       2400       4000
--20110102                102          2       2000       2000
--20110102                105          2       3000       3000

SELECT P_DATE, P_STORE, P_CODE, P_QTY, P_TOTAL
	,SUM(P_TOTAL) OVER(PARTITION BY P_CODE,P_STORE ORDER BY P_TOTAL)"SUM()_OVER"
FROM panmae;
--P_DATE           P_STORE        P_CODE      P_QTY    P_TOTAL SUM()_OVER
------------------ ---------- ---------- ---------- ---------- ----------
--20110103         1000              100          2       1600       1600
--20110101         1000              100          3       2400       4000
--20110103         1001              100          3       2400       2400
--20110104         1002              100          2       1600       1600
--20110104         1003              100          4       3200       3200
--20110104         1004              100          5       4000       4000
--20110103         1004              100         10       8000      12000
--20110104         1001              101          3       2700       2700
--20110101         1001              101          5       4500       7200
--20110104         1002              101          4       3600       3600
--20110104         1003              101          3       2700       2700
--20110103         1003              101          4       3600       6300
--20110102         1000              102          2       2000       2000
--20110104         1001              102          4       4000       4000
--20110104         1002              102          2       2000       2000
--20110101         1003              102          2       2000       2000
--20110102         1002              103          5       4500       4500
--20110104         1003              103          2       1800       1800
--20110101         1004              103          6       5400       5400
--20110102         1002              104          3       2400       2400
--20110102         1000              105          2       3000       3000

--RATIO_TO_REPORT: 비율을 구하는 함수
--panmae 테이블에서 100번 제품의 판매내역과 각 판매점별 판매비중
SELECT P_STORE, P_TOTAL, P_QTY
	,SUM(P_QTY) OVER()"T_QTY"
	,SUM(P_TOTAL) OVER()"P_TOTAL"
	,ROUND(RATIO_TO_REPORT(SUM(P_QTY)) OVER()*100) "RATION_QTY"
FROM panmae
WHERE P_CODE = 100
GROUP BY P_STORE, P_TOTAL, P_QTY; 
--P_STORE       P_TOTAL      P_QTY      T_QTY    P_TOTAL RATION_QTY
------------ ---------- ---------- ---------- ---------- ----------
--1004             8000         10         29      23200         34
--1000             1600          2         29      23200          7
--1000             2400          3         29      23200         10
--1002             1600          2         29      23200          7
--1003             3200          4         29      23200         14
--1004             4000          5         29      23200         17
--1001             2400          3         29      23200         10





