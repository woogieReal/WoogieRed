--계층형 쿼리(Hierarchical Query)
--ex
--홍길동 사원의 매니저는 이상무
--쇼필몰의 대/중/소 분류
--원글의 댓글 형태 표현
COL ENAME FOR A30
SELECT level,
	LPAD(ename, LEVEL*4, '*') "ENAME"
FROM emp
CONNECT BY PRIOR empno = mgr
START WITH empno = 7839
;
--   LEVEL ENAME
---------- ------------------
--       1 KING
--       2 ***JONES
--       3 ********FORD
--       4 ***********SMITH
--       2 ***BLAKE
--       3 *******ALLEN
--       3 ********WARD
--       3 ******MARTIN
--       3 ******TURNER
--       3 *******JAMES
--       2 ***CLARK
--       3 ******MILLER
------------------------------------------------------
--계층형 쿼리(Hierarchical Query)
--계층구조의 문법
--START WITH: 계층형 질의의 루트(부모형), 서브쿼리를 사용할 수 있음
--CONNECT BY PRIOR: 계층 질의에서 상위계층과 하위계층의 관계를 규정
--LEVEL: Pseudocolumn, 계층 구조의 depth를 표현하는 의사컬럼.
--WHERE: 조건 지정
--ORDER BY SIBLINGS BY: 계층 구조간의 정렬

--주의사항
--CONNECT BY에는 서브쿼리를 사용할 수 없다.
--부분 범위 처리 기법을 계층형 쿼리에 사용할 수 없다.
--CONNECT BY, WHERE 절에 인덱스가 있어야한다.

--LEVEL
SELECT empno,
	ename,
	job,
	mgr,
	LEVEL
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno = mgr
;
-- EMPNO ENAME       JOB                 MGR      LEVEL
-------- ----------- ------------ ---------- ----------
--  7839 KING        PRESIDENT                        1
--  7566 JONES       MANAGER            7839          2
--  7902 FORD        ANALYST            7566          3
--  7369 SMITH       CLERK              7902          4
--  7698 BLAKE       MANAGER            7839          2
--  7499 ALLEN       SALESMAN           7698          3
--  7521 WARD        SALESMAN           7698          3
--  7654 MARTIN      SALESMAN           7698          3
--  7844 TURNER      SALESMAN           7698          3
--  7900 JAMES       CLERK              7698          3
--  7782 CLARK       MANAGER            7839          2
--  7934 MILLER      CLERK              7782          3

--LEVEL1: KING
--LEVEL2: JONES BLAKE CLARK
--LEVEL3: WARD ALLEN MILLER FORD JAMES TURNER MARTIN
--LEVEL4: SMITH

--CONNECT BY PRIOR
--계층을 자식(LEVEL 1)에서 부모(LEVEL 4)로 
--START WITH empno = 7369(SMITH의 empno)
--CONNECT BY empno = PRIOR mgr(부모를 향해서 올라가라)
COL ENAME FOR A30
SELECT LEVEL ,LPAD(ename, LEVEL*5, '*') "ENAME"
FROM emp
CONNECT BY empno = PRIOR mgr
START WITH empno = 7369
;
--  LEVEL ENAME
--------- --------------------------
--      1 SMITH
--      2 ******FORD
--      3 **********JONES
--      4 ****************KING

--START WITH
--START WITH mgr IS NULL (mgr 컬럼의 값이 NULL인 데이터부터 시작하라)
--CONNECT BY PRIOR empno(자식을 향해 내려가라) = mgr
--ORDER SIBLINGS BY empno (empno 로 정렬하라)
SELECT empno,
	level,
	LPAD(ename, LEVEL*4, '*') "ENAME"
FROM emp
CONNECT BY PRIOR empno = mgr
START WITH mgr IS NULL
ORDER SIBLINGS BY empno
;
--  EMPNO      LEVEL ENAME
--------- ---------- ------------------
--   7839          1 KING
--   7566          2 ***JONES
--   7902          3 ********FORD
--   7369          4 ***********SMITH
--   7698          2 ***BLAKE
--   7499          3 *******ALLEN
--   7521          3 ********WARD
--   7654          3 ******MARTIN
--   7844          3 ******TURNER
--   7900          3 *******JAMES
--   7782          2 ***CLARK
--   7934          3 ******MILLER

