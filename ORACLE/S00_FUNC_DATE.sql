--SYSDATE: 시스템의 현재 날짜와 시간
--ALTER SESSION SET NLS_DATE_FORMAT = 'RRRR-MM-DD:HH24:MI:SS';
--데이트 포맷을 바꿔줌
SELECT SYSDATE
FROM dual;
--SYSDATE
---------------------
--2021-02-01:09:19:49

--MONTHS_BETWEEN: 두 날짜 사이의 개월 수
SELECT MONTHS_BETWEEN('2021/04/14','2021/02/01')"SUBTRACT"
	,MONTHS_BETWEEN('2021/02/01','2021/04/01')"SUBTRACT2"
	,MONTHS_BETWEEN('2021/02/01','2021/02/01')"SUBTRACT3"
FROM dual;
--  SUBTRACT  SUBTRACT2  SUBTRACT3
------------ ---------- ----------
--2.41935484         -2          0

--ADD_MONTHS: 주어진 날짜에 개월을 더함
COL "ADD_ONE_MONTH" FOR a15
COL "SUBTRACT_TWO_MONTH" FOR a20
SELECT SYSDATE
	,ADD_MONTHS(SYSDATE, 1)"ADD_ONE_MONTH"
	,ADD_MONTHS(SYSDATE, -2)"SUBTRACT_TWO_MONTH"
FROM dual;	
--SYSDATE  ADD_ONE_MONTH   SUBTRACT_TWO_MONTH
---------- --------------- --------------------
--21/02/01 21/03/01        20/12/01

--NEXT_DAY: 주어진 날짜를 기준으로 돌아오는 날짜 출력
--WINDOWS: NEXT_DAY(SYSDATE,'수')
--UNIX: NEXT_DAY(SYSDATE,'WED')
SELECT SYSDATE
	,NEXT_DAY(SYSDATE,'수')
FROM dual;
--SYSDATE  NEXT_DAY
---------- --------
--21/02/01 21/02/03

--LAST_DAY: 주어진 날짜가 속한 달의 마지막 날짜출력
SELECT SYSDATE
	,LAST_DAY(SYSDATE)
FROM dual;
--SYSDATE  LAST_DAY
---------- --------
--21/02/01 21/02/28

--ROUND: 주어진 날짜를 반올림
--예)상품접수 및 배송(12:00 이후 그 다음날)
--TRUNC: 주어진 날짜를 버림
--예)원서접수(무조건 당일)
SELECT SYSDATE
	,ROUND(SYSDATE)
	,TRUNC(SYSDATE)
FROM dual;
--SYSDATE  ROUND(SYSDATE)
---------- ---------------
--21/02/01 21/02/01

--EXTRACT: 날짜에서 년,월,일 추출
SELECT ename, hiredate
	,EXTRACT(YEAR FROM hiredate)"입사년도"
	,EXTRACT(MONTH FROM hiredate)"입사월"
	,EXTRACT(DAY FROM hiredate)"입사일"
FROM emp;
--ENAME                HIREDATE   입사년도     입사월     입사일
---------------------- -------- ---------- ---------- ----------
--SMITH                80/12/17       1980         12         17
--ALLEN                81/02/20       1981          2         20
--WARD                 81/02/22       1981          2         22
--JONES                81/04/02       1981          4          2
--MARTIN               81/09/28       1981          9         28
--BLAKE                81/05/01       1981          5          1
--CLARK                81/06/09       1981          6          9
--KING                 81/11/17       1981         11         17
--TURNER               81/09/08       1981          9          8
--JAMES                81/12/03       1981         12          3
--FORD                 81/12/03       1981         12          3
--MILLER               82/01/23       1982          1         23

