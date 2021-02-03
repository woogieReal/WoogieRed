--COUNT:�Էµ������� �� �Ǽ� ���
--������ �Լ��� *�� ����ϸ� NULL�� ����
--������ �Լ��� �̸��� ���� NULL�� �������� ����
SELECT COUNT(*), COUNT(comm)
FROM emp;
--  COUNT(*) COUNT(COMM)
------------ -----------
--        12           4

--SUM:�Էµ������� �հ�
SELECT SUM(comm)"SUM_comm"
	,COUNT(comm)"COUNT_comm"
FROM emp;
--  SUM_comm COUNT_comm
------------ ----------
--      2200          4

--AVG: �Էµ������� ���
--��ü�ο��� ���� ����� ���ϱ� ���ؼ��� 
SELECT AVG(comm)"WRONG"
	,AVG(NVL(comm,0))"CORRECT"
	,ROUND(AVG(NVL(comm,0)),2)"ROUND"
FROM emp;
--     WRONG    CORRECT      ROUND
------------ ---------- ----------
--       550 183.333333     183.33

--MAX | MIN: �Էµ������� �ִ밪&�ּҰ�
--���������� ORDER BY�� ������ ���� ����
SELECT MAX(sal),MIN(sal)
FROM emp;
--  MAX(SAL)   MIN(SAL)
------------ ----------
--      5000        800

--VARIANCE: �Էµ������� �л�
--�л��̶� ��տ� ���� ���������� ����� ���� ���̴�.
--STDDEV: �Էµ������� ǥ������
--ǥ�������� �л��� ���� ���������� ���ǵȴ�.
SELECT VARIANCE(sal),STDDEV(sal),AVG(NVL(sal,0))
FROM emp;
--VARIANCE(SAL) STDDEV(SAL) AVG(NVL(SAL,0))
--------------- ----------- ---------------
--   1488347.54   1219.9785      2077.08333

--GROUP_BY: Ư���������� �������� �׷��� ����
--����: GROUP BY �ڿ����� �÷����� �������� ���� �����͸� ��Ƴ���,
--SELECT���� �ִ� �׷��Լ��� ����.

--GROUP BY ���ǻ���
--SELECT���� ���� �׷��Լ� �̿��� Į���̳� ǥ������ GROUP BY���� ���Ǿ�� �Ѵ�.
--GROUP BY������ �ݵ�� �÷����� ���Ǿ�� �Ѵ�.
SELECT deptno,AVG(NVL(sal,0))"AVERAGE"
FROM emp
GROUP BY deptno;
--    DEPTNO    AVERAGE
------------ ----------
--        30 1566.66667
--        20 2258.33333
--        10 2916.66667

--GROUP BY 2��
SELECT deptno, job, AVG(NVL(sal,0))"AVERAGE"
FROM emp
GROUP BY deptno, job
ORDER BY 1,3 DESC;
--    DEPTNO JOB                   AVERAGE
------------ ------------------ ----------
--        10 PRESIDENT                5000
--        10 MANAGER                  2450
--        10 CLERK                    1300
--        20 ANALYST                  3000
--        20 MANAGER                  2975
--        20 CLERK                     800
--        30 MANAGER                  2850
--        30 SALESMAN                 1400
--        30 CLERK                     950

--HAVING: �׷����� �������� �˻�
SELECT deptno, AVG(NVL(sal,0))"AVERAGE"
FROM emp
GROUP BY deptno
HAVING AVG(NVL(sal,0)) > 2000
ORDER BY 1;
--    DEPTNO    AVERAGE
------------ ----------
--        10 2916.66667
--        20 2258.33333

--�м��Լ�(ANALYTIC FUNCTION, WINDOW FUNCTION)
--ROLLUP: �Էµ������� �Ұ踦 ����� ���
--ROLLUP�� ������ �÷����� �Ұ��� ������ �Ǵ� �÷��̴�.
--N+1 LEVEL�� �Ұ����

--����1. �μ��� ���޺� ��ձ޿� �� ���, �μ��� �� �޿��� ��� ��, ��ü ����� ��ձ޿��� ����� 
--
--�μ��� ���޺� ��ձ޿� �� ��� ��
--UNION ALL
--�μ��� �� �޿��� ��� ��
--UNION ALL
--��ü ����� ��ձ޿��� �����
--
--1. �μ��� ���޺� ��ձ޿� �� ��� ��
SELECT deptno
	, job
	, AVG(NVL(sal,0))"AVERAGE"
	, COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno, job;
