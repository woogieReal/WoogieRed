
--Sub Query(��������)
--�ϳ��� �����ȿ� �� �ٸ� ������ �ִ� ��
--SELECT COLUMN                  <- ��������(outer ����)
--FROM TABLE
--WHERE ���� (SELECT COLUMN FROM TABLE WHERE ����)             <- ��������(inner ����)
SELECT ename,
	comm
FROM emp
WHERE comm < (
	SELECT comm
	FROM emp
	WHERE ename = 'WARD'
	)
;
--ENAME                      COMM
---------------------- ----------
--ALLEN                       300
--TURNER                        0

--���������� ����
--1. ������ ��������: ���������� ������ ���� 1row�� ���
--������) <,>,=,<>���� ����

--Anthony Hopkins�� ���� �а��� ������� �̸��� �а��̸� ���
SELECT t1.name, t2.dname
FROM student t1, department t2
WHERE deptno1 = (
	SELECT deptno1
	FROM student
	WHERE name = 'Anthony Hopkins'
)
AND t1.deptno1 = t2.deptno
;
--NAME                DNAME
--------------------- -----------------------------
--Anthony Hopkins     Software Engineering
--Sandra Bullock      Software Engineering

--Meg Ryan�� �Ի��Ϻ��� ���� ����� �̸�, �Ի���, �μ����� ���
SELECT t1.name, t1.hiredate, t2.dname
FROM professor t1, department t2
WHERE hiredate > (
	SELECT hiredate
	FROM professor
	WHERE name ='Meg Ryan'
	)
AND t1.deptno = t2.deptno
;
--NAME                       HIREDATE DNAME
---------------------------- -------- -----------------------------------------
--Angela Bassett             87/01/30 Computer Engineering
--Jessica Lange              98/03/22 Computer Engineering
--Winona Ryder               01/09/01 Multimedia Engineering
--Michelle Pfeiffer          85/11/30 Multimedia Engineering
--Julia Roberts              97/07/01 Software Engineering
--Sharon Stone               02/02/24 Software Engineering
--Susan Sarandon             09/08/30 Electronic Engineering
--Nicole Kidman              99/12/01 Mechanical Engineering
--Holly Hunter               09/01/28 Mechanical Engineering
--Andie Macdowell            10/06/28 Library and Information science
--Jodie Foster               01/05/23 Library and Information science

--�а���ȣ 201�� ��ո����Ժ��� �����԰� ���� �л��� �̸��� ������ ���
SELECT name, weight
FROM student
WHERE weight > (
	SELECT AVG(weight)
	FROM student
	WHERE deptno1 = 201
	)
;
--NAME                           WEIGHT
---------------------------- ----------
--James Seo                          72
--Demi Moore                         83
--Danny Glover                       70
--Richard Dreyfus                    72
--Tim Robbins                        70
--Wesley Snipes                      82
--Christian Slater                   69
--Charlie Sheen                      81

--2. ������ ��������: ���������� ������ ���� 2row�̻�
--������) exists, in, >any, <any, >all, <all
--IN: ���������� ����� ���� ���� ã��
--EXISTS: �������� ���� ������ ��� ���������� ����
-->ANY: ���������� ��� �߿� �ּҰ�
--<ANY: ���������� ��� �߿� �ִ밪
-->ALL: ���������� ��� �߿� �ִ밪
--<ALL: ���������� ��� �߿� �ּҰ�

--Section head ������ �ּҿ����ں��� �� ���� ������ �޴� ����� �̸�, ����, ������ ���
SELECT name, position, TO_CHAR(pay,'$9,999,999,999,999') SALARY
FROM emp2
WHERE pay > ANY (
	SELECT pay
	FROM emp2
	WHERE position = 'Section head'
	)
ORDER BY pay DESC
;
--NAME                  POSITION                  SALARY
----------------------- ------------------------- ----------------------
--Kurt Russell          Boss                             $100,000,000
--Kevin Bacon           Department head                   $75,000,000
--AL Pacino             Department head                   $72,000,000
--Val Kilmer            Department head                   $68,000,000
--Tommy Lee Jones       Deputy department head            $60,000,000
--Gene Hackman          Section head                      $56,000,000
--Hugh Grant            Section head                      $51,000,000
--Woody Harrelson       Section head                      $50,000,000

