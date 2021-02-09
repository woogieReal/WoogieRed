COL "TOTAL"     FOR A15
COL "SEOUL"     FOR A15
COL "GYEONGGI"  FOR A15
COL "BUSAN"     FOR A15
COL "ULSAN"     FOR A15
COL "DAEGU"     FOR A15
COL "GYEONGNAM" FOR A22
SELECT TOTAL     ||'EA ('|| (TOTAL/TOTAL)*100     ||'%)'  "TOTAL"
      ,SEOUL     ||'EA ('|| (SEOUL/TOTAL)*100     ||'%)'  "SEOUL"
	  ,GYEONGGI  ||'EA ('|| (GYEONGGI/TOTAL)*100  ||'%)'  "GYEONGGI"
	  ,BUSAN     ||'EA ('|| (BUSAN/TOTAL)*100     ||'%)'  "BUSAN"
	  ,ULSAN     ||'EA ('|| (ULSAN/TOTAL)*100     ||'%)'  "ULSAN"
	  ,DAEGU     ||'EA ('|| (DAEGU/TOTAL)*100     ||'%)'  "DAEGU"
	  ,GYEONGNAM ||'EA ('|| (GYEONGNAM/TOTAL)*100 ||'%)'  "GYEONGNAM"	  
FROM (
	SELECT MAX(TOTAL) "TOTAL"
		  ,COUNT(DECODE(AREA_CD,'02' ,'1'))     "SEOUL"
		  ,COUNT(DECODE(AREA_CD,'031','1'))     "GYEONGGI"
		  ,COUNT(DECODE(AREA_CD,'051','1'))     "BUSAN"
		  ,COUNT(DECODE(AREA_CD,'052','1'))     "ULSAN"
		  ,COUNT(DECODE(AREA_CD,'053','1'))     "DAEGU"
		  ,COUNT(DECODE(AREA_CD,'055','1'))     "GYEONGNAM"
	FROM(
			SELECT COUNT(*) OVER() "TOTAL"
				  ,SUBSTR(tel,1,INSTR(tel,')')-1) "AREA_CD"
			FROM student
	)
);
--TOTAL       SEOUL       GYEONGGI   BUSAN      ULSAN    DAEGU       GYEONGNAM
------------- ----------- ---------- ---------- -------- ----------- -----------
--20EA (100%) 6EA (30%)   2EA (10%)  4EA (20%)  0EA (0%) 2EA (10%)   6EA (30%)