--    DEPTNO JOB                   AVERAGE THE NUMBER OF EMPLOYEE
------------ ------------------ ---------- ----------------------
--        20 CLERK                     800                      1
--        30 SALESMAN                 1400                      4
--        20 MANAGER                  2975                      1
--        30 CLERK                     950                      1
--        10 PRESIDENT                5000                      1
--        30 MANAGER                  2850                      1
--        10 CLERK                    1300                      1
--        10 MANAGER                  2450                      1
--        20 ANALYST                  3000                      1

--2. �μ��� �� �޿��� ��� ��
SELECT deptno
	, NULL job
	, AVG(NVL(sal,0))"AVERAGE"
	, COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno;
--    DEPTNO J    AVERAGE THE NUMBER OF EMPLOYEE
------------ - ---------- ----------------------
--        30   1566.66667                      6
--        20   2258.33333                      3
--        10   2916.66667                      3

--3. ��ü ����� ��ձ޿��� �����
SELECT NULL deptno
	, NULL job
	, AVG(NVL(sal,0))"AVERAGE"
	, COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
ORDER BY deptno, job;
--D J    AVERAGE THE NUMBER OF EMPLOYEE
--- - ---------- ----------------------
--    2077.08333                     12

--UNION ALL�� ���
SELECT deptno, job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno, job
UNION ALL
SELECT deptno, NULL job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL deptno, NULL job, AVG(NVL(sal,0))"AVERAGE", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
ORDER BY deptno, job;
--    DEPTNO JOB                   AVERAGE THE NUMBER OF EMPLOYEE
------------ ------------------ ---------- ----------------------
--        10 CLERK                    1300                      1
--        10 MANAGER                  2450                      1
--        10 PRESIDENT                5000                      1
--        10                    2916.66667                      3
--        20 ANALYST                  3000                      1
--        20 CLERK                     800                      1
--        20 MANAGER                  2975                      1
--        20                    2258.33333                      3
--        30 CLERK                     950                      1
--        30 MANAGER                  2850                      1
--        30 SALESMAN                 1400                      4
--        30                    1566.66667                      6
--                              2077.08333                     12

--ROLLUP�� ���
--deptno,job �� ���� �־����Ƿ� 3���� LEVEL�� ���´�.
--�μ��� ���, ���޺� ���, �� ��� 3��
SELECT deptno, job, AVG(NVL(sal,0))"AVG", COUNT(*)"THE NUMBER OF EMPLOYEE"
FROM emp
GROUP BY ROLLUP(deptno,job); 
--    DEPTNO JOB                       AVG THE NUMBER OF EMPLOYEE
------------ ------------------ ---------- ----------------------
--        10 CLERK                    1300                      1
--        10 MANAGER                  2450                      1
--        10 PRESIDENT                5000                      1
--        10                    2916.66667                      3
--        20 CLERK                     800                      1
--        20 ANALYST                  3000                      1
--        20 MANAGER                  2975                      1
--        20                    2258.33333                      3
--        30 CLERK                     950                      1
--        30 MANAGER                  2850                      1
--        30 SALESMAN                 1400                      4
--        30                    1566.66667                      6
--                              2077.08333                     12

--����2. 
--���޺� �հ�
SELECT position
	, SUM(pay)
FROM professor
GROUP BY position;
--POSITION                                                       SUM(PAY)
-------------------------------------------------------------- ----------
--instructor                                                         1290
--assistant professor                                                1990
--a full professor                                                   2640

--�μ���ȣ�� ������ ���޺� �հ�
COL position FOR A20
SELECT deptno
	, position
	, COUNT(*)
	, SUM(pay)
FROM professor
GROUP BY position, ROLLUP(deptno);
--    DEPTNO POSITION               COUNT(*)   SUM(PAY)
------------ -------------------- ---------- ----------
--       101 instructor                    1        270
--       102 instructor                    1        250
--       103 instructor                    1        290
--       202 instructor                    1        260
--       301 instructor                    1        220
--           instructor                    5       1290
--       101 a full professor              1        550
--       102 a full professor              1        490
--       103 a full professor              1        530
--       201 a full professor              1        570
--       203 a full professor              1        500
--           a full professor              5       2640
--       101 assistant professor           1        380
--       102 assistant professor           1        350
--       103 assistant professor           1        330
--       201 assistant professor           1        330
--       202 assistant professor           1        310
--       301 assistant professor           1        290
--           assistant professor           6       1990

--������ ������ �μ��� �հ�
COL position FOR A20
SELECT deptno
	, position
	, COUNT(*)
	, SUM(pay)
