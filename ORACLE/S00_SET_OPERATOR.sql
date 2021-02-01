--���տ�����
--������ UNION(�ߺ������ſ� ����), UNION ALL(�׳� ��ħ)
--������ INTERSECT
--������ MINUS + ����

--���տ����� �������
--1.�� ������ SELECT ���� ���� �÷��� ����
--2.�� ������ SELECT ���� ���� ������Ÿ�� ����
--3.�� ������ SELECT ���� ���� �÷����� �޶� ��

--1.UNION -> �ߺ������ſ� ����
--ORDER BY�� �� �ֱ⶧���� ���� ���� ����
SELECT studno,name
FROM student
WHERE deptno1 = 101
UNION
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9411 James Seo
--      9511 Billy Crystal
--      9512 Nicholas Cage
--      9611 Richard Dreyfus
--      9711 Danny Devito

--2.UNION ALL -> �׳���ħ
SELECT studno,name
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9411 James Seo
--      9511 Billy Crystal
--      9611 Richard Dreyfus
--      9711 Danny Devito
--      9411 James Seo
--      9512 Nicholas Cage

--3.INTERSECT -> ������
SELECT studno,name
FROM student
WHERE deptno1 = 101
INTERSECT
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9411 James Seo

--4.MINUS -> ������
SELECT studno,name
FROM student
WHERE deptno1 = 101
MINUS
SELECT studno,name
FROM student
WHERE deptno2 = 201;
--    STUDNO NAME
------------ ------------------------------------------------------------
--      9511 Billy Crystal
--      9611 Richard Dreyfus
--      9711 Danny Devito