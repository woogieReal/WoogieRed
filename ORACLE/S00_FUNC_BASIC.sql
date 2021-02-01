--NVL: NULL값을 만나면 치환값을 출력
--NVL2:
--DECODE: SQL의 IF/ELSE/IF ELSE문
--CASE: SQL의 IF/ELSE/IF ELSE문(모든 SQL프로그램 공통)

--NVL(컬럼,치환값): NULL값을 만나면 치환값을 출력
SELECT ename, comm
	,NVL(comm,0)"NVL"
	,comm*10
	,NVL(comm*10,0)"NVL*10"
FROM emp
WHERE deptno = 30;
--ENAME                      COMM        NVL    COMM*10     NVL*10
---------------------- ---------- ---------- ---------- ----------
--ALLEN                       300        300       3000       3000
--WARD                        500        500       5000       5000
--MARTIN                     1400       1400      14000      14000
--BLAKE                                    0                     0
--TURNER                        0          0          0          0
--JAMES                                    0                     0

--연습
SELECT profno, name, pay, NVL(bonus,0), pay*12+NVL(bonus,0)"TOTAL"
FROM professor
WHERE deptno = 201;
--    PROFNO NAME                                            PAY NVL(BONUS,0)      TOTAL
------------ ---------------------------------------- ---------- ------------ ----------
--      4001 Meryl Streep                                    570          130       6970
--      4002 Susan Sarandon                                  330            0       3960

--NVL2(COL1, COL2, COL3): 컬럼1이 NULL값이 아니면 COL2를, NULL이면 COL3를 출력
SELECT ename, empno, sal, comm, NVL2(comm,sal*comm,sal*0)"NVL2"
FROM emp
WHERE deptno = 30;
--ENAME                     EMPNO        SAL       COMM       NVL2
---------------------- ---------- ---------- ---------- ----------
--ALLEN                      7499       1600        300     480000
--WARD                       7521       1250        500     625000
--MARTIN                     7654       1250       1400    1750000
--BLAKE                      7698       2850                     0
--TURNER                     7844       1500          0          0
--JAMES                      7900        950                     0

--113p퀴즈
SELECT empno, ename, comm, NVL2(comm,'Exist','NULL')"NVL2"
FROM emp
WHERE deptno = 30;
--     EMPNO ENAME                      COMM NVL2
------------ -------------------- ---------- ----------
--      7499 ALLEN                       300 Exist
--      7521 WARD                        500 Exist
--      7654 MARTIN                     1400 Exist
--      7698 BLAKE                           NULL
--      7844 TURNER                        0 Exist
--      7900 JAMES                           NULL

--DECODE: 자바에서 사용하는 IF문을 오라클로 가져온 함수(오라클에만 있음)
--유형1. A,B일 경우 1을 출력
--DECODE(A,B,1,NULL) (단 마지막의 NULL은 생략가능)
--DECODE(A,B,1) (단 마지막의 NULL은 생략가능)
SELECT deptno, name, DECODE(deptno,101,'Computer Engineering',NULL)"DNAME"
FROM professor;
--    DEPTNO NAME                                     DNAME
------------ ---------------------------------------- ----------------------------------------
--       101 Audie Murphy                             Computer Engineering
--       101 Angela Bassett                           Computer Engineering
--       101 Jessica Lange                            Computer Engineering
--       102 Winona Ryder
--       102 Michelle Pfeiffer
--       102 Whoopi Goldberg
--       103 Emma Thompson
--       103 Julia Roberts
--       103 Sharon Stone
--       201 Meryl Streep
--       201 Susan Sarandon
--       202 Nicole Kidman
--       202 Holly Hunter
--       203 Meg Ryan
--       301 Andie Macdowell
--       301 Jodie Foster

--유형2. DECODE(A,B,1,2)
--A가 B일 경우 '1'을, 아니면 '2'를 출력
SELECT name, DECODE(deptno,101,'Computer Engineering','ETC')"DNAME"
FROM professor;
--NAME                                     DNAME
------------------------------------------ ----------------------------------------
--Audie Murphy                             Computer Engineering
--Angela Bassett                           Computer Engineering
--Jessica Lange                            Computer Engineering
--Winona Ryder                             ETC
--Michelle Pfeiffer                        ETC
--Whoopi Goldberg                          ETC
--Emma Thompson                            ETC
--Julia Roberts                            ETC
--Sharon Stone                             ETC
--Meryl Streep                             ETC
--Susan Sarandon                           ETC
--Nicole Kidman                            ETC
--Holly Hunter                             ETC
--Meg Ryan                                 ETC
--Andie Macdowell                          ETC
--Jodie Foster                             ETC

--유형3. DECODE(A,B,1,C,2,3)
--IF(A==B) -> 1
--ELSE IF(A==C) -> 2
--ELSE -> 3
SELECT name, deptno
	,DECODE(deptno,101,'Computer Engineering'
				  ,102,'Multimedia Engineering'
				  ,103,'Software Engineering'
				  ,'ETC')"DNAME"
