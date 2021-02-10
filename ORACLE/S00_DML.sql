--INSERT

--기본
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

--컬럼명 생략
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

--특정컬럼에만 값을 입력
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

--날짜 데이터 입력하기
--PROFNO
--NAME
--ID
--POSITION
--PAY
--HIREDATE

INSERT INTO professor(PROFNO, NAME, ID, POSITION, PAY, HIREDATE)
VALUES(5001, 'James Bond','Love me','a full professor', 500, '2014-10-23')
;

--NULL 처리
--1. 자동 NULL 값 입력
--데이터를 입력할 때 컬럼에 값을 입력하지 않으면 자동으로 NULL값이 들어간다.
--2. 수동 NULL 값 입력
--데이터를 입력할 때 NULL을 적어주면 된다.

--테이블 생성
CREATE TABLE t_minus(
	no1 NUMBER,
	no2 NUMBER(3),
	no3 NUMBER(3,2)
);

--정수값
INSERT INTO t_minus
VALUES(1,1,1)
;
COMMIT;

--소수값
--NUMBER라고만 데이터타입을 지정하면 소숫값 들어옴
--길이를 따로 지정하면 소수자리도 지정해 줘야함
INSERT INTO t_minus
VALUES(1.1,1.1,1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1

--음수값
--따로 지정할 필요없음
INSERT INTO t_minus
VALUES(-1.1,-1.1,-1.1)
;
--       NO1        NO2        NO3
------------ ---------- ----------
--         1          1          1
--       1.1          1        1.1
--      -1.1         -1       -1.1

--INSERT를 통한 다건 입력

--테이블 구조만 가져오기
CREATE
TABLE professor3
AS
SELECT * FROM professor
WHERE 1=2
;

SELECT COUNT(*) FROM professor3
;

--데이터 전부 복사
INSERT INTO professor3
SELECT * FROM professor
;
COMMIT
;
SELECT COUNT(*) FROM professor3
;

