--XMLAGG
--LISTAGG는 4000BYTE를 넘을경우 오류가 발생한다.
--이 경우 사용하는 것이 XMLAGG
--리턴타입이 VARCHAR2인지 CLOB인지에 따라 형태가 달라지므로 주의

--XMLELEMENT(태그,컬럼)

COL "xml_ename" FOR A30
SELECT deptno, XMLELEMENT(eclass,ename)"xml_ename"
FROM emp;
--    DEPTNO xml_ename
------------ ------------------------------
--        20 <ECLASS>SMITH</ECLASS>
--        30 <ECLASS>ALLEN</ECLASS>
--        30 <ECLASS>WARD</ECLASS>
--        20 <ECLASS>JONES</ECLASS>
--        30 <ECLASS>MARTIN</ECLASS>
--        30 <ECLASS>BLAKE</ECLASS>
--        10 <ECLASS>CLARK</ECLASS>
--        10 <ECLASS>KING</ECLASS>
--        30 <ECLASS>TURNER</ECLASS>
--        30 <ECLASS>JAMES</ECLASS>
--        20 <ECLASS>FORD</ECLASS>
--        10 <ECLASS>MILLER</ECLASS>

COL "xml_ename" FOR A30
SELECT deptno, XMLELEMENT(eclass,',',ename)"xml_ename"
FROM emp;
--    DEPTNO xml_ename
------------ ------------------------------
--        20 <ECLASS>,SMITH</ECLASS>
--        30 <ECLASS>,ALLEN</ECLASS>
--        30 <ECLASS>,WARD</ECLASS>
--        20 <ECLASS>,JONES</ECLASS>
--        30 <ECLASS>,MARTIN</ECLASS>
--        30 <ECLASS>,BLAKE</ECLASS>
--        10 <ECLASS>,CLARK</ECLASS>
--        10 <ECLASS>,KING</ECLASS>
--        30 <ECLASS>,TURNER</ECLASS>
--        30 <ECLASS>,JAMES</ECLASS>
--        20 <ECLASS>,FORD</ECLASS>
--        10 <ECLASS>,MILLER</ECLASS>

--1.
COL "XMLAGG" FOR A100
SELECT deptno
	,XMLAGG(XMLELEMENT(X,',',ename) ORDER BY hiredate)"XMLAGG"
FROM emp
GROUP BY deptno;
--    DEPTNO XMLAGG
------------ ----------------------------------------------------------------------------------------------------
--        10 <X>,CLARK</X><X>,KING</X><X>,MILLER</X>
--        20 <X>,SMITH</X><X>,JONES</X><X>,FORD</X>
--        30 <X>,ALLEN</X><X>,WARD</X><X>,BLAKE</X><X>,TURNER</X><X>,MARTIN</X><X>,JAMES</X>

--2.
COL "XMLAGG" FOR A100
SELECT deptno
	,XMLAGG(XMLELEMENT(X,',',ename) ORDER BY hiredate).EXTRACT('//text()')"XMLAGG"
FROM emp
GROUP BY deptno;
--    DEPTNO XMLAGG
------------ ----------------------------------------------------------------------------------------------------
--        10 ,CLARK,KING,MILLER
--        20 ,SMITH,JONES,FORD
--        30 ,ALLEN,WARD,BLAKE,TURNER,MARTIN,JAMES


--XMLELEMENT(태그,컬럼): 컬럼의 데이터에 태그를 붙혀 XML데이터로 만들어줌
--EXTRACT('//text()'): 텍스트로 추출
--getStringVal(): 문자열로 get함
--SUBSTR: 맨 앞의 쉼표를 제외한 문자열을 출력
COL "XMLAGG" FOR A100
SELECT deptno
	,SUBSTR(
		XMLAGG(XMLELEMENT(X,',',ename) ORDER BY hiredate).EXTRACT('//text()').getStringVal()
	,2)"XMLAGG"
