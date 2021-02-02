--ORACLE Ω««‡∞Ë»π
EXPLAIN PLAN FOR
SELECT *
FROM emp;

col plan_table_output format a80;
select * from table(dbms_xplan.display);