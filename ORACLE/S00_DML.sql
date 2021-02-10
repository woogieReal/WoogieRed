--INSERT

--�⺻
INSERT INTO dept2(DCODE, DNAME, PDEPT, AREA)
VALUES(9000,'temp_1',1006,'temp_area')
;
--DCODE        DNAME                         PDEPT        AREA
-------------- ----------------------------- ------------ --------------------------
--0001         President                                  Pohang Main Office
--1000         Management Support Team       0001         Seoul Branch Office
--1001         Financial Management Team     1000         Seoul Branch Office
--1002         General affairs               1000         Seoul Branch Office
--1003         Engineering division          0001         Pohang Main Office
--1004         H/W Support Team              1003         Daejeon Branch Office
--1005         S/W Support Team              1003         Kyunggi Branch Office
--1006         Business Department           0001         Pohang Main Office
--1007         Business Planning Team        1006         Pohang Main Office
--1008         Sales1 Team                   1007         Busan Branch Office
--1009         Sales2 Team                   1007         Kyunggi Branch Office
--1010         Sales3 Team                   1007         Seoul Branch Office
--1011         Sales4 Team                   1007         Ulsan Branch Office
--9000         temp_1                        1006         temp_area

--�÷��� ����
INSERT INTO dept2
VALUES(9001,'temp_2',1006,'temp_area')
;
--DCODE        DNAME                          PDEPT        AREA
-------------- ------------------------------ ------------ -----------------------
--0001         President                                   Pohang Main Office
--1000         Management Support Team        0001         Seoul Branch Office
--1001         Financial Management Team      1000         Seoul Branch Office
--1002         General affairs                1000         Seoul Branch Office
--1003         Engineering division           0001         Pohang Main Office
--1004         H/W Support Team               1003         Daejeon Branch Office
--1005         S/W Support Team               1003         Kyunggi Branch Office
--1006         Business Department            0001         Pohang Main Office
--1007         Business Planning Team         1006         Pohang Main Office
--1008         Sales1 Team                    1007         Busan Branch Office
--1009         Sales2 Team                    1007         Kyunggi Branch Office
--1010         Sales3 Team                    1007         Seoul Branch Office
--1011         Sales4 Team                    1007         Ulsan Branch Office
--9000         temp_1                         1006         temp_area
--9001         temp_2                         1006         temp_area

--Ư���÷����� ���� �Է�
INSERT INTO dept2(DCODE, DNAME, PDEPT)
VALUES(9003,'temp_3',1006)
;
--DCODE        DNAME                         PDEPT        AREA
-------------- ----------------------------- ------------ ------------------------
--0001         President                                  Pohang Main Office
--1000         Management Support Team       0001         Seoul Branch Office
--1001         Financial Management Team     1000         Seoul Branch Office
--1002         General affairs               1000         Seoul Branch Office
--1003         Engineering division          0001         Pohang Main Office
--1004         H/W Support Team              1003         Daejeon Branch Office
--1005         S/W Support Team              1003         Kyunggi Branch Office
--1006         Business Department           0001         Pohang Main Office
--1007         Business Planning Team        1006         Pohang Main Office
--1008         Sales1 Team                   1007         Busan Branch Office
--1009         Sales2 Team                   1007         Kyunggi Branch Office
--1010         Sales3 Team                   1007         Seoul Branch Office
--1011         Sales4 Team                   1007         Ulsan Branch Office
--9000         temp_1                        1006         temp_area
--9001         temp_2                        1006         temp_area
--9003         temp_3                        1006

--��¥ ������ �Է��ϱ�
--PROFNO
--NAME
--ID
--POSITION
--PAY
--HIREDATE

INSERT INTO professor(PROFNO, NAME, ID, POSITION, PAY, HIREDATE)
VALUES(5001, 'James Bond','Love me','a full professor', 500, '2014-10-23')
;

--NULL ó��
--1. �ڵ� NULL �� �Է�
--�����͸� �Է��� �� �÷��� ���� �Է����� ������ �ڵ����� NULL���� ����.
--2. ���� NULL �� �Է�
--�����͸� �Է��� �� NULL�� �����ָ� �ȴ�.

--���̺� ����
CREATE TABLE t_minus(
	no1 NUMBER,
	no2 NUMBER(3),
	no3 NUMBER(3,2)
);

--������
INSERT INTO t_minus
VALUES(1,1,1)
;
COMMIT;

--�Ҽ���
--NUMBER��� ������Ÿ���� �����ϸ� �Ҽ��� ����
--���̸� ���� �����ϸ� �Ҽ��ڸ��� ������ �����
INSERT INTO t_minus
VALUES(1.1,1.1,1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1

--������
--���� ������ �ʿ����
INSERT INTO t_minus
VALUES(-1.1,-1.1,-1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1
--      -1.1         -1       -1.1

--INSERT�� ���� �ٰ� �Է�

--���̺� ������ ��������
CREATE
TABLE professor3
AS
SELECT * FROM professor
WHERE 1=2
;

SELECT COUNT(*) FROM professor3
;

--������ ���� ����
INSERT INTO professor3
SELECT * FROM professor
;
COMMIT
;
SELECT COUNT(*) FROM professor3
;