--PRIOR 컬럼
--PRIOR ename AS "MGR_NM" (상위 객체의 ename을 출력)
--ORDER SIBLINGS BY ename (ename으로 정렬)
COL NAME FOR A30
COL depth_list FOR A70
SELECT empno,
	level,
	LPAD(ename, LEVEL*4, ' ') "NAME",
	PRIOR ename AS "MGR_NM"
FROM emp
CONNECT BY PRIOR empno = mgr
START WITH mgr IS NULL
ORDER SIBLINGS BY ename
;
--  EMPNO      LEVEL NAME                           MGR_NM
--------- ---------- ------------------------------ ----------------
--   7839          1 KING
--   7698          2    BLAKE                       KING
--   7499          3        ALLEN                   BLAKE
--   7900          3        JAMES                   BLAKE
--   7654          3       MARTIN                   BLAKE
--   7844          3       TURNER                   BLAKE
--   7521          3         WARD                   BLAKE
--   7782          2    CLARK                       KING
--   7934          3       MILLER                   CLARK
--   7566          2    JONES                       KING
--   7902          3         FORD                   JONES
--   7369          4            SMITH               FORD

--AND
--계층구조에서 일부분만 계층화 하기
--AND ename = 'JONES' (이름이 'JONES'인 객체만 조회)
COL NAME FOR A30
COL depth_list FOR A70
SELECT empno,
	level,
	LPAD(ename, LEVEL*4, ' ') "NAME"
FROM emp
CONNECT BY PRIOR empno = mgr
	AND ename = 'JONES'
START WITH mgr IS NULL
;
--   EMPNO      LEVEL NAME
---------- ---------- -------------
--    7839          1 KING
--    7566          2    JONES


--SYS_CONNECT_BY_PATH
--계층구조를 자기 기준으로 출력
SELECT LPAD(ename, LEVEL*5, ' ')"NAME",
	SYS_CONNECT_BY_PATH(ename, '->') "depth_list"
FROM emp
START WITH empno = 7369
CONNECT BY empno = PRIOR mgr
;
--NAME                           depth_list
-------------------------------- -------------------------------
--SMITH                          ->SMITH
--      FORD                     ->SMITH->FORD
--          JONES                ->SMITH->FORD->JONES
--                KING           ->SMITH->FORD->JONES->KING


--CONNECT_BY_ISLEAF
--0을 주면 마지막 값을 안볼 수도 있고 
--1을 주고 마지막 값만 볼 수도 있다.

--0
SELECT LPAD(ename, LEVEL*5, ' ')"NAME",
	SYS_CONNECT_BY_PATH(ename, '->') "depth_list"
FROM emp
WHERE CONNECT_BY_ISLEAF = 0
START WITH empno = 7369
CONNECT BY empno = PRIOR mgr
;
--NAME                           depth_list
-------------------------------- ---------------------------
--SMITH                          ->SMITH
--      FORD                     ->SMITH->FORD
--          JONES                ->SMITH->FORD->JONES

--1
SELECT LPAD(ename, LEVEL*5, ' ')"NAME",
	SYS_CONNECT_BY_PATH(ename, '->') "depth_list"
FROM emp
WHERE CONNECT_BY_ISLEAF = 1
START WITH empno = 7369
CONNECT BY empno = PRIOR mgr
;
--NAME                           depth_list
-------------------------------- -------------------------------
--                KING           ->SMITH->FORD->JONES->KING


--CONNECT_BY_ROOT
--특정 레벨에서 최상위 값을 찾아주는 함수
SELECT empno, 
	ename,
	SUBSTR(SYS_CONNECT_BY_PATH(ename, '<-'),3) "depth_list",
	CONNECT_BY_ROOT empno "ROOT_EMPNO"
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr
;
   EMPNO ENAME       depth_list                    ROOT_EMPNO
-------- ----------  ----------------------------- ----------
    7839 KING        KING                              7839
    7566 JONES       KING<-JONES                       7839
    7902 FORD        KING<-JONES<-FORD                 7839
    7369 SMITH       KING<-JONES<-FORD<-SMITH          7839
    7698 BLAKE       KING<-BLAKE                       7839
    7499 ALLEN       KING<-BLAKE<-ALLEN                7839
    7521 WARD        KING<-BLAKE<-WARD                 7839
    7654 MARTIN      KING<-BLAKE<-MARTIN               7839
    7844 TURNER      KING<-BLAKE<-TURNER               7839
    7900 JAMES       KING<-BLAKE<-JAMES                7839
    7782 CLARK       KING<-CLARK                       7839
    7934 MILLER      KING<-CLARK<-MILLER               7839