FROM professor
GROUP BY deptno, ROLLUP(position);
--    DEPTNO POSITION               COUNT(*)   SUM(PAY)
------------ -------------------- ---------- ----------
--       101 instructor                    1        270
--       101 a full professor              1        550
--       101 assistant professor           1        380
--       101                               3       1200
--       102 instructor                    1        250
--       102 a full professor              1        490
--       102 assistant professor           1        350
--       102                               3       1090
--       103 instructor                    1        290
--       103 a full professor              1        530
--       103 assistant professor           1        330
--       103                               3       1150
--       201 a full professor              1        570
--       201 assistant professor           1        330
--       201                               2        900
--       202 instructor                    1        260
--       202 assistant professor           1        310
--       202                               2        570
--       203 a full professor              1        500
--       203                               1        500
--       301 instructor                    1        220
--       301 assistant professor           1        290
--       301                               2        510

--CUBE: �Էµ������� �Ұ� �� ��ü �Ѱ踦 ���
--GROUP BY CUBE(�÷�1, �÷�2, ....)
--2^n LEVEL�� �Ұ����
--��� ��쿡 ���� �Ұ踦 ���ϱ� ������ �÷��� ������ �߿����� ����

--�μ��� ��ձ޿��� �����, ���޺� ��ձ޿��� �����, �μ��� ���޺� ��ձ޿��� �����, ��ü ��� �޿��� �����
--1. �μ��� ��ձ޿��� �����
--UNION ALL
--2. ���޺� ��ձ޿��� �����
--UNION ALL
--3. �μ��� ���޺� ��ձ޿��� �����
--UNION ALL
--4. ��ü ��� �޿��� �����
----> CUBE

--1. �μ��� ��ձ޿��� �����
SELECT deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno;
--    DEPTNO JOB                     AVERAGE   COUNT(*)
------------ -------------------- ---------- ----------
--        30                          1566.7          6
--        20                          2258.3          3
--        10                          2916.7          3

--2. ���޺� ��ձ޿��� �����
SELECT NULL deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY job;
--D JOB                   AVERAGE   COUNT(*)
--- ------------------ ---------- ----------
--  CLERK                  1016.7          3
--  SALESMAN                 1400          4
--  PRESIDENT                5000          1
--  MANAGER                2758.3          3
--  ANALYST                  3000          1

--3. �μ��� ���޺� ��ձ޿��� �����
SELECT deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno,job;
--    DEPTNO JOB                   AVERAGE   COUNT(*)
------------ ------------------ ---------- ----------
--        20 CLERK                     800          1
--        30 SALESMAN                 1400          4
--        20 MANAGER                  2975          1
--        30 CLERK                     950          1
--        10 PRESIDENT                5000          1
--        30 MANAGER                  2850          1
--        10 CLERK                    1300          1
--        10 MANAGER                  2450          1
--        20 ANALYST                  3000          1

--4. ��ü ��� �޿��� �����
SELECT NULL deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp;
--D J    AVERAGE   COUNT(*)
--- - ---------- ----------
--        2077.1         12

--UNIONALL�� ������ CUBE�� ����
SELECT deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY job
UNION ALL
SELECT deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY deptno,job
UNION ALL
SELECT NULL deptno, NULL job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
ORDER BY deptno, job;
--    DEPTNO JOB                   AVERAGE   COUNT(*)
------------ ------------------ ---------- ----------
--        30                        1566.7          6
--        20                        2258.3          3
--        10                        2916.7          3
--           CLERK                  1016.7          3
--           SALESMAN                 1400          4
--           PRESIDENT                5000          1
--           MANAGER                2758.3          3
--           ANALYST                  3000          1
--        20 CLERK                     800          1
--        30 SALESMAN                 1400          4
--        20 MANAGER                  2975          1
--        30 CLERK                     950          1
--        10 PRESIDENT                5000          1
--        30 MANAGER                  2850          1
--        10 CLERK                    1300          1
--        10 MANAGER                  2450          1
--        20 ANALYST                  3000          1
--                                  2077.1         12

--CUBE ��뿹
SELECT deptno, job, ROUND(AVG(NVL(sal,0)),1)"AVERAGE", COUNT(*)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;
--    DEPTNO JOB                   AVERAGE   COUNT(*)
------------ ------------------ ---------- ----------
--        10 CLERK                    1300          1
--        10 MANAGER                  2450          1
--        10 PRESIDENT                5000          1
--        10                        2916.7          3
--        20 ANALYST                  3000          1
--        20 CLERK                     800          1
--        20 MANAGER                  2975          1
--        20                        2258.3          3
--        30 CLERK                     950          1
--        30 MANAGER                  2850          1
--        30 SALESMAN                 1400          4
--        30                        1566.7          6
--           ANALYST                  3000          1
--           CLERK                  1016.7          3
--           MANAGER                2758.3          3
--           PRESIDENT                5000          1
--           SALESMAN                 1400          4
--                                  2077.1         12







