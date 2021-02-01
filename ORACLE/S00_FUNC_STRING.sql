--INITCAP(): 영어에서 첫 글자만 대문자로 출력
--INITCAP('ABCD') -> Abcd
SELECT ename , INITCAP(ename) "INITCAP"
FROM emp
WHERE deptno = 10;
--ENAME                INITCAP
---------------------- --------------------
--CLARK                Clark
--KING                 King
--MILLER               Miller

--LOWER(), UPPER()
SELECT ename, LOWER(ename) "LOWER", UPPER(ename) "UPPER"
FROM emp
WHERE deptno = 10;
--ENAME                LOWER                UPPER
---------------------- -------------------- --------------------
--CLARK                clark                CLARK
--KING                 king                 KING
--MILLER               miller               MILLER

--LENGTH(), LENGTHB()
--LENGTH(문자열 또는 컬럼): 입력된 문자열의 길이를 RETURN
--LENGTHB(문자열 또는 컬럼): 입력된 문자열의 길이를 BYTE로 RETURN
SELECT ename, LENGTH(ename) "LENGTH", LENGTHB(ename) "LENGTHB"
FROM emp
WHERE deptno = 10;
--ENAME                    LENGTH    LENGTHB
---------------------- ---------- ----------
--CLARK                         5          5
--KING                          4          4
--MILLER                        6          6

--CONCAT(): 두 문자열을 결합해서 출력. ||연산자와 동일
--CONCAT('A','B') -> AB
SELECT CONCAT(ename,job)
FROM emp
WHERE deptno = 10;
--CONCAT(ENAME,JOB)
----------------------------------------
--CLARKMANAGER
--KINGPRESIDENT
--MILLERCLERK

--SUBSTR(): 주어진 문자열에서 특정 길이의 문자를 잘라 낼때 사용
--SUBSTR('문자열 또는 컬럼',num1,num2)
--num1부터 num2개만큼 출력
--num1이 양수이면 왼쪽에서 num1부터 num2개만큼 출력
--num1이 음수이면 오른쪽에서 num1부터 num2개만큼 출력
COL "3,2" FOR a6
COL "-3,2" FOR a6
COL "-3,4" FOR a6
SELECT SUBSTR('ABCDE',3,2) "3,2",SUBSTR('ABCDE',-3,2) "-3,2",SUBSTR('ABCDE',-3,4) "-3,4"
FROM dual;
--3,2    -3,2   -3,4
-------- ------ ------
--CD     CD     CDE
SELECT name, jumin , SUBSTR(jumin,3,4) "BIRTHDAY", SUBSTR(jumin,3,4)-1 "BIRTHDAY -1"
from student
WHERE deptno1 = 101;
--NAME            JUMIN               BIRTHDAY       BIRTHDAY -1
----------------- -------------       -------------- -----------
--James Seo       7510231901813       1023                  1022
--Billy Crystal   7601232186327       0123                   122
--Richard Dreyfus 7711291186223       1129                  1128
--Danny Devito    7808192157498       0819                   818

--INSTR(): 주어진 문자열에서 특정 글자의 위치를 찾아주는 함수
--INSTR(문자열 또는 칼럼, char, num(DEFAULT 1))
--문자열 또는 칼럼에서 num번째 글자부터 char의 위치를 찾아 반환
--ex.INSTR('ABADA','A',2) -> 3 (B부터 탐색시작)
--num이 음수이면 오른쪽에서 부터
SELECT 'A-B-C-D', INSTR('A-B-C-D','-')"INSTR"
FROM dual;
--'A-B-C-D'      INSTR
---------------- -----
--A-B-C-D            2
SELECT 'A-B-C-D', INSTR('A-B-C-D','-',3)"INSTR"
FROM dual;
--'A-B-C-D'      INSTR
---------------- -----
--A-B-C-D            4
SELECT 'A-B-C-D', INSTR('A-B-C-D','-',-1)"INSTR"
FROM dual;
--'A-B-C-D'      INSTR
---------------- -----
--A-B-C-D            6
COL name FOR a16
COL tel FOR a14
COL "INSTR" FOR 9
COL "SUBSTR" FOR a4
SELECT name, tel, INSTR(tel,')') "INSTR", SUBSTR(tel,1,INSTR(tel,')')-1) "SUBSTR"
FROM student
WHERE deptno1 = 201;
--NAME             TEL            INSTR SUBS
------------------ -------------- ----- ----
--Demi Moore       02)6255-9875       3 02
--Macaulay Culkin  02)312-9838        3 02
--Wesley Snipes    053)736-4981       4 053
--Steve Martin     02)6175-3945       3 02
--Sean Connery     02)381-5440        3 02
--Christian Slater 031)345-5677       4 031

--LPAD(): 주어진 문자열에서 왼쪽으로 특정문자를 채움
--LPAD('love',6,'*') -> **love
COL name FOR a16
COL ID FOR a10
COL "10LENGTH WITH *" FOR a20
SELECT name, ID, LPAD(ID,10,'*') "10LENGTH WITH *"
FROM student
WHERE deptno1 = 201;
--NAME             ID         10LENGTH WITH *
------------------ ---------- --------------------
--Demi Moore       Moore      *****Moore
--Macaulay Culkin  Culkin     ****Culkin
--Wesley Snipes    Snipes     ****Snipes
--Steve Martin     Martin     ****Martin
--Sean Connery     Connery    ***Connery
--Christian Slater Slater     ****Slater

