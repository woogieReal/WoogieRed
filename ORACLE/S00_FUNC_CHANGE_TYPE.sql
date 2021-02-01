--CHAR(n): 고정길이의 문자를 저장, 최댓값은 2000바이트(꼭 고정된 길이의 데이터에만 쓸 것)
--VARCHAR2(n): 변하는 길이의 문자를 저장, 최댓값은 4000바이트
--NUMBER(p,s): 숫자 값을 저장, P는 전체 자릿수로 1~38자리까지 가능, s는 소술점 이하 자릿수로 -84~127자리까지 가능
--DATE: 총 7바이트로 BC4712년 1월 1일부터 AD9999년 12월 31일까지의 날짜를 저장가능
--LONG: 가변길이의 문자를 저장하며 최대 2GB까지 저장가능(앞으로 없어질 가능성이 있으므로 사용자제)
--CLOB: 가변길이의 문자를 저장하며 최대 4GB까지 저장가능
--BLOB: 가변길이의 바이너리 데이터를 최대 4GB까지 저장가능
--RAW(n): 원시이진 데이터로 최대 2000바이트까지 저장가능
--LONG RAW(n): 원시이진 데이터로 최대 2GB까지 저장가능
--BFILE: 외부파일에 저장된 데이터로 최대 4GB까지 저장가능

--묵시적(자동) 형변환
--해당컬럼에 인덱스가 생성되어 있을 경우 못쓰게 되어 속도가 느려짐
SELECT '11'+'13'
FROM dual;
-- '11'+'13'
------------
--        24
--명시적(수동) 형변환
SELECT 11+TO_NUMBER('13')
FROM dual;
--11+TO_NUMBER('13')
--------------------
--                24

--TO_CHAR: 날짜 -> 문자
--TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
--	종류		의미								  	사용예
-- YYYY | 연도를 4자리로 표시						| 2021
-- RRRR | 위와 동일       	                  	| 2021
-- YY   | 연도의 끝자리 2자리	                  	| 21
-- RR	| 위와 동일 	   	                  	| 21
-- YEAR | 연도의 영문명 전체 	                  	| TWENTY TWENTY ONE
-- MM	| 월을 숫자 2자리로	                  	| 02
-- MON	| 월(유닉스는 영3글자,윈도우는 MONTH와 동일)	| FEB
-- MONTH| 월의 영문명 전체	                  	| FEBRUARY
-- DD	| 일을 숫자 2자리로	                  	| 26
-- DAY	| 요일(유닉스는 영문,윈도우는 한글)			| 월요일
-- DDTH	| 몇 번째 날인지를 표시					| 22ND
-- HH24 | 하루를 24시간으로 표시					| 23
-- HH	| 하루를 12시간으로 표시					| 11
-- MI	| 분									| 20
-- SS	| 초									| 30
SELECT SYSDATE
	,TO_CHAR(SYSDATE, 'YYYY')"YYYY"
	,TO_CHAR(SYSDATE, 'MM')"MM"
	,TO_CHAR(SYSDATE, 'DD')"DD"
	,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')"YYYY-MM-DD HH24:MI:SS"
FROM dual;
--SYSDATE  YYYY     MM   DD   YYYY-MM-DD HH24:MI:SS
---------- -------- ---- ---- --------------------------------------
--21/02/01 2021     02   01   2021-02-01 10:43:00

--P105퀴즈
SELECT studno, name, TO_CHAR(birthday, 'DD-MM-YY')
FROM student
WHERE EXTRACT(MONTH FROM birthday) = 1;
--    STUDNO NAME                      TO_CHAR(BIRTHDAY
------------ ------------------------- ----------------
--      9511 Billy Crystal             23-01-76
--      9514 Bill Murray               20-01-76
--      9712 Sean Connery              05-01-78

--p106퀴즈
SELECT empno, ename, hiredate
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) IN(1,2,3);
--     EMPNO ENAME                HIREDATE
------------ -------------------- --------
--      7499 ALLEN                81/02/20
--      7521 WARD                 81/02/22
--      7934 MILLER               82/01/23

--TO_CHAR: 숫자 -> 문자
--종류		의미					사용 예			  결과
-- 9 | 9의 개수만큼 자릿수 | TO_CHAR(1234,'99999')   | 1234
-- 0 | 빈자리를 0으로 채움 | TO_CHAR(1234,'099999')  | 001234
-- $ | $표시를 붙여서 표시 | TO_CHAR(1234,'$9999')   | $1234
-- . | 소숫점 이하를 표시  | TO_CHAR(1234,'9999.99') | 1234.00
-- , | 천단위 구분을 표시  | TO_CHAR(12345,'99,999') | 12,345
SELECT empno, ename, sal, comm, TO_CHAR((sal*12)+comm,'$99,999')"SALARY"
FROM emp
WHERE ename = 'ALLEN';
--     EMPNO ENAME                       SAL       COMM SALARY
------------ -------------------- ---------- ---------- ----------------
--      7499 ALLEN                      1600        300  $19,500

SELECT name, pay, bonus, pay*12+bonus"TOTAL"
FROM professor
WHERE deptno = 201;

--108P 퀴즈
SELECT empno, ename
	,TO_CHAR(hiredate,'YYYY-MM-DD')"HIREDATE"
	,TO_CHAR(sal*12+comm,'$999,999')"SAL"
	,TO_CHAR((sal*12+comm)*1.15,'$999,999')"15% UP"
FROM emp
WHERE comm IS NOT NULL;
--     EMPNO ENAME                HIREDATE             SAL                15% UP
------------ -------------------- -------------------- ------------------ ------------------
--      7499 ALLEN                1981-02-20             $19,500            $22,425
--      7521 WARD                 1981-02-22             $15,500            $17,825
--      7654 MARTIN               1981-09-28             $16,400            $18,860
--      7844 TURNER               1981-09-08             $18,000            $20,700

--TO_NUMBER: 숫자가 아닌 숫자문자를 숫자로 바꾸어주는 함수
SELECT TO_NUMBER('5')
FROM dual;
--TO_NUMBER('5')
----------------
--             5

SELECT ASCII('A')
FROM dual;
--ASCII('A')
------------
--        65

--TO_DATE: 날짜가 아닌 날짜처럼 생긴 문자를 날짜로 바꿔주는 함수
SELECT TO_DATE('20210201')"date"
FROM dual;
--date
----------
--21/02/01