FROM professor;
--NAME                                         DEPTNO DNAME
------------------------------------------ ---------- --------------------------------------------
--Audie Murphy                                    101 Computer Engineering
--Angela Bassett                                  101 Computer Engineering
--Jessica Lange                                   101 Computer Engineering
--Winona Ryder                                    102 Multimedia Engineering
--Michelle Pfeiffer                               102 Multimedia Engineering
--Whoopi Goldberg                                 102 Multimedia Engineering
--Emma Thompson                                   103 Software Engineering
--Julia Roberts                                   103 Software Engineering
--Sharon Stone                                    103 Software Engineering
--Meryl Streep                                    201 ETC
--Susan Sarandon                                  201 ETC
--Nicole Kidman                                   202 ETC
--Holly Hunter                                    202 ETC
--Meg Ryan                                        203 ETC
--Andie Macdowell                                 301 ETC
--Jodie Foster                                    301 ETC

--유형4. DECODE(A,B,DECODE(C,D,1,NULL)) (NULL은 생략가능)
--IF(A==B){
--	IF(C==D){
--		1
--	}
--}
SELECT deptno,name
	,DECODE(deptno,101,DECODE(name,'Audie Murphy','BEST!'))"DNAME"
FROM professor;
--    DEPTNO NAME                                     DNAME
------------ ---------------------------------------- ----------
--       101 Audie Murphy                             Best!
--       101 Angela Bassett
--       101 Jessica Lange
--       102 Winona Ryder
--       102 Michelle Pfeiffer
--       102 Whoopi Goldberg
--       103 Emma Thompson
--       103 Julia Roberts
--       103 Sharon Stone
--       201 Meryl Streep
--       201 Susan Sarandon
--       202 Nicole Kidman
--       202 Holly Hunter
--       203 Meg Ryan
--       301 Andie Macdowell
--       301 Jodie Foster

--유형5.
--DECODE(A,B,DECODE(C,D,'1','2'),'3')
--IF(A==B){
--	IF(C==D){
--		1
--	}ELSE '2'
--}ELSE '3'
SELECT deptno,name
	,DECODE(deptno,101,DECODE(name,'Audie Murphy','BEST!','GOOD!'),'NOT MY MAJOR')"DNAME"
FROM professor;
--    DEPTNO NAME                                     DNAME
------------ ---------------------------------------- ------------------------
--       101 Audie Murphy                             BEST!
--       101 Angela Bassett                           GOOD!
--       101 Jessica Lange                            GOOD!
--       102 Winona Ryder                             NOT MY MAJOR
--       102 Michelle Pfeiffer                        NOT MY MAJOR
--       102 Whoopi Goldberg                          NOT MY MAJOR
--       103 Emma Thompson                            NOT MY MAJOR
--       103 Julia Roberts                            NOT MY MAJOR
--       103 Sharon Stone                             NOT MY MAJOR
--       201 Meryl Streep                             NOT MY MAJOR
--       201 Susan Sarandon                           NOT MY MAJOR
--       202 Nicole Kidman                            NOT MY MAJOR
--       202 Holly Hunter                             NOT MY MAJOR
--       203 Meg Ryan                                 NOT MY MAJOR
--       301 Andie Macdowell                          NOT MY MAJOR
--       301 Jodie Foster                             NOT MY MAJOR

--연습1
SELECT name, jumin, DECODE(SUBSTR(jumin,7,1),'1','MAN','WOMEN')"Gender"
FROM student
WHERE deptno1 = 101;
--NAME                 JUMIN                      Gender
---------------------- -------------------------- ----------
--James Seo            7510231901813              MAN
--Billy Crystal        7601232186327              WOMEN
--Richard Dreyfus      7711291186223              MAN
--Danny Devito         7808192157498              WOMEN

--연습2
COL name FOR a20
SELECT name, tel
	,DECODE(SUBSTR(tel,1,INSTR(tel,')')-1),'02','SEOUL'
										  ,'031','GYEONGGI'
										  ,'051','BUSAN'
										  ,'052','ULSAN'
										  ,'055','GYEONGNAM'
										  ,'ETC'
	)"LOC"
FROM student;
--NAME                 TEL                            LOC
---------------------- ------------------------------ ------------------
--James Seo            055)381-2158                   GYEONGNAM
--Rene Russo           051)426-1700                   BUSAN
--Sandra Bullock       053)266-8947                   ETC
--Demi Moore           02)6255-9875                   SEOUL
--Danny Glover         031)740-6388                   GYEONGGI
--Billy Crystal        055)333-6328                   GYEONGNAM
--Nicholas Cage        051)418-9627                   BUSAN
--Micheal Keaton       051)724-9618                   BUSAN
--Bill Murray          055)296-3784                   GYEONGNAM
--Macaulay Culkin      02)312-9838                    SEOUL
--Richard Dreyfus      02)6788-4861                   SEOUL
--Tim Robbins          055)488-2998                   GYEONGNAM
--Wesley Snipes        053)736-4981                   ETC
--Steve Martin         02)6175-3945                   SEOUL
--Daniel Day-Lewis     051)785-6984                   BUSAN
--Danny Devito         055)278-3649                   GYEONGNAM
--Sean Connery         02)381-5440                    SEOUL
--Christian Slater     031)345-5677                   GYEONGGI
--Charlie Sheen        055)423-9870                   GYEONGNAM
--Anthony Hopkins      02)6122-2345                   SEOUL

