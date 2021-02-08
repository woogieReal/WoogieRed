--���̺� ����
DROP TABLE BOARD;
CREATE TABLE BOARD  (						
	SEQ			NUMBER,				
	TITLE 		VARCHAR2(1000 BYTE),					
	CONTENTS 	CLOB,					
	READ_CNT 	NUMBER DEFAULT 0,					
	REG_ID 		VARCHAR2(12 BYTE),					
	REG_DT 		DATE DEFAULT SYSDATE,					
	MOD_ID 		VARCHAR2(12 BYTE),					
	MOD_DT 		DATE DEFAULT SYSDATE					
);						
COMMENT ON TABLE BOARD IS '�Խ���';
COMMENT ON COLUMN BOARD.SEQ IS '����';

--INDEX����
CREATE UNIQUE INDEX PK_BOARD
 ON BOARD (
  SEQ ASC
 );
--PK����
ALTER TABLE BOARD
 ADD
  CONSTRAINT PK_BOARD
  PRIMARY KEY (
   SEQ
  );

--�뷮�� ������ ����
--������ ���� ����
TRUNCATE TABLE BOARD;

--�������Է�
INSERT INTO BOARD
SELECT level seq
	,'����_' || level title
	,'����_' || level contents
	,0 read_cnt
	,'admin' reg_id
	,(sysdate - level) reg_dt
	,'admin' mod_id
	,(sysdate - level) mod_dt
FROM dual
CONNECT BY LEVEL <= 120
;

COMMIT;

--������ ��ȸ
COL CNT FOR 99999
COL rnum FOR 99999
COL SEQ FOR 99999
COL READ_CNT FOR 99999
COL TITLE FOR A30
COL CONTENTS FOR A20
COL MOD_DT FOR A13
COL MOD_ID FOR A13
SELECT A.SEQ
	,A.RNUM
	,A.TITLE
	,A.READ_CNT
	,TO_CHAR(A.MOD_DT,'YYYY/MM/DD')MOD_DT
	,A.MOD_ID
	,B.CNT
FROM(
	SELECT TT1.*
	FROM(
		SELECT rownum rnum,T1.*
		FROM(
			SELECT *
			FROM BOARD
			WHERE title like '����_1'||'%'
			ORDER BY REG_DT DESC
		)T1
	)TT1
	WHERE rnum BETWEEN 1 AND 50
)A CROSS JOIN(
SELECT COUNT(*) CNT
FROM BOARD
WHERE title like '����_1'||'%'
)B
;
