--LPAD연습문제
--emp테이블, deptno가 10번인 사원들의 ename을 총 9바이트로 출력하되
--빈자리에는 해당 자리의 숫자로 채우시오
--ex.1234CLARK
SELECT LPAD(ename,9,'123456789') "LPAD"
FROM emp
WHERE deptno = 10;
--LPAD
---------------
--1234CLARK
--12345KING
--123MILLER

--RPAD(): 주어진 문자열에서 오른쪽으로 특정문자를 채움
--RPAD('love',6,'*') -> love**
SELECT RPAD(ename,10,'*')
FROM emp
WHERE deptno = 10;
--RPAD(ENAME,10,'*')
------------------
--CLARK*****
--KING******
--MILLER****

--RPAD연습문제
--emp테이블, deptno가 10번인 사원들의 ename을 총 9자리로 출력하되
--오른쪽 빈자리에는 해당 자릿수에 해당되는 숫자를 출력되도록 하세요.
SELECT RPAD(ename,9,SUBSTR('123456789',LENGTH(ename)+1))"RPAD"
FROM emp
WHERE deptno = 10;
--RPAD
------------------
--CLARK6789
--KING56789
--MILLER789

--LTRIM(): 주어진 문자열에서 왼쪽의 특정 문자를 삭제
--LTRIM('*love','*') -> love
--RTRIM(): 주어진 문자열에서 오른쪽의 특정 문자를 삭제
--RTRIM('love*','*') -> love
SELECT ename, LTRIM(ename,'C'), RTRIM(ename,'R')
FROM emp
WHERE deptno = 10;
--ENAME                LTRIM(ENAME,'C')     RTRIM(ENAME,'R')
---------------------- -------------------- --------------------
--CLARK                LARK                 CLARK
--KING                 KING                 KING
--MILLER               MILLER               MILLE

--REPLACE(): 주어진 문자열에서 A를 B로 치환
--REPLACE('AB','A','E') -> EB
SELECT ename, REPLACE(ename,SUBSTR(ename,1,2),'**')"**name"
FROM emp
WHERE deptno = 10;
--ENAME                **name
---------------------- -----------
--CLARK                **ARK
--KING                 **NG
--MILLER               **LLER

--REPLACE연습문제1
--emp테이블, dept가 20, 소속된 직원들의 ename과 2~3번째 글자만 '-'으로 변경하여 출력
SELECT ename, REPLACE(ename,SUBSTR(ename,3,2),'--')"REPLACE"
FROM emp
WHERE deptno = 20;
--ENAME                REPLACE
---------------------- ----------------------------------------
--SMITH                SM--H
--JONES                JO--S
--FORD                 FO--

--REPLACE연습문제2
--student테이블, deptno1이 101, name, jumin과 뒤의 일곱자리가 -와 /로 교대로 출력되게 하시오
SELECT name, jumin, REPLACE(jumin,SUBSTR(jumin,7),'-/-/-/-')"REPLACE"
FROM student
WHERE deptno1 = 101;
--NAME             JUMIN         REPLACE
------------------ ------------- -----------------
--James Seo        7510231901813 751023-/-/-/-
--Billy Crystal    7601232186327 760123-/-/-/-
--Richard Dreyfus  7711291186223 771129-/-/-/-
--Danny Devito     7808192157498 780819-/-/-/-

--REPLACE연습문제3
--student테이블, deptno1이 102, name, tel, 국번을 '*'처리하여 출력
SELECT name, tel, REPLACE(tel,SUBSTR(tel,5,3),'***')"REPLACE"
FROM student
WHERE deptno1 = 102;
--NAME             TEL            REPLACE
------------------ -------------- -----------------
--Rene Russo       051)426-1700   051)***-1700
--Nicholas Cage    051)418-9627   051)***-9627
--Tim Robbins      055)488-2998   055)***-2998
--Charlie Sheen    055)423-9870   055)***-9870

--REPLACE연습문제4
--student테이블, deptno1이 101, name, tel, 지역번호와 국번외의 번호를 '*'처리 출력
SELECT name, tel
	, REPLACE
		(tel
		,SUBSTR(tel,INSTR(tel,'-',-1)+1,LENGTH(SUBSTR(tel,INSTR(tel,'-',-1)+1)))
		--전화번호에서 가장 오른쪽에 있는 '-'의 위치 = INSTR(tel,'-',-1)
		--가장 마지막 번호나열은 = INSTR(tel,'-',-1)+1 부터
		--그 번호나열의 길이는 = LENGTH(SUBSTR(tel,INSTR(tel,'-',-1)+1))
		,'****')
	"REPLACE"
FROM student
WHERE deptno1 = 101;
--NAME             TEL            REPLACE
------------------ -------------- ---------------
--James Seo        055)381-2158   055)381-****
--Billy Crystal    055)333-6328   055)333-****
--Richard Dreyfus  02)6788-4861   02)6788-****
--Danny Devito     055)278-3649   055)278-****
