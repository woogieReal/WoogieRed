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