--509P
--1
SELECT LPAD(name,LEVEL*10,'-') 
	|| '-' || 
	d.dname 
	|| '-' || 
	NVL(e.position,'Team-Worker') 
"Name And Position"
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
START WITH pempno IS NULL
CONNECT BY PRIOR empno = pempno
ORDER SIBLINGS BY e.name 
;
--Name And Position
-------------------------------------------------------------------------------------
--Kurt Russe-President-Boss
-------------AL Pacino-Management Support Team-Department head
--------------------Gene Hackman-General affairs-Section head
-----------------Tommy Lee Jones-Financial Management Team-Deputy department head
-----------------Woody Harrelson-Management Support Team-Section head
-----------Kevin Bacon-Engineering division-Department head
----------------------Hugh Grant-H/W Support Team-Section head
-----------------------------Harrison Ford-H/W Support Team-Team-Worker
--------------------Keanu Reeves-S/W Support Team-Deputy Section chief
----------------------------Clint Eastwood-S/W Support Team-Team-Worker
------------Val Kilmer-Business Department-Department head
-----------------Chris O'Donnell-Business Planning Team-Section head
-------------------------Denzel Washington-Sales2 Team-Team-Worker
----------------------------Jack Nicholson-Sales1 Team-Team-Worker
------------------------------JohnTravolta-Sales1 Team-Team-Worker
-----------------------------Kevin Costner-Sales4 Team-Team-Worker
------------------------------Richard Gere-Sales3 Team-Team-Worker
----------------------------Robert De Niro-Sales2 Team-Team-Worker
------------------------------Sly Stallone-Sales3 Team-Team-Worker
--------------------------------Tom Cruise-Sales4 Team-Team-Worker

--2
SELECT LPAD(name,LEVEL*11,'-') 
	|| '-' || 
	d.dname 
	|| '-' || 
	NVL(e.position,'Team-Worker') 
"Name And Position"
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
START WITH empno = 19966102
CONNECT BY PRIOR empno = pempno
ORDER SIBLINGS BY e.name 
;
--Name And Position
--------------------------------------------------------------------
--Kevin Bacon-Engineering division-Department head
--------------Hugh Grant-H/W Support Team-Section head
----------------------Harrison Ford-H/W Support Team-Team-Worker
------------Keanu Reeves-S/W Support Team-Deputy Section chief
---------------------Clint Eastwood-S/W Support Team-Team-Worker

--3
SELECT LPAD(name,LEVEL*13,'-') 
	|| '-' || 
	d.dname 
	|| '-' || 
	NVL(e.position,'Team-Worker') 
"Name And Position"
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
START WITH name = 'Kevin Costner'
CONNECT BY empno = PRIOR pempno
ORDER SIBLINGS BY e.name 
;
--Name And Position
----------------------------------------------------------------------------------
--Kevin Costner-Sales4 Team-Team-Worker
-------------Chris O'Donnell-Business Planning Team-Section head
-------------------------------Val Kilmer-Business Department-Department head
------------------------------------------Kurt Russell-President-Boss

--4
SELECT name, PRIOR name AS "MGR_NAME"
FROM emp2
CONNECT BY PRIOR empno = pempno
START WITH pempno IS NULL
;
--NAME                           MGR_NAME
-------------------------------- ------------------------
--Kurt Russell
--AL Pacino                      Kurt Russell
--Tommy Lee Jones                AL Pacino
--Gene Hackman                   AL Pacino
--Woody Harrelson                AL Pacino
--Kevin Bacon                    Kurt Russell
--Hugh Grant                     Kevin Bacon
--Harrison Ford                  Hugh Grant
--Keanu Reeves                   Kevin Bacon
--Clint Eastwood                 Keanu Reeves
--Val Kilmer                     Kurt Russell
--Chris O'Donnell                Val Kilmer
--Jack Nicholson                 Chris O'Donnell
--Denzel Washington              Chris O'Donnell
--Richard Gere                   Chris O'Donnell
--JohnTravolta                   Chris O'Donnell
--Tom Cruise                     Chris O'Donnell
--Kevin Costner                  Chris O'Donnell
--Sly Stallone                   Chris O'Donnell
--Robert De Niro                 Chris O'Donnell

