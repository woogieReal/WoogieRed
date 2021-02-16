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





















