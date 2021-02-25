--
SELECT SEQUENCE_NAME
	,MIN_VALUE
	,MAX_VALUE
	,INCREMENT_BY
	,CYCLE_FLAG
	,ORDER_FLAG
	,CACHE_SIZE
	,LAST_NUMBER
FROM user_sequences
WHERE sequence_name = 'JNO_SEQ'
;
SEQUENCE_NAME        MIN_VALUE  MAX_VALUE INCREMENT_BY CY OR CACHE_SIZE LAST_NUMBER
------------------- ---------- ---------- ------------ -- -- ---------- -----------
JNO_SEQ                     90        110            1 Y  N           2          91

--������ ����
DROP SEQUENCE jno_seq;

--SYNONYM(���Ǿ� OR ��Ī)
--1. ����(�ٸ� ������ ��ü(ex.���̺�)�� ������ �� ���� ���)
--2. ����� ���Ǽ�(�� �̸��� ��ü�� �����̸����� ���)

--SYNONYM �������� �ʿ�

--����
--CREATE [PUBLIC] SYNONYM �ó��_�̸�
--FOR [SCOTT] ���ü;

--PUBLIC�� ������ ��� ����� ��밡��(�� ���� �ʿ�)
--PUBLIC�� ������ ���� ����� ��밡�� 

--1. ������ȯ
conn /as sysdba;

--2. �����Ҵ�
--PRIVATE
GRANT CREATE SYNONYM TO SCOTT
;
--Grant succeeded.

--PUBLIC
GRANT CREATE PUBLIC SYNONYM TO SCOTT
;
--Grant succeeded.

--3. ������ȯ
conn scott/sist;

--4. PUBLIC SYNONYM ����
CREATE PUBLIC SYNONYM d2
FOR dept
; 
--Synonym created.

--5. SYNONYM���� ��ȸ
SELECT * FROM d2
;
--  DEPTNO DNAME                        LOC
---------- ---------------------------- --------------------
--      10 ACCOUNTING                   NEW YORK
--      20 RESEARCH                     DALLAS
--      30 SALES                        CHICAGO
--      40 OPERATIONS                   BOSTON

--6. PUBLIC SYNONYM ��ȸ�ϱ�
--PUBLIC SYNONYM�� dba_synonyms ���̺����� ��ȸ����
DESC user_synonyms;

SELECT synonym_name
	,table_name
	,table_owner
FROM dba_synonyms
WHERE TABLE_NAME = 'DEPT'
;
--SYNONYM_NAME      TABLE_NAME      TABLE_OWNER
------------------- --------------- ---------------
--D2                DEPT            SCOTT

--7. PRIVATE SYNONYM ����
CREATE SYNONYM e
FOR emp
;

--8. PRIVATE SYNONYM���� ��ȸ
SELECT * FROM e
;
--  EMPNO ENAME      JOB               MGR HIREDATE        SAL       COMM     DEPTNO
--------- ---------- ---------- ---------- -------- ---------- ---------- ----------
--   7369 SMITH      CLERK            7902 80/12/17        800                    20
--   7499 ALLEN      SALESMAN         7698 81/02/20       1600        300         30
--   7521 WARD       SALESMAN         7698 81/02/22       1250        500         30
--   7566 JONES      MANAGER          7839 81/04/02       2975                    20
--   7654 MARTIN     SALESMAN         7698 81/09/28       1250       1400         30
--   7698 BLAKE      MANAGER          7839 81/05/01       2850                    30
--   7782 CLARK      MANAGER          7839 81/06/09       2450                    10
--   7839 KING       PRESIDENT             81/11/17       5000                    10
--   7844 TURNER     SALESMAN         7698 81/09/08       1500          0         30
--   7900 JAMES      CLERK            7698 81/12/03        950                    30
--   7902 FORD       ANALYST          7566 81/12/03       3000                    20
--   7934 MILLER     CLERK            7782 82/01/23       1300                    10

--8. PRIVATE SYNONYM ��ȸ�ϱ�
--PRIVATE SYNONYM�� dba_synonyms ���̺�� user_synonyms ���̺� ���ʿ��� ��� ��ȸ����
SELECT synonym_name
	,table_name
	,table_owner
FROM user_synonyms
WHERE TABLE_NAME = 'EMP'
;
--SYNONYM_NAME       TABLE_NAME      TABLE_OWNER
-------------------- --------------- --------------
--E                  EMP             SCOTT


--SYNONYM ����
DROP SYNONYM scott.e;


















