--테이블 설계
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
COMMENT ON TABLE BOARD IS '게시판';
COMMENT ON COLUMN BOARD.SEQ IS '순번';

--INDEX생성
CREATE UNIQUE INDEX PK_BOARD
 ON BOARD (
  SEQ ASC
 );
--PK생성
ALTER TABLE BOARD
 ADD
  CONSTRAINT PK_BOARD
  PRIMARY KEY (
   SEQ
  );

--대량의 데이터 삽입
--데이터 삭제 먼저
TRUNCATE TABLE BOARD;

--데이터입력
INSERT INTO BOARD
SELECT level seq
	,'제목_' || level title
	,'내용_' || level contents
	,0 read_cnt
	,'admin' reg_id
	,(sysdate - level) reg_dt
	,'admin' mod_id
	,(sysdate - level) mod_dt
FROM dual
CONNECT BY LEVEL <= 120
;

COMMIT;

--데이터 조회
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
			WHERE title like '제목_1'||'%'
			ORDER BY REG_DT DESC
		)T1
	)TT1
	WHERE rnum BETWEEN 1 AND 50
)A CROSS JOIN(
SELECT COUNT(*) CNT
FROM BOARD
WHERE title like '제목_1'||'%'
)B
;
