--CASE VS DECODE
--DECODE는 == 조건인 경우
--CASE는 == 조건이 아닌경우

--CASE 조건 WHEN 결과 THEN 출력 END
SELECT name, tel
	,CASE(SUBSTR(tel,1,INSTR(tel,')')-1)) WHEN '02' THEN 'SEOUL'
										  WHEN '031' THEN 'GYEONGGI'
										  WHEN '051' THEN 'BUSAN'
										  WHEN '052' THEN 'ULSAN'
										  WHEN '055' THEN 'GYEONGNAM'
										  ELSE 'ETC'
	END "LOC"
FROM student;
--NAME                 TEL                            LOC
---------------------- ------------------------------ ------------------
--James Seo            055)381-2158                   GYEONGNAM
--Rene Russo           051)426-1700                   BUSAN
--Sandra Bullock       053)266-8947                   ETC
--Demi Moore           02)6255-9875                   SEOUL
--Danny Glover         031)740-6388                   GYEONGGI
--Billy Crystal        055)333-6328                   GYEONGNAM
--Nicholas Cage        051)418-9627                   BUSAN
--Micheal Keaton       051)724-9618                   BUSAN
--Bill Murray          055)296-3784                   GYEONGNAM
--Macaulay Culkin      02)312-9838                    SEOUL
--Richard Dreyfus      02)6788-4861                   SEOUL
--Tim Robbins          055)488-2998                   GYEONGNAM
--Wesley Snipes        053)736-4981                   ETC
--Steve Martin         02)6175-3945                   SEOUL
--Daniel Day-Lewis     051)785-6984                   BUSAN
--Danny Devito         055)278-3649                   GYEONGNAM
--Sean Connery         02)381-5440                    SEOUL
--Christian Slater     031)345-5677                   GYEONGGI
--Charlie Sheen        055)423-9870                   GYEONGNAM
--Anthony Hopkins      02)6122-2345                   SEOUL

--비교조건이 == 이 아닌경우
COL "QUARTER" FOR a10
SELECT name, jumin
	, CASE WHEN SUBSTR(jumin,3,2) BETWEEN '01' AND '03' THEN '1/4'
		   WHEN SUBSTR(jumin,3,2) BETWEEN '04' AND '07' THEN '2/4'
		   WHEN SUBSTR(jumin,3,2) BETWEEN '07' AND '10' THEN '3/4'
		   WHEN SUBSTR(jumin,3,2) BETWEEN '10' AND '12' THEN '4/4'
	END "QUARTER"
FROM student;
--NAME                 JUMIN                      QUARTER
---------------------- -------------------------- ----------
--James Seo            7510231901813              3/4
--Rene Russo           7502241128467              1/4
--Sandra Bullock       7506152123648              2/4
--Demi Moore           7512251063421              4/4
--Danny Glover         7503031639826              1/4
--Billy Crystal        7601232186327              1/4
--Nicholas Cage        7604122298371              2/4
--Micheal Keaton       7609112118379              3/4
--Bill Murray          7601202378641              1/4
--Macaulay Culkin      7610122196482              3/4
--Richard Dreyfus      7711291186223              4/4
--Tim Robbins          7704021358674              2/4
--Wesley Snipes        7709131276431              3/4
--Steve Martin         7702261196365              1/4
--Daniel Day-Lewis     7712141254963              4/4
--Danny Devito         7808192157498              3/4
--Sean Connery         7801051776346              1/4
--Christian Slater     7808091786954              3/4
--Charlie Sheen        7803241981987              1/4
--Anthony Hopkins      7802232116784              1/4

--123p 퀴즈
SELECT empno, ename, sal
	,CASE   WHEN sal BETWEEN 1 AND 1000 THEN 'LEVEL 1'
			WHEN sal BETWEEN 1001 AND 2000 THEN 'LEVEL 2'
			WHEN sal BETWEEN 2001 AND 3000 THEN 'LEVEL 3'
			WHEN sal BETWEEN 3001 AND 4000 THEN 'LEVEL 4'
			WHEN sal > 4001 THEN 'LEVEL 5'
	END "LEVEL"
FROM emp
ORDER BY 4 DESC;
--     EMPNO ENAME                       SAL LEVEL
------------ -------------------- ---------- --------------
--      7839 KING                       5000 LEVEL 5
--      7698 BLAKE                      2850 LEVEL 3
--      7902 FORD                       3000 LEVEL 3
--      7782 CLARK                      2450 LEVEL 3
--      7566 JONES                      2975 LEVEL 3
--      7934 MILLER                     1300 LEVEL 2
--      7654 MARTIN                     1250 LEVEL 2
--      7844 TURNER                     1500 LEVEL 2
--      7521 WARD                       1250 LEVEL 2
--      7499 ALLEN                      1600 LEVEL 2
--      7900 JAMES                       950 LEVEL 1
--      7369 SMITH                       800 LEVEL 1







