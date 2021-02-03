--XMLAGG
--LISTAGG�� 4000BYTE�� ������� ������ �߻��Ѵ�.
--�� ��� ����ϴ� ���� XMLAGG
--����Ÿ���� VARCHAR2���� CLOB������ ���� ���°� �޶����Ƿ� ����

--XMLELEMENT(�±�,�÷�)

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


--XMLELEMENT(�±�,�÷�): �÷��� �����Ϳ� �±׸� ���� XML�����ͷ� �������
--EXTRACT('//text()'): �ؽ�Ʈ�� ����
--getStringVal(): ���ڿ��� get��
--SUBSTR: �� ���� ��ǥ�� ������ ���ڿ��� ���
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


--����2. �������� �������� �̸��� �ϳ��� ROW�� ���. ������ ���޼�

--1. �������� �̸� �յڷ� �±׸� ������
--XMLELEMENT(�±�,'������',�÷�): �÷��� �����Ϳ� �±׸� ���� XML�����ͷ� �������
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

--2. �������� �������� �̸��� �ϳ��� ROW�� ���
--XMLAGG(�÷�1 ORDER BY �÷�2): �÷�1�� �÷�2�� ������ �����Ͽ� �ϳ��� ROW�� ���
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

--3. �±׸� ������ �����͸� �̾Ƽ� ���
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

--4. �� ���� ������ - ������
--getStringVal(): ���ڿ��� ����
--SUBSTR: �� ���� - �����ڸ� ������ ���ڿ��� ���
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
