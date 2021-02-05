--9번
SELECT deptno
	,ename
	,sal
	,SUM(sal) OVER()"TOTAL_SAL"
	,ROUND(RATIO_TO_REPORT(sal) OVER()*100,2)"%"
FROM emp
ORDER BY "%" DESC;
--    DEPTNO ENAME            SAL  TOTAL_SAL          %
------------ --------- ---------- ---------- ----------
--        10 KING            5000      24925      20.06
--        20 FORD            3000      24925      12.04
--        20 JONES           2975      24925      11.94
--        30 BLAKE           2850      24925      11.43
--        10 CLARK           2450      24925       9.83
--        30 ALLEN           1600      24925       6.42
--        30 TURNER          1500      24925       6.02
--        10 MILLER          1300      24925       5.22
--        30 MARTIN          1250      24925       5.02
--        30 WARD            1250      24925       5.02
--        30 JAMES            950      24925       3.81
--        20 SMITH            800      24925       3.21

SELECT deptno
	,ename
	,sal
	,SUM(sal) OVER(PARTITION BY deptno)"SUM_DEPT"
	,ROUND(RATIO_TO_REPORT(sal) OVER()*100,2)"%"
FROM emp
ORDER BY deptno, "SUM_DEPT" DESC;
--    DEPTNO ENAME                       SAL   SUM_DEPT          %
------------ -------------------- ---------- ---------- ----------
--        10 CLARK                      2450       8750       9.83
--        10 KING                       5000       8750      20.06
--        10 MILLER                     1300       8750       5.22
--        20 SMITH                       800       6775       3.21
--        20 FORD                       3000       6775      12.04
--        20 JONES                      2975       6775      11.94
--        30 JAMES                       950       9400       3.81
--        30 TURNER                     1500       9400       6.02
--        30 MARTIN                     1250       9400       5.02
--        30 WARD                       1250       9400       5.02
--        30 ALLEN                      1600       9400       6.42
--        30 BLAKE                      2850       9400      11.43

--11번
SELECT L_DATE,L_CODE,L_QTY,L_TOTAL
	,SUM(L_TOTAL) OVER(PARTITION BY L_STORE ORDER BY L_TOTAL)"CUMULATIVE_TOTAL"
FROM loan
WHERE L_STORE = 1000;
--L_DATE               L_CODE      L_QTY    L_TOTAL CUMULATIVE_TOTAL
------------------ ---------- ---------- ---------- ----------------
--20110103                100          2       1600             1600
--20110102                102          2       2000             3600
--20110101                100          3       2400             6000
--20110102                105          2       3000             9000

--12번
SELECT L_CODE, L_STORE, L_DATE, L_QTY, L_TOTAL
	,SUM(L_TOTAL) OVER(PARTITION BY L_CODE, L_STORE ORDER BY L_TOTAL)"CUMULATIVE_TOTAL"
FROM loan;
--    L_CODE L_STORE    L_DATE                L_QTY    L_TOTAL CUMULATIVE_TOTAL
------------ ---------- ---------------- ---------- ---------- ----------------
--       100 1000       20110103                  2       1600             1600
--       100 1000       20110101                  3       2400             4000
--       100 1001       20110103                  3       2400             2400
--       100 1002       20110104                  2       1600             1600
--       100 1003       20110104                  4       3200             3200
--       100 1004       20110104                  5       4000             4000
--       100 1004       20110103                 10       8000            12000
--       101 1001       20110104                  3       2700             2700
--       101 1001       20110101                  5       4500             7200
--       101 1002       20110104                  4       3600             3600
--       101 1003       20110104                  3       2700             2700
--       101 1003       20110103                  4       3600             6300
--       102 1000       20110102                  2       2000             2000
--       102 1001       20110104                  4       4000             4000
--       102 1002       20110104                  2       2000             2000
--       102 1003       20110101                  2       2000             2000
--       103 1002       20110102                  5       4500             4500
--       103 1003       20110104                  2       1800             1800
--       103 1004       20110101                  6       5400             5400
--       104 1002       20110102                  3       2400             2400
--       105 1000       20110102                  2       3000             3000

--L_DATE               L_CODE      L_QTY    L_TOTAL L_STORE
------------------ ---------- ---------- ---------- ----------
--20110101                100          3       2400 1000
--20110101                101          5       4500 1001
--20110101                102          2       2000 1003
--20110101                103          6       5400 1004
--20110102                102          2       2000 1000
--20110102                103          5       4500 1002

--13번
SELECT L_DATE, L_CODE, L_QTY, L_TOTAL
	,SUM(L_TOTAL) OVER(PARTITION BY L_CODE ORDER BY L_TOTAL)"CUMULATIVE_TOTAL"
FROM loan
WHERE L_STORE = 1000;
--L_DATE               L_CODE      L_QTY    L_TOTAL CUMULATIVE_TOTAL
------------------ ---------- ---------- ---------- ----------------
--20110103                100          2       1600             1600
--20110101                100          3       2400             4000
--20110102                102          2       2000             2000
--20110102                105          2       3000             3000

--14번
SELECT deptno, name, pay
	,SUM(pay) OVER()
	,ROUND(RATIO_TO_REPORT(pay) OVER()*100,2)"RATIO %"
FROM professor
ORDER BY "RATIO %" DESC;
--    DEPTNO NAME                                            PAY SUM(PAY)OVER()    RATIO %
------------ ---------------------------------------- ---------- -------------- ----------
--       201 Meryl Streep                                    570           5920       9.63
--       101 Audie Murphy                                    550           5920       9.29
--       103 Emma Thompson                                   530           5920       8.95
--       203 Meg Ryan                                        500           5920       8.45
--       102 Whoopi Goldberg                                 490           5920       8.28
--       101 Angela Bassett                                  380           5920       6.42
--       102 Michelle Pfeiffer                               350           5920       5.91
--       103 Julia Roberts                                   330           5920       5.57
--       201 Susan Sarandon                                  330           5920       5.57
--       202 Nicole Kidman                                   310           5920       5.24
--       103 Sharon Stone                                    290           5920        4.9
--       301 Jodie Foster                                    290           5920        4.9
--       101 Jessica Lange                                   270           5920       4.56
--       202 Holly Hunter                                    260           5920       4.39
--       102 Winona Ryder                                    250           5920       4.22
--       301 Andie Macdowell                                 220           5920       3.72

--15번
SELECT deptno, name, pay
	,SUM(pay) OVER(PARTITION BY deptno)"TOTAL_DEPTNO"
	,ROUND(RATIO_TO_REPORT(pay) OVER(PARTITION BY deptno)*100,2)"RATIO %"
FROM professor;
--  DEPTNO NAME                     PAY TOTAL_DEPTNO    RATIO %
---------- -------------------- ------- ------------ ----------
--     101 Audie Murphy             550         1200      45.83
--     101 Angela Bassett           380         1200      31.67
--     101 Jessica Lange            270         1200       22.5
--     102 Winona Ryder             250         1090      22.94
--     102 Michelle Pfeiffer        350         1090      32.11
--     102 Whoopi Goldberg          490         1090      44.95
--     103 Emma Thompson            530         1150      46.09
--     103 Julia Roberts            330         1150       28.7
--     103 Sharon Stone             290         1150      25.22
--     201 Meryl Streep             570          900      63.33
--     201 Susan Sarandon           330          900      36.67
--     202 Nicole Kidman            310          570      54.39
--     202 Holly Hunter             260          570      45.61
--     203 Meg Ryan                 500          500        100
--     301 Andie Macdowell          220          510      43.14
--     301 Jodie Foster             290          510      56.86

















