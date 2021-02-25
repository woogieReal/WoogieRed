--SEQUENCE
--�������� �������� ��ȣ�� �ڵ����� �����ϴ� ��ȣ ������
--������ DML�� �ѹ� �Ǿ �������� �ѹ� ���� �ʴ´�.

--������� 
--CREATE SEQUENCE sequence_name
--INCREMENT BY n: ������ ��ȣ�� ���� ��. default 1
--START WITH n: ������ ��ȣ�� ���۰�. default 1
--MAXVALUE n: ������ �ִ밪. default ����
--MINVALUE n: ������ �ּҰ�. default ����
--CYCLE|NOCYCLE: ������ ��ȣ�� ��ȯ����. default NOCYCLE
--CACHE|NOCHACHE: ������ �����ӵ� �����ϱ� ���� ĳ�̿��� ����. default NOCHACHE

--SEQUENCE_NAME: jno_seq
--������: 1
--���۹�ȣ: 100
--����ȣ: 110
--�ּ�: 90
--������: 1
--�ݺ��ǰ� ĳ���� 2
CREATE SEQUENCE jno_seq
INCREMENT BY 1
START WITH 100
MAXVALUE 110
MINVALUE 90
CYCLE
CACHE 2
;

--CURRVAL: ���� ������ ��
--NEXTVAR: ���� ������ ��

--���̺� ����
CREATE TABLE s_order(
	ord_no NUMBER(4),
	ord_name VARCHAR2(10),
	p_name VARCHAR2(20),
	p_qty NUMBER
);

--�������� s_order ���̺��� ord_no�� ���
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

--MAXVALUE�� MINVALUE �׽�Ʈ
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

--���� �����ϴ� ������
CREATE SEQUENCE jno_seq_rv
INCREMENT BY -2
START WITH 10
MAXVALUE 20
MINVALUE 0
;

--���̺� ����
CREATE TABLE s_revl(
	no NUMBER
);

--CYCLE �Ӽ��� ����� ������ MINVALUE�� 0�� �����ϸ� ���̻� �����͸� �Է��� �� ����
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

--������ �ʱ�ȭ
CREATE OR REPLACE PROCEDURE SCOTT.res_sequence (sequencename IN VARCHAR2) as curr_val INTEGER;
BEGIN
  EXECUTE IMMEDIATE 'alter sequence ' ||sequencename||' MINVALUE 0';
  EXECUTE IMMEDIATE 'SELECT ' ||sequencename ||'.nextval FROM dual' INTO curr_val;
  EXECUTE IMMEDIATE 'alter sequence ' ||sequencename||' increment by -'||curr_val;
  EXECUTE IMMEDIATE 'SELECT ' ||sequencename ||'.nextval FROM dual' INTO curr_val;
  EXECUTE IMMEDIATE 'alter sequence ' ||sequencename||' increment by 1';
END res_sequence;
--Procedure RES_SEQUENCE��(��) �����ϵǾ����ϴ�.

--���ν��� ����
--EXEC Ȥ�� EXECUTE ���ν�����(�Ű�����1 ��, �Ű�����2 ��, ...);
--EXEC res_sequence();

CREATE SEQUENCE seq_test;

--��ȸ�� ���� ���� �ö�
SELECT seq_test.nextval
FROM dual
;

--������ ���� �ʱ�ȭ. �ٽ� 1���� ��
EXEC res_sequence('SEQ_TEST');

--������ �����ȸ
--user_sequences ���̺�
SELECT * FROM user_sequences
;
--SEQUENCE_NAME       MIN_VALUE  MAX_VALUE INCREMENT_BY CY OR CACHE_SIZE LAST_NUMBER
-------------------- ---------- ---------- ------------ -- -- ---------- -----------
--BOARD_SEQ                   0  999999999            1 N  N          20           0
--JNO_SEQ                    90        110            1 Y  N           2          92
--JNO_SEQ_RV                  0         20           -2 N  N          20          -2
--SEQ_TEST                    0 1.0000E+28            1 N  N          20          21





