FROM emp
GROUP BY deptno;
--    DEPTNO XMLAGG
------------ ----------------------------------------------------------------------------------------------------
--        10 CLARK,KING,MILLER
--        20 SMITH,JONES,FORD
--        30 ALLEN,WARD,BLAKE,TURNER,MARTIN,JAMES


--유형2. 직업별로 직원들의 이름을 하나의 ROW로 출력. 순서는 월급순

--1. 직원들의 이름 앞뒤로 태그를 붙혀줌
--XMLELEMENT(태그,'구분자',컬럼): 컬럼의 데이터에 태그를 붙혀 XML데이터로 만들어줌
COL "NAME" FOR A50
SELECT job, XMLELEMENT(NAME,'-',ename)"NAME"
FROM emp;
--JOB                NAME
-------------------- --------------------------------------------------
--CLERK              <NAME>-SMITH</NAME>
--SALESMAN           <NAME>-ALLEN</NAME>
--SALESMAN           <NAME>-WARD</NAME>
--MANAGER            <NAME>-JONES</NAME>
--SALESMAN           <NAME>-MARTIN</NAME>
--MANAGER            <NAME>-BLAKE</NAME>
--MANAGER            <NAME>-CLARK</NAME>
--PRESIDENT          <NAME>-KING</NAME>
--SALESMAN           <NAME>-TURNER</NAME>
--CLERK              <NAME>-JAMES</NAME>
--ANALYST            <NAME>-FORD</NAME>
--CLERK              <NAME>-MILLER</NAME>

--2. 직업별로 직원들의 이름을 하나의 ROW로 출력
--XMLAGG(컬럼1 ORDER BY 컬럼2): 컬럼1을 컬럼2의 순서로 정렬하여 하나의 ROW에 출력
COL "NAME" FOR A80
SELECT job, XMLAGG(XMLELEMENT(NAME,'-',ename)ORDER BY sal)"NAME"
FROM emp
GROUP BY job;
--JOB                NAME
-------------------- --------------------------------------------------------------------------------
--ANALYST            <NAME>-FORD</NAME>
--CLERK              <NAME>-SMITH</NAME><NAME>-JAMES</NAME><NAME>-MILLER</NAME>
--MANAGER            <NAME>-CLARK</NAME><NAME>-BLAKE</NAME><NAME>-JONES</NAME>
--PRESIDENT          <NAME>-KING</NAME>
--SALESMAN           <NAME>-WARD</NAME><NAME>-MARTIN</NAME><NAME>-TURNER</NAME><NAME>-ALLEN</NAME>

--3. 태그를 제외한 데이터만 뽑아서 출력
--EXTRACT('//text()')
COL "NAME" FOR A50
SELECT job, XMLAGG(XMLELEMENT(NAME,'-',ename)ORDER BY sal).EXTRACT('//text()')"NAME"
FROM emp
GROUP BY job;
--JOB                NAME
-------------------- --------------------------------------------------
--ANALYST            -FORD
--CLERK              -SMITH-JAMES-MILLER
--MANAGER            -CLARK-BLAKE-JONES
--PRESIDENT          -KING
--SALESMAN           -WARD-MARTIN-TURNER-ALLEN

--4. 맨 앞의 구분자 - 를제거
--getStringVal(): 문자열로 받음
--SUBSTR: 맨 앞의 - 구분자를 제외한 문자열을 출력
COL "NAME" FOR A50
SELECT job
	, SUBSTR(
		XMLAGG(XMLELEMENT(NAME,'-',ename)ORDER BY sal).EXTRACT('//text()').getStringVal() 
	,2)"NAME"
FROM emp
GROUP BY job;
--JOB                NAME
-------------------- --------------------------------------------------
--ANALYST            FORD
--CLERK              SMITH-JAMES-MILLER
--MANAGER            CLARK-BLAKE-JONES
--PRESIDENT          KING
--SALESMAN           WARD-MARTIN-TURNER-ALLEN