--2�г� �л� �� ���� ü���� ���Գ����� �л����� �� ���Գ����� �л��� �̸��� �г�, ������ ���
SELECT name, grade, weight
FROM student
WHERE weight < all (
	SELECT weight
	FROM student
	WHERE grade = 2
	)
;
--NAME                    GRADE     WEIGHT
-------------------- ---------- ----------
--Billy Crystal               3         48
--Nicholas Cage               3         42
--Danny Devito                1         48

--���� ��տ����� ���� �μ��� ��տ������� ���� �޴� �������� �μ���, ������, ������ ���
SELECT t2.dname, t1.name, t1.pay
FROM emp2 t1, dept2 t2
WHERE pay < all (
	SELECT AVG(pay) OVER(PARTITION BY deptno)
	FROM emp2
	)
AND t1.deptno = t2.dcode
;
--DNAME                  NAME                       PAY
------------------------ ------------------- ----------
--H/W Support Team       Harrison Ford         20000000
--S/W Support Team       Clint Eastwood        20000000
--Sales1 Team            JohnTravolta          22000000
--Sales2 Team            Robert De Niro        22000000
--Sales3 Team            Sly Stallone          22000000
--Sales4 Team            Tom Cruise            20000000

--IN
SELECT empno, name, deptno
FROM emp2
WHERE deptno IN (
	SELECT dcode
	FROM dept2
	WHERE area = 'Pohang Main Office'
	)
;
--     EMPNO NAME                      DEPTNO
------------ ------------------------- ------------
--  19900101 Kurt Russell              0001
--  19966102 Kevin Bacon               1003
--  19970112 Val Kilmer                1006
--  19960212 Chris O'Donnell           1007

--EXISTS
--���������� ������ ���� �����ϰ� �� ����� 1���̶� ���ȸ� �������� ����
--�� �ǵ� ������ ������ ���������� ���� �ȵ�
--���������� true/false��� ���� true�� ���������� ����Ǵ� ��
SELECT *
FROM dept
WHERE EXISTS(
	SELECT deptno
	FROM dept
	WHERE deptno = &deptno
	)
;

--3. �����÷� ��������
--���������� �������� ���� �÷��� ���
--pk�� ���� �÷��� ���� ��� �Ѳ����� ���ϱ� ���� ���
--�� �г⺰�� �ִ� �����Ը� ���� �л����� �̸��� ������ ���
SELECT t2.grade,
	t2.name,
	t2.weight
FROM student t2
WHERE (t2.grade, t2.weight) IN (
	SELECT grade, MAX(t1.weight)"max_weight"
	FROM student t1
	GROUP BY grade
	)
ORDER BY 1
;
--   GRADE NAME                 WEIGHT
---------- ---------------- ----------
--       1 Charlie Sheen            81
--       2 Wesley Snipes            82
--       3 Bill Murray              58
--       4 Demi Moore               83

--�� �а����� �Ի����� ���� ������ ������ ������ȣ�� �̸�, �а����� ���
SELECT t1.profno, t1.name, t1.hiredate, t2.dname
FROM professor t1, department t2
WHERE (t1.deptno, t1.hiredate) IN (
	SELECT deptno, MIN(hiredate) min_hire
	FROM professor
	GROUP BY deptno
	)
AND t1.deptno = t2.deptno
ORDER BY hiredate
;
--  PROFNO NAME               HIREDATE DNAME
---------- ------------------ -------- -------------------------------------
--    1001 Audie Murphy       80/06/23 Computer Engineering
--    4001 Meryl Streep       81/10/23 Electronic Engineering
--    3001 Emma Thompson      81/10/23 Software Engineering
--    2003 Whoopi Goldberg    82/04/29 Multimedia Engineering
--    4005 Meg Ryan           85/09/18 Chemical Engineering
--    4003 Nicole Kidman      99/12/01 Mechanical Engineering
--    4007 Jodie Foster       01/05/23 Library and Information science
