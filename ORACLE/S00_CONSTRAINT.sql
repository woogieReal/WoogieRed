--Constraint 제약조건
--테이블에 올바른 데이터만 입력받고 잘못된 내용이 들어오지 못하도록
--컬럼마다 정하는 규칙
--하나의 제약조건을 여러 컬럼에 중복으로 설정
--하나의 컬럼에 제약조건들을 중복으로 설정

--컬럼명 타입 CONSTRAINT 제약조건이름 제약조건
--컬럼명 타입 CONSTRAINT 제약조건이름 REFERENCES 참조테이블(참조컬럼)
--제약조건 이름이 없는 경우: 제약조건 관리에 어려움이 있다.
--not null 같은경우 사용이 잦아 제약조건명을 안주는 경우가 많다.
--pk, fk는 무조건 이름을 준다
DROP TABLE new_emp1;

CREATE TABLE new_emp1(
	no NUMBER(4)
		CONSTRAINT emp1_no_pk PRIMARY KEY,
	name VARCHAR2(20 BYTE)
		CONSTRAINT emp1_name_nn NOT NULL,
	jumin VARCHAR2(13 BYTE)
		CONSTRAINT emp1_jumin_nn NOT NULL
		CONSTRAINT emp1_jumin_uk UNIQUE,
	loc_code NUMBER(1)
		CONSTRAINT emp1_loc_code_ck CHECK(loc_code<5),
	deptno VARCHAR2(6 BYTE)
		CONSTRAINT emp1_deptno_fk REFERENCES dept2(dcode)
);

--테이블 생성 후 제약조건 추가
--new_emp3 name컬럼에 UNIQUE추가
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_name_uk UNIQUE(name)
;

--new_emp3 hiredate컬럼에 not null조건으로 변경
ALTER TABLE new_emp3
MODIFY(hiredate CONSTRAINT emp3_hiredate_nn NOT NULL)
;

--new_emp3 no컬럼이 emp2테이블의 empno컬럼을 참조하도록 제약조건을 설정
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_no_fk FOREIGN KEY(no)
REFERENCES emp2(empno)
;

--FK 작성시 PARENT테이블의 해당 컬럼은 UNIQUE KEY여야 한다.
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_name_fk FOREIGN KEY(name)
REFERENCES emp2(name)
;
--오류발생
--ORA-02270: no matching unique or primary key for this column-list

--ON DELETE CASCADE
--외래키 설정이 있을시에 부모 테이블의 데이터가 지워지면 자식테이블의 데이터도 함께 삭제

--테이블 생성
CREATE TABLE C_TEST1(
	no NUMBER,
	name VARCHAR2(20),
	deptno NUMBER
);

CREATE TABLE C_TEST2(
	no NUMBER,
	name VARCHAR2(20)
);

--C_TEST2의 no컬럼에 유니크키 지정
ALTER TABLE C_TEST2
ADD CONSTRAINT c_test2_no_uk UNIQUE(no)
;

--C_TEST1의 deptno를 C_TEST2의 no컬럼을 참조하는 외래키로 지정
ALTER TABLE C_TEST1
ADD CONSTRAINT c_test1_deptno_fk FOREIGN KEY(deptno)
REFERENCES C_TEST2(no)
;

--ON DELETE CASCADE 옵션의 FK 생성
ALTER TABLE C_TEST1
ADD CONSTRAINT c_test1_deptno_fk FOREIGN KEY(deptno)
REFERENCES C_TEST2(no)
ON DELETE CASCADE
;

--제약조건 삭제
ALTER TABLE C_TEST1
DROP CONSTRAINT c_test1_deptno_fk
;

--C_TEST2에 데이터 입력
INSERT INTO C_TEST2 VALUES(10, 'AAA');
INSERT INTO C_TEST2 VALUES(20, 'BBB');
INSERT INTO C_TEST2 VALUES(30, 'CCC');
COMMIT;
--   NO NAME
------- ---------
--   10 AAA
--   20 BBB
--   30 CCC

--C_TEST1에 데이터 입력
--C_TEST2 데이터 기반으로 C_TEST1의 deptno을 입력
INSERT INTO C_TEST1 VALUES(1, 'apple', 10);
INSERT INTO C_TEST1 VALUES(2, 'banana', 20);
INSERT INTO C_TEST1 VALUES(3, 'cherry', 30);
COMMIT;
--    NO NAME          DEPTNO
-------- --------- ----------
--     1 apple             10
--     2 banana            20
--     3 cherry            30

--참조하는 칼럼에 없는 데이터를 입력시 오류 발생
INSERT INTO C_TEST1 VALUES(4, 'peach', 40);
--ORA-02291: 
--integrity constraint (SCOTT.C_TEST1_DEPTNO_FK) violated - parent key not found

--참조하는 부모의 데이터를 삭제시 외래키가 ON DELETE CASCADE 설정되어있기 때문에
--해당 데이터를 참조하는 자식 테이블의 데이터도 삭제된다.
DELETE FROM C_TEST2
WHERE no = 10
;
--1 row deleted.

SELECT * FROM c_test1
;
--   NO NAME            DEPTNO
------- ----------- ----------
--    2 banana              20
--    3 cherry              30

--ON DELETE SET NULL
--외래키 설정이 있을시에 부모 테이블의 데이터가 지워지면 자식테이블의 데이터를 NULL처리
--외래키에 NOT NULL 제약조건이 있어서는 안된다.

--제약조건 삭제
ALTER TABLE C_TEST1
DROP CONSTRAINT c_test1_deptno_fk
;

