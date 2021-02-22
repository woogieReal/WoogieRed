set linesize 200;
set pagesize 100;

--���̺� ����
--CREATE TABLE o_table(
--	a NUMBER,
--	b NUMBER
--);

--�� ����
CREATE OR REPLACE VIEW view1
AS 
SELECT a, b
FROM o_table
;

--�信 ������ �Է�
--INSERT INTO view1 VALUES(1,2);

--���� ������ Ȯ��
--SELECT *
--FROM view1
--;
--         A          B
------------ ----------
--         1          2
		 
--���̺��� ������ Ȯ��
--SELECT *
--FROM o_table
--;
--         A          B
------------ ----------
--         1          2

--WITH READ ONLY
--�б����� �� ����
CREATE OR REPLACE VIEW view2
AS
SELECT a,b
FROM o_table
WITH READ ONLY
;

--�б����� �信 ������ �ԷºҰ�
INSERT INTO view2 VALUES(1,2)
;
--ORA-42399: cannot perform a DML operation on a read-only view

--���̺� ������ �Է��� view�� ���� ��ȸ
INSERT INTO o_table VALUES(1,2)
;
SELECT * FROM view2
;
--         A          B
------------ ----------
--         1          2

--WITH CHECK OPTION
--�־��� �������ǿ� �´� �����͸� �Է� ����
INSERT INTO view1 VALUES(3,4)
;

--���̺��� ������ ��ȸ
select *
from o_table
;
--         A          B
------------ ----------
--         1          2
--         3          4

CREATE OR REPLACE VIEW view3
AS
SELECT a,b
FROM o_table
WHERE a = 3
WITH CHECK OPTION
;

select * from view3
;
--         A          B
------------ ----------
--         3          4

UPDATE view3
SET b = 5
WHERE a = 1
;
--0 rows updated.

--COMPLEX_VIEW
--���� ���� ���̺��� ���εǾ ����
--INTERSECT, MINUS, UNION ���� ���տ����ڴ� ���X(��������)
--emp, dept join�� v_emp
CREATE OR REPLACE VIEW v_emp
AS
SELECT t1.ename, t2.dname
FROM emp t1, dept t2
WHERE t1.deptno = t2.deptno
;

--view��ȸ
SELECT *
FROM v_emp
;
--ENAME                DNAME
---------------------- ----------------------------
--SMITH                RESEARCH
--ALLEN                SALES
--WARD                 SALES
--JONES                RESEARCH
--MARTIN               SALES
--BLAKE                SALES
--CLARK                ACCOUNTING
--KING                 ACCOUNTING
--TURNER               SALES
--JAMES                SALES
--FORD                 RESEARCH
--MILLER               ACCOUNTING

--INLINE_VIEW
--1ȸ�� ��
--FROM���� VIEW�� SUBQUERY�� �ٷ� ��� ���

--emp�� dept ���̺��� ��ȸ�Ͽ� �μ���ȣ, �μ��� �ִ�޿� �� �μ���
SELECT t1.deptno,
	t2.dname,
	t1.sal
FROM(
	SELECT deptno,MAX(sal) sal
	FROM emp
	GROUP BY deptno
)t1, dept t2
WHERE t1.deptno = t2.deptno
;
--    DEPTNO DNAME                 SAL
------------ -------------- ----------
--        30 SALES                2850
--        20 RESEARCH             3000
--        10 ACCOUNTING           5000

--professor ���̺��� lag�� inline view�� Ȱ���ؼ� �ߺ��� �׸��� �����ؼ� �����ֱ�
--�ߺ��� deptno �����ϰ� ���
SELECT deptno,
	profno,
	name
FROM professor
;

SELECT DECODE(deptno, ndeptno, null, deptno) deptno, profno, name
FROM(
	SELECT LAG(deptno) OVER(order by deptno) ndeptno, 
	deptno, 
	profno, 
	name
	FROM professor
)t1
;
--DEPTNO    PROFNO NAME                
---------- ------- --------------------
--101         1001 Audie Murphy        
--            1002 Angela Bassett      
--            1003 Jessica Lange       
--102         2001 Winona Ryder        
--            2002 Michelle Pfeiffer   
--            2003 Whoopi Goldberg     
--103         3001 Emma Thompson       
--            3002 Julia Roberts       
--            3003 Sharon Stone        
--201         4001 Meryl Streep        
--            4002 Susan Sarandon      
--202         4003 Nicole Kidman       
--            4004 Holly Hunter        
--203         4005 Meg Ryan            
--301         4006 Andie Macdowell     
--            4007 Jodie Foster      

--user_views: ����ڰ� ������ view��ȸ
--dba_views: ��� ����ڰ� ������ view ��ȸ
DROP VIEW v_emp
;

--MATERIALIZED_VIEW
--��� �����͸� ������ �ʰ� SQL������ ������ �ֱ⿡ �ش� ���̺� ���� �����͸� ������ �� 
--����ڿ��� �����͸� ��ȯ�ϰ� �����͸� �����ϴ� �� ��뷮 ���� ��� ���� �̽��� �߻���
--�׷��� �����͸� ������ �ִ� Mview�� ����Ѵ�.

--���Ѽ���
GRANT QUERY REWRITE TO SCOTT;
GRANT CREATE MATERIALIZED VIEW TO SCOTT;

--MVIEW ����
CREATE MATERIALIZED VIEW m_prof
BUILD IMMEDIATE
REFRESH
ON DEMAND
COMPLETE
ENABLE QUERY REWRITE
AS
SELECT profno, name, pay
FROM professor
;

--BUILD IMMEDIATE: ���������� �����ϸ鼭 �����͸� ��������
--ON DEMAND: ����ڰ� �������� ������ ����ȭ
--ON COMMIT: ���� ���̺� ���� �� COMMIT�� �߻��ϸ� �ڵ����� ����ȭ
--COMPLETE: MVIEW ���� ������ ��ü�� ���� ���̺�� ����ȭ �Ǵ� ���
--ATOMIC_REFRESH = TRUE�� COMPLETE�� ���� �Ǿ� �־����
--�����Ͱ� ���� ��� �ð��� ���� �ҿ�
--FAST: ���� ���̺� ���ο� �����Ͱ� �Էµ� ��� �� �κи� MVIEW�� ����ȭ
--FORCE: FAST����� �������� ���캸�� �Ұ����ϸ� COMPLETE����� ����ڰ�
--NEVER: ����ȭ ���� ����

--MVIEW ���� �����Ͱ� �����ϱ� ������ index�� ��������
CREATE INDEX idx_m_prof_pay
ON m_prof(pay ASC)
;

--MVIEW ����
--�����ɼǿ��� ON COMMIT�� �����ϸ� ��� ����ȭ�� �ǳ� �뷮�� �����Ͱ� ����� ��� ū ���ϸ� ����
BEGIN
	DBMS_MVIEW.REFRESH('���̸�');
END;
/

--��� Mview�� ����ȭ�ϴ� ����
EXEC DMBS_MVIEW.REFRESH_ALL_MVIEW
;

