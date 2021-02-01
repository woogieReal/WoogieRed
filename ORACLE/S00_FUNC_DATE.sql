--SYSDATE: �ý����� ���� ��¥�� �ð�
--ALTER SESSION SET NLS_DATE_FORMAT = 'RRRR-MM-DD:HH24:MI:SS';
--����Ʈ ������ �ٲ���
SELECT SYSDATE
FROM dual;
--SYSDATE
---------------------
--2021-02-01:09:19:49

--MONTHS_BETWEEN: �� ��¥ ������ ���� ��
SELECT MONTHS_BETWEEN('2021/04/14','2021/02/01')"SUBTRACT"
	,MONTHS_BETWEEN('2021/02/01','2021/04/01')"SUBTRACT2"
	,MONTHS_BETWEEN('2021/02/01','2021/02/01')"SUBTRACT3"
FROM dual;
--  SUBTRACT  SUBTRACT2  SUBTRACT3
------------ ---------- ----------
--2.41935484         -2          0

--ADD_MONTHS: �־��� ��¥�� ������ ����
COL "ADD_ONE_MONTH" FOR a15
COL "SUBTRACT_TWO_MONTH" FOR a20
SELECT SYSDATE
	,ADD_MONTHS(SYSDATE, 1)"ADD_ONE_MONTH"
	,ADD_MONTHS(SYSDATE, -2)"SUBTRACT_TWO_MONTH"
FROM dual;	
--SYSDATE  ADD_ONE_MONTH   SUBTRACT_TWO_MONTH
---------- --------------- --------------------
--21/02/01 21/03/01        20/12/01

--NEXT_DAY: �־��� ��¥�� �������� ���ƿ��� ��¥ ���
--WINDOWS: NEXT_DAY(SYSDATE,'��')
--UNIX: NEXT_DAY(SYSDATE,'WED')
SELECT SYSDATE
	,NEXT_DAY(SYSDATE,'��')
FROM dual;
--SYSDATE  NEXT_DAY
---------- --------
--21/02/01 21/02/03

--LAST_DAY: �־��� ��¥�� ���� ���� ������ ��¥���
SELECT SYSDATE
	,LAST_DAY(SYSDATE)
FROM dual;
--SYSDATE  LAST_DAY
---------- --------
--21/02/01 21/02/28

--ROUND: �־��� ��¥�� �ݿø�
--��)��ǰ���� �� ���(12:00 ���� �� ������)
--TRUNC: �־��� ��¥�� ����
--��)��������(������ ����)
SELECT SYSDATE
	,ROUND(SYSDATE)
	,TRUNC(SYSDATE)
FROM dual;
--SYSDATE  ROUND(SYSDATE)
---------- ---------------
--21/02/01 21/02/01

--EXTRACT: ��¥���� ��,��,�� ����
SELECT ename, hiredate
	,EXTRACT(YEAR FROM hiredate)"�Ի�⵵"
	,EXTRACT(MONTH FROM hiredate)"�Ի��"
	,EXTRACT(DAY FROM hiredate)"�Ի���"
FROM emp;
--ENAME                HIREDATE   �Ի�⵵     �Ի��     �Ի���
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

