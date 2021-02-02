--SELECT deptno, job, ename, sal, hiredate
--FROM emp;
--    DEPTNO JOB                ENAME                       SAL HIREDATE
------------ ------------------ -------------------- ---------- --------
--        20 CLERK              SMITH                       800 80/12/17
--        30 SALESMAN           ALLEN                      1600 81/02/20
--        30 SALESMAN           WARD                       1250 81/02/22
--        20 MANAGER            JONES                      2975 81/04/02
--        30 SALESMAN           MARTIN                     1250 81/09/28
--        30 MANAGER            BLAKE                      2850 81/05/01
--        10 MANAGER            CLARK                      2450 81/06/09
--        10 PRESIDENT          KING                       5000 81/11/17
--        30 SALESMAN           TURNER                     1500 81/09/08
--        30 CLERK              JAMES                       950 81/12/03
--        20 ANALYST            FORD                       3000 81/12/03
--        10 CLERK              MILLER                     1300 82/01/23
--COL deptno FOR A3
--COL job FOR A15
SELECT deptno, job, ROUND(AVG(NVL(sal,0)))"AVG"
FROM emp
WHERE job != 'PRESIDENT'
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;
--    DEPTNO JOB                       AVG
------------ ------------------ ----------
--        10 CLERK                    1300
--        10 MANAGER                  2450
--        10                          1875
--        20 ANALYST                  3000
--        20 CLERK                     800
--        20 MANAGER                  2975
--        20                          2258
--        30 CLERK                     950
--        30 MANAGER                  2850
--        30 SALESMAN                 1400
--        30                          1567
--           ANALYST                  3000
--           CLERK                    1017
--           MANAGER                  2758
--           SALESMAN                 1400
--                                    1811



