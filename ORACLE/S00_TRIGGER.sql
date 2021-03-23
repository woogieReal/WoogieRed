--TRIGGER
--Ʈ���Ÿ� �����ϱ� ���ؼ��� ���� ���Ѻ��� �Ѱ� �޾ƾ� ��

--�����ڷ� ����
--�����Ҵ�
GRANT CREATE TRIGGER TO HR; --����
GRANT ALTER ANY TRIGGER TO HR; --����
GRANT DROP ANY TRIGGER TO HR; --����

--�����ͺ��̽����� TRIGGER�� ������ �� �ִ� ����
GRANT ADMINISTER DATABASE TRIGGER TO HR;

--Ʈ���Ÿ� ���� ���̺� ����

CREATE TABLE t_order(
	no NUMBER,
	ord_code VARCHAR2(10),
	ord_date DATE
);

--���� ���� Ʈ����
--Ʈ���� ����
--16:20~16:25 ���̿��� �Է� �����ϵ��� ���. �׷��� ������ �����߻�
CREATE OR REPLACE TRIGGER t_order
	
	--t_order���̺� INSERT ���� �����Ͻÿ�
	BEFORE INSERT ON t_order
	
	BEGIN
		IF( TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '16:20' AND '16:25' ) THEN
			RAISE_APPLICATION_ERROR(-20000,'���ð��� �ƴմϴ�.'); --2�� ���� �̻� �����ڵ�� ����� �� �� ����
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
--ORA-20000: ���ð��� �ƴմϴ�.

--�� ���� Ʈ����

CREATE OR REPLACE TRIGGER t_order3
	
	--t_order���̺� INSERT ���� �����Ͻÿ�
	BEFORE INSERT ON t_order
	FOR EACH ROW
	WHEN( NEW.ord_code = 'C500')
	
	BEGIN
		IF( TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '16:30' AND '16:33' ) THEN
			RAISE_APPLICATION_ERROR(-20300,'C500��ǰ�� �Է� ���ð��� �ƴմϴ�.');
		END IF;
	END;
	/

INSERT INTO t_order
VALUES(6, 'C600', SYSDATE);
--
--ORA-20300: C500��ǰ�� �Է� ���ð��� �ƴմϴ�.



