--CTAS
--CREATE TABLE AS SELECT

--CREATE TABLE professor2
--AS
--SELECT deptno
--	,position
--	,pay
--FROM professor;

--    DEPTNO POSITION                    PAY
------------ -------------------- ----------
--       101 a full professor            550
--       101 assistant professor         380
--       101 instructor                  270
--       102 instructor                  250
--       102 assistant professor         350
--       102 a full professor            490
--       103 a full professor            530
--       103 assistant professor         330
--       103 instructor                  290
--       201 a full professor            570
--       201 assistant professor         330
--       202 assistant professor         310
--       202 instructor                  260
--       203 a full professor            500
--       301 instructor                  220
--       301 assistant professor         290

--데이터 삽입 101 instructor 100
--INSERT INTO professor2 VALUES(101,'instructor',100);

--INSERT INTO professor2 VALUES(101,'assistant professor',100);
--INSERT INTO professor2 VALUES(101,'a full professor',100);

--commit;
--데이터베이스에 수정이 반영되기 위해서는 commit 명령어를 사용해야 한다.

SELECT deptno, position, SUM(pay)
FROM professor2 
WHERE deptno = 101
GROUP BY deptno, ROLLUP(position);
--    DEPTNO POSITION               SUM(PAY)
------------ -------------------- ----------
--       101 instructor                  370
--       101 a full professor            650
--       101 assistant professor         480
--       101                            1500