--ON DELETE SET NULL 속성의 외래키 지정
ALTER TABLE C_TEST1
ADD CONSTRAINT c_test1_deptno_fk FOREIGN KEY(deptno)
REFERENCES C_TEST2(no)
ON DELETE SET NULL
;

--참조하는 부모의 데이터를 삭제시 외래키가 ON DELETE SET NULL 설정되어있기 때문에
--해당 데이터를 참조하는 자식 테이블의 데이터는 NULL 처리된다.
DELETE FROM C_TEST2
WHERE no = 20
;
--1 row deleted.

SELECT * FROM c_test1
;
--  NO NAME         DEPTNO
------ -------- ----------
--   2 banana
--   3 cherry           30

--제약조건 조회하기
--딕셔너리 USER_CONSTRAINTS, USER_CONS_COLUMNS
--DBA DBA_CONSTRAINTS, DBA_CONS_COLUMNS

--TABLE 이름은 반드시 대문자로 조회

--CONSTRAINT 타입: 
--          P -> PK
--          U -> UNIQUE
--          C-> CHECK
--          R -> FK

desc user_cons_columns;
--이름               널?       유형             
-----------------  -------- -------------- 
--OWNER            NOT NULL VARCHAR2(30)   
--CONSTRAINT_NAME  NOT NULL VARCHAR2(30)   
--TABLE_NAME       NOT NULL VARCHAR2(30)   
--COLUMN_NAME               VARCHAR2(4000) 
--POSITION                  NUMBER         


SELECT t1.owner,
	t1.constraint_name
FROM user_constraints t1
WHERE t1.table_name = 'EMP'
;
--OWNER     CONSTRAINT_NAME    
----------- -------------------
--SCOTT     PK_EMP             
--SCOTT     FK_DEPTNO          

SELECT t1.owner,
	t1.constraint_name,
	t1.constraint_type,
	t1.status
FROM user_constraints t1
WHERE t1.table_name = 'EMP'
;
--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          PK_EMP                         P ENABLED 
--SCOTT                          FK_DEPTNO                      R ENABLED 

SELECT owner,
	constraint_name,
	table_name,
	column_name
FROM user_cons_columns
WHERE table_name = 'EMP'
;

--제약조건관리
--C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\utlexcpt.sql


--361p
--1
DROP TABLE tcons;
CREATE TABLE tcons(
    no NUMBER(5) CONSTRAINT tcons_no_pk PRIMARY KEY,
    name VARCHAR2(20) CONSTRAINT tcons_name_nn NOT NULL,
    jumin VARCHAR2(13)
        CONSTRAINT tcons_jumin_nn NOT NULL
        CONSTRAINT tcons_jumin_uk UNIQUE,
    area number(1) CONSTRAINT tcons_area_ck CHECK(area between 1 AND 4),
    deptno VARCHAR2(6) 
        CONSTRAINT tcons_deptno_fk REFERENCES dept2(decode)
);

--2
ALTER TABLE emp2
ADD CONSTRAINT tmp2_name_uk UNIQUE(name)
;

ALTER TABLE tcons
ADD CONSTRAINT tcons_name_fk FOREIGN KEY(name)
REFERENCES emp2(name)
;

--3
SELECT t1.owner,
	t1.constraint_name,
	t1.constraint_type,
	t1.status
FROM user_constraints t1
WHERE t1.table_name = 'TCONS'
;
--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          TCONS_NAME_NN                  C ENABLED 
--SCOTT                          TCONS_JUMIN_NN                 C ENABLED 
--SCOTT                          TCONS_AREA_CK                  C ENABLED 
--SCOTT                          TCONS_NO_PK                    P ENABLED 
--SCOTT                          TCONS_JUMIN_UK                 U ENABLED 
--SCOTT                          TCONS_DEPTNO_FK                R ENABLED 
--SCOTT                          TCONS_NAME_FK                  R ENABLED 

ALTER TABLE tcons
DISABLE VALIDATE CONSTRAINT tcons_jumin_uk
;

--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          TCONS_NAME_NN                  C ENABLED 
--SCOTT                          TCONS_JUMIN_NN                 C ENABLED 
--SCOTT                          TCONS_AREA_CK                  C ENABLED 
--SCOTT                          TCONS_NO_PK                    P ENABLED 
--SCOTT                          TCONS_JUMIN_UK                 U DISABLED
--SCOTT                          TCONS_DEPTNO_FK                R ENABLED 
--SCOTT                          TCONS_NAME_FK                  R ENABLED 

ALTER TABLE tcons
ENABLE VALIDATE CONSTRAINT tcons_jumin_uk
;

--OWNER                          CONSTRAINT_NAME                C STATUS  
-------------------------------- ------------------------------ - --------
--SCOTT                          TCONS_NAME_NN                  C ENABLED 
--SCOTT                          TCONS_JUMIN_NN                 C ENABLED 
--SCOTT                          TCONS_AREA_CK                  C ENABLED 
--SCOTT                          TCONS_NO_PK                    P ENABLED 
--SCOTT                          TCONS_JUMIN_UK                 U ENABLED 
--SCOTT                          TCONS_DEPTNO_FK                R ENABLED 
--SCOTT                          TCONS_NAME_FK                  R ENABLED

--4
ALTER TABLE tcons
ENABLE VALIDATE CONSTRAINT tcons_jumin_uk
EXCEPTIONS INTO exceptions
;

--5
SELECT t1.owner,
	t1.table_name,
	t2.column_name,
	t1.constraint_name
FROM user_constraints t1, user_cons_columns t2
WHERE t1.table_name = 'EMP'
AND t1.constraint_name = t2.constraint_name
AND t1.constraint_type IN ('P','U','C')
;


















