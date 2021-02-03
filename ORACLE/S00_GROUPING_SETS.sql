--GROUPING_SETS: �׷��� ������ �������� ��� �����ϰ� ��밡��
--GROUPING SETS(expr1,expr2,expr3......)
--�г⺰�� �л����� �ο���, �а����� �ο����� �� ���̺�� ���

--UNION ALL�� GROUPING SETS ��������
SELECT grade, COUNT(*)
FROM student
GROUP BY grade
UNION ALL
SELECT deptno1, COUNT(*)
FROM student
GROUP BY deptno1;
--     GRADE   COUNT(*)
------------ ----------
--         1          5
--         2          5
--         4          5
--         3          5
--       102          4
--       201          6
--       301          2
--       101          4
--       202          2
--       103          2

--�г⺰�� �л����� �ο���, �а����� �ο����� �� ���̺�� ���
SELECT grade, deptno1, COUNT(*)
FROM student
GROUP BY GROUPING SETS(grade, deptno1);
--     GRADE    DEPTNO1   COUNT(*)
------------ ---------- ----------
--                  102          4
--                  201          6
--                  301          2
--                  101          4
--                  202          2
--                  103          2
--         1                     5
--         2                     5
--         4                     5
--         3                     5

--�г⺰�� �ο���, Ű ���, ������ ����� ����
--�� ��� GROUP�� �ϳ��̱� ������ GROUP BY�� ����
SELECT grade
	,COUNT(*)"NUMBER"
	,ROUND(AVG(NVL(height,0)))"AVG_HEIGHT"
	,ROUND(AVG(NVL(weight,0)))"AVG_WEIGHT"
FROM student
GROUP BY grade;
--     GRADE     NUMBER AVG_HEIGHT AVG_WEIGHT
------------ ---------- ---------- ----------
--         1          5        170         62
--         2          5        176         67
--         4          5        176         68
--         3          5        167         51

--�г⺰ + �а����� �ο���, Ű ���, ������ ����� ���Ұ��
--GROUPING SETS�� �̿��ϸ� �� ���̺� �����ϰ� ��°���
SELECT grade, deptno1
	,COUNT(*)"NUMBER"
	,ROUND(AVG(NVL(height,0)))"AVG_HEIGHT"
	,ROUND(AVG(NVL(weight,0)))"AVG_WEIGHT"
FROM student
GROUP BY GROUPING SETS(grade, deptno1);
--     GRADE    DEPTNO1     NUMBER AVG_HEIGHT AVG_WEIGHT
------------ ---------- ---------- ---------- ----------
--                  102          4        171         64
--                  201          6        173         67
--                  301          2        172         60
--                  101          4        172         60
--                  202          2        180         63
--                  103          2        166         52
--         1                     5        170         62
--         2                     5        176         67
--         4                     5        176         68
--         3                     5        167         51


