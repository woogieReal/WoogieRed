explain plan for

--PLAN SQL
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

col plan_table_output format a80
SELECT * FROM table(dbms_xplan.display);


---------수행로그----------------------------
--09:43:52 SCOTT>explain plan for
--09:44:11   2  SELECT deptno, job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
--09:44:18   3  FROM emp
--09:44:18   4  GROUP BY deptno, job
--09:44:18   5  UNION ALL
--09:44:18   6  SELECT deptno, NULL job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
--09:44:18   7  FROM emp
--09:44:18   8  GROUP BY deptno
--09:44:18   9  UNION ALL
--09:44:18  10  SELECT NULL deptno, NULL job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
--09:44:18  11  FROM emp
--09:44:18  12  ORDER BY deptno, job;
--
--Explained.
--
--09:44:21 SCOTT>col plan_table_output format a80
--09:44:53 SCOTT>SELECT * FROM table(dbms_xplan.display);
--
--PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------
--Plan hash value: 3259471421
--																				실행순서
-------------------------------------------------------------------------------
--| Id  | Operation            | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT     |      |    15 |   190 |    12  (25)| 00:00:01 |   8
--|   1 |  SORT ORDER BY       |      |    15 |   190 |    11  (73)| 00:00:01 |   7
--|   2 |   UNION-ALL          |      |       |       |            |          |   6
--|   3 |    HASH GROUP BY     |      |    11 |   165 |     4  (25)| 00:00:01 |   2
--|   4 |     TABLE ACCESS FULL| EMP  |    12 |   180 |     3   (0)| 00:00:01 |   1
--|   5 |    HASH GROUP BY     |      |     3 |    21 |     4  (25)| 00:00:01 |   4
--|   6 |     TABLE ACCESS FULL| EMP  |    12 |    84 |     3   (0)| 00:00:01 |   3
--|   7 |    SORT AGGREGATE    |      |     1 |     4 |            |          |   6
--|   8 |     TABLE ACCESS FULL| EMP  |    12 |    48 |     3   (0)| 00:00:01 |   5
-------------------------------------------------------------------------------
--
--15 rows selected.

explain plan for

SELECT deptno, job, AVG(NVL(sal,0))"AVG", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY ROLLUP(deptno,job); 

col plan_table_output format a80
SELECT * FROM table(dbms_xplan.display);

-------------수행로그---------------
--09:50:04 SCOTT>explain plan for
--09:50:16   2  SELECT deptno, job, AVG(NVL(sal,0))"AVG", COUNT(*)"THE NUMBER OF EMPLOYEE"
--09:50:24   3  FROM emp
--09:50:24   4  GROUP BY ROLLUP(deptno,job);
--
--Explained.
--
--09:50:26 SCOTT>col plan_table_output format a80
--09:51:09 SCOTT>SELECT * FROM table(dbms_xplan.display);
--
--PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------
--Plan hash value: 52302870
--
-------------------------------------------------------------------------------
--| Id  | Operation            | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT     |      |    11 |   165 |     4  (25)| 00:00:01 |
--|   1 |  SORT GROUP BY ROLLUP|      |    11 |   165 |     4  (25)| 00:00:01 |
--|   2 |   TABLE ACCESS FULL  | EMP  |    12 |   180 |     3   (0)| 00:00:01 |
-------------------------------------------------------------------------------
--
--9 rows selected.