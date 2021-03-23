--TRIGGER
--트리거를 생성하기 위해서는 먼저 권한부터 넘겨 받아야 함

--관리자로 접근
--권한할당
GRANT CREATE TRIGGER TO HR; --생성
GRANT ALTER ANY TRIGGER TO HR; --수정
GRANT DROP ANY TRIGGER TO HR; --삭제

--데이터베이스에서 TRIGGER를 생성할 수 있는 권한
GRANT ADMINISTER DATABASE TRIGGER TO HR;

--트리거를 위한 테이블 생성

CREATE TABLE t_order(
	no NUMBER,
	ord_code VARCHAR2(10),
	ord_date DATE
);

--문장 레벨 트리거
--트리거 생성
--16:20~16:25 사이에만 입력 가능하도록 허용. 그렇지 않으면 오류발생
CREATE OR REPLACE TRIGGER t_order
	
	--t_order테이블에 INSERT 전에 실행하시오
	BEFORE INSERT ON t_order
	
	BEGIN
		IF( TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '16:20' AND '16:25' ) THEN
			RAISE_APPLICATION_ERROR(-20000,'허용시간이 아닙니다.'); --2만 번대 이상 오류코드는 맘대로 줄 수 있음
		END IF;
	END;
	/
--Trigger created.

SELECT no, ord_code, TO_CHAR(ord_date,'HH24:MI') "TIME"
FROM t_order;
--
--      NO ORD_CODE             TIME
---------- -------------------- ----------
--       1 C100                 16:22
--       2 C200                 16:22
--       3 C300                 16:23
--       4 C400                 16:25

INSERT INTO t_order
VALUES(5, 'C500', SYSDATE);
--ORA-20000: 허용시간이 아닙니다.

--행 레벨 트리거

CREATE OR REPLACE TRIGGER t_order3
	
	--t_order테이블에 INSERT 전에 실행하시오
	BEFORE INSERT ON t_order
	FOR EACH ROW
	WHEN( NEW.ord_code = 'C500')
	
	BEGIN
		IF( TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '16:30' AND '16:33' ) THEN
			RAISE_APPLICATION_ERROR(-20300,'C500제품의 입력 허용시간이 아닙니다.');
		END IF;
	END;
	/

INSERT INTO t_order
VALUES(6, 'C600', SYSDATE);
--
--ORA-20300: C500제품의 입력 허용시간이 아닙니다.



