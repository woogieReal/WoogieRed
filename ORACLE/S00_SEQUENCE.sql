--SEQUENCE
--시퀀스는 연속적인 번호를 자동으로 생성하는 번호 생성기
--단점은 DML이 롤백 되어도 시퀀스는 롤백 되지 않는다.

--생성방법 
--CREATE SEQUENCE sequence_name
--INCREMENT BY n: 시퀀스 번호의 증가 값. default 1
--START WITH n: 시퀀스 번호의 시작값. default 1
--MAXVALUE n: 시퀀스 최대값. default 없음
--MINVALUE n: 시퀀스 최소값. default 없음
--CYCLE|NOCYCLE: 시퀀스 번호의 순환여부. default NOCYCLE
--CACHE|NOCHACHE: 시퀀스 생성속도 개선하기 위한 캐싱여부 지정. default NOCHACHE

--SEQUENCE_NAME: jno_seq
--증감값: 1
--시작번호: 100
--끝번호: 110
--최소: 90
--증가값: 1
--반복되고 캐싱은 2
CREATE SEQUENCE jno_seq
INCREMENT BY 1
START WITH 100
MAXVALUE 110
MINVALUE 90
CYCLE
CACHE 2
;

--CURRVAL: 현재 시퀀스 값
--NEXTVAR: 다음 시퀀스 값

--테이블 생성
CREATE TABLE s_order(
	ord_no NUMBER(4),
	ord_name VARCHAR2(10),
	p_name VARCHAR2(20),
	p_qty NUMBER
);

--시퀀스를 s_order 테이블의 ord_no에 사용
INSERT INTO s_order (
    ord_no,
    ord_name,
    p_name,
    p_qty
) VALUES (
    jno_seq.NEXTVAL,
    'james',
    'MAC',
    2
);
--    ORD_NO ORD_NAME             P_NAME                                        P_QTY
------------ -------------------- ---------------------------------------- ----------
--       100 james                MAC                                               2

--MAXVALUE와 MINVALUE 테스트
BEGIN
	FOR i IN 1..11 LOOP
		INSERT INTO s_order (
		    ord_no,
		    ord_name,
		    p_name,
		    p_qty
		) VALUES (
		    jno_seq.NEXTVAL,
		    'james',
		    'MAC',
		    1
		);
	END LOOP;
	COMMIT;
END;
/
--    ORD_NO ORD_NAME             P_NAME                                        P_QTY
------------ -------------------- ---------------------------------------- ----------
--       100 james                MAC                                               2
--       101 james                MAC                                               1
--       102 james                MAC                                               1
--       103 james                MAC                                               1
--       104 james                MAC                                               1
--       105 james                MAC                                               1
--       106 james                MAC                                               1
--       107 james                MAC                                               1
--       108 james                MAC                                               1
--       109 james                MAC                                               1
--       110 james                MAC                                               1
--        90 james                MAC                                               1
--
--12 rows selected.

--값이 감소하는 시퀀스
CREATE SEQUENCE jno_seq_rv
INCREMENT BY -2
START WITH 10
MAXVALUE 20
MINVALUE 0
;

--테이블 생성
CREATE TABLE s_revl(
	no NUMBER
);

--CYCLE 속성을 안줬기 때문에 MINVALUE인 0에 도달하면 더이상 데이터를 입력할 수 없음
INSERT INTO s_revl VALUES(jno_seq_rv.NEXTVAL)
;
--        NO
------------
--        10
--         8
--         6
--         4
--         2
--         0
--ORA-08004: sequence JNO_SEQ_RV.NEXTVAL goes below MINVALUE and cannot be instantiated

--시퀀스 초기화
CREATE OR REPLACE PROCEDURE SCOTT.res_sequence (sequencename IN VARCHAR2) as curr_val INTEGER;
BEGIN
  EXECUTE IMMEDIATE 'alter sequence ' ||sequencename||' MINVALUE 0';
  EXECUTE IMMEDIATE 'SELECT ' ||sequencename ||'.nextval FROM dual' INTO curr_val;
  EXECUTE IMMEDIATE 'alter sequence ' ||sequencename||' increment by -'||curr_val;
  EXECUTE IMMEDIATE 'SELECT ' ||sequencename ||'.nextval FROM dual' INTO curr_val;
  EXECUTE IMMEDIATE 'alter sequence ' ||sequencename||' increment by 1';
END res_sequence;
--Procedure RES_SEQUENCE이(가) 컴파일되었습니다.

--프로시저 실행
--EXEC 혹은 EXECUTE 프로시저명(매개변수1 값, 매개변수2 값, ...);
--EXEC res_sequence();

CREATE SEQUENCE seq_test;

--조회할 수록 값이 올라감
SELECT seq_test.nextval
FROM dual
;

--시퀀스 값을 초기화. 다시 1부터 들어감
EXEC res_sequence('SEQ_TEST');

--시퀀스 목록조회
--user_sequences 테이블
SELECT * FROM user_sequences
;
--SEQUENCE_NAME       MIN_VALUE  MAX_VALUE INCREMENT_BY CY OR CACHE_SIZE LAST_NUMBER
-------------------- ---------- ---------- ------------ -- -- ---------- -----------
--BOARD_SEQ                   0  999999999            1 N  N          20           0
--JNO_SEQ                    90        110            1 Y  N           2          92
--JNO_SEQ_RV                  0         20           -2 N  N          20          -2
--SEQ_TEST                    0 1.0000E+28            1 N  N          20          21





