--5
COL "ENAME AND POSITION" FOR A100
SELECT empno,
	LPAD(name,LEVEL*10,'-') 
	|| '-' || 
	d.dname 
	|| '-' || 
	NVL(e.position,'Team-Worker') 
	"ENAME AND POSITION",
	(
		SELECT COUNT(*) 
		FROM emp2 f
		START WITH f.empno = e.empno
		CONNECT BY PRIOR f.empno = f.pempno
	)-1 "COUNT"
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
START WITH pempno IS NULL
CONNECT BY PRIOR empno = pempno
ORDER BY COUNT DESC 
;
--     EMPNO ENAME AND POSITION                                                                        COUNT
------------ ------------------------------------------------------------------------------------ ----------
--  19900101 Kurt Russe-President-Boss                                                                    19
--  19970112 ----------Val Kilmer-Business Department-Department head                                      9
--  19960212 ---------------Chris O'Donnell-Business Planning Team-Section head                            8
--  19966102 ---------Kevin Bacon-Engineering division-Department head                                     4
--  19960101 -----------AL Pacino-Management Support Team-Department head                                  3
--  19960303 ------------------Keanu Reeves-S/W Support Team-Deputy Section chief                          1
--  19930402 --------------------Hugh Grant-H/W Support Team-Section head                                  1
--  20000203 ----------------------------Richard Gere-Sales3 Team-Team-Worker                              0
--  20000305 ----------------------------JohnTravolta-Sales1 Team-Team-Worker                              0
--  20000308 ------------------------------Tom Cruise-Sales4 Team-Team-Worker                              0
--  20000334 ---------------------------Kevin Costner-Sales4 Team-Team-Worker                              0
--  20000407 ----------------------------Sly Stallone-Sales3 Team-Team-Worker                              0
--  20000102 -----------------------Denzel Washington-Sales2 Team-Team-Worker                              0
--  20000101 --------------------------Jack Nicholson-Sales1 Team-Team-Worker                              0
--  20006106 --------------------------Robert De Niro-Sales2 Team-Team-Worker                              0
--  20000119 ---------------------------Harrison Ford-H/W Support Team-Team-Worker                         0
--  19970201 ---------------Woody Harrelson-Management Support Team-Section head                           0
--  19950303 ------------------Gene Hackman-General affairs-Section head                                   0
--  19930331 ---------------Tommy Lee Jones-Financial Management Team-Deputy department head               0
--  20000210 --------------------------Clint Eastwood-S/W Support Team-Team-Worker                         0

--6
SELECT LPAD(ename, LEVEL*5, ' ')"NAME",
	SYS_CONNECT_BY_PATH(ename, '->') "depth_list"
FROM emp
START WITH empno = 7369
CONNECT BY empno = PRIOR mgr
;
SELECT 

COL "Name And Position" FOR A100
COL PATH FOR A100
SELECT LPAD(name,LEVEL*11,'-') 
	|| '-' || 
	d.dname 
	|| '-' || 
	NVL(e.position,'Team-Worker') 
	"Name And Position",
	SYS_CONNECT_BY_PATH(name, '-') "PATH"
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
START WITH empno = 19966102
CONNECT BY PRIOR empno = pempno
ORDER SIBLINGS BY e.name 
;
--Name And Position                                                      PATH
------------------------------------------------------------------------ -----------------------------------------------
--Kevin Bacon-Engineering division-Department head                       -Kevin Bacon
--------------Hugh Grant-H/W Support Team-Section head                   -Kevin Bacon-Hugh Grant
----------------------Harrison Ford-H/W Support Team-Team-Worker         -Kevin Bacon-Hugh Grant-Harrison Ford
------------Keanu Reeves-S/W Support Team-Deputy Section chief           -Kevin Bacon-Keanu Reeves
---------------------Clint Eastwood-S/W Support Team-Team-Worker         -Kevin Bacon-Keanu Reeves-Clint Eastwood

SELECT empno,
	LPAD(name,LEVEL*10,'-') 
	    || '-' || 
	    d.dname 
	    || '-' || 
	    NVL(e.position,'Team-Worker') 
	"ENAME AND POSITION",
	(
		SELECT COUNT(*) 
		FROM emp2 f
		START WITH f.empno = e.empno
		CONNECT BY PRIOR f.empno = f.pempno
	) "COUNT"
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
START WITH pempno IS NULL
CONNECT BY PRIOR empno = pempno
ORDER BY COUNT DESC 
;

SELECT ename, 
	SYS_CONNECT_BY_PATH(ename, '-') "depth_list",
	COUNT(*) OVER()
FROM emp
START WITH empno = 7566
CONNECT BY PRIOR empno = mgr
;






