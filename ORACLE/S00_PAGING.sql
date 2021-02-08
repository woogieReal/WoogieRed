
--PHASING
--OLTP (Online Transaction Processing) - 온라인 트랜잭션 처리
--OLAP (OnLine Analytical Processing) - 온라인 분석 처리

--SELECT  TT1.*
--FROM(
--    SELECT rownum rnum,T1.*
--    FROM (
--        SELECT *
--        FROM member
--        --검색조건
--        ORDER BY mod_dt DESC
--    ) T1
--    WHERE rownum <= 10
--) TT1
--WHERE rnum >=  1;
----WHERE rnum BETWEEN  1  AND 10;

SELECT TT1.*
FROM(
	SELECT rownum rnum,T1.name, T1.position, T1.deptno
	FROM(
		SELECT *
		FROM emp2
		ORDER BY birthday
	)T1
	--WHERE rownum <= 20
)TT1
--WHERE rnum >= 11
WHERE rnum BETWEEN 1 AND 10
;
--   RNUM NAME                 POSITION                  DEPTNO
--------- -------------------- ------------------------- ------------
--      1 Kurt Russell         Boss                      0001
--      2 Keanu Reeves         Deputy Section chief      1005
--      3 Kevin Bacon          Department head           1003
--      4 Hugh Grant           Section head              1004
--      5 Chris O'Donnell      Section head              1007
--      6 AL Pacino            Department head           1000
--      7 Gene Hackman         Section head              1002
--      8 Woody Harrelson      Section head              1000
--      9 Tommy Lee Jones      Deputy department head    1001
--     10 Val Kilmer           Department head           1006


--SELECT TT1.*
--FROM(
--	SELECT rownum rnum,T1.name
--	FROM(
--		SELECT *
--		FROM emp2
--		ORDER BY birthday DESC
--	)T1
--	--WHERE rownum <= 20
--)TT1
----WHERE rnum >= 11
--WHERE rnum BETWEEN &PAGE_SIZE*(&PAGE_NUM-1)+1 AND &PAGE_SIZE*(&PAGE_NUM-1)+&PAGE_SIZE
--;


--ANSI PAGING:
SELECT A.*,B.CNT
FROM(
	SELECT TT1.*
	FROM(
		SELECT rownum rnum,T1.name
		FROM(
			SELECT *
			FROM emp2
			ORDER BY birthday DESC
		)T1
		--WHERE rownum <= 20
	)TT1
	--WHERE rnum >= 11
	WHERE rnum BETWEEN &PAGE_SIZE*(&PAGE_NUM-1)+1 AND &PAGE_SIZE*(&PAGE_NUM-1)+&PAGE_SIZE
)A CROSS JOIN(
SELECT COUNT(*) CNT
FROM emp2
)B
;


