--OLTP: B-Tree 인덱스 사용(실시간 데이터 입출력하는 용도)
--OLAP: BITMAP 인덱스 사용(대량의 데이터를 분석하는 용도)

--B-TREE 인덱스
--Root Block, Branch Block, Leaf Block으로 구성
--실제로 데이터가 들어있는 곳은 Leaf Block

--생성시: Leaf Block -> Branch Block -> Root Block
--데이터 조회시: Root Block -> Branch Block -> Leaf Block

--B-Tree의 B는 Binary란 의미도 있고 Balance라는 의미도 있다.
--Root Block을 기준으로 왼쪽과 오른쪽 데이터의 balance가 맞을 때 성능이 우수

--B-Tree 인덱스: 
--1. Unique Index
--2. NONE Unique Index
--3. Function Based Index(함수기반 인덱스)
--4. Descending Index(내림차순 인덱스)
--5. Composite Index(결합 인덱스)

--BITMAP INDEX
--OLAP에서 주로 쓰임
--B-TREE는 값의 종류가 많고 동일한 데이터가 적을 경우 사용
--BITMAP의 경우 값의 종류가 적고 동일한 데이터가 많을 경우 사용(ex.성별)

--문법
--CREATE BITMAP INDEX 인덱스명
--ON 테이블명(컬럼명1 [ASC(기본)|DESC],컬럼명2 [ASC(기본)|DESC]);

CREATE BITMAP INDEX idx_emp_deptno
ON emp(deptno)
;
-- Standard Edition 버전(유료버전)에서만 사용 가능
-- ORA-00439: feature not enabled: Bit-mapped indexes

--1. Unique Index
--key값에 중복되는 데이터가 없다.
--중복될 ?이 입력될 가능성이 있는 컬럼에는 사용할 수 없다.
--성능이 좋음

--문법
--CREATE UNIQUE INDEX 인덱스명(IX/IDX_테이블이름_컬럼)
--ON 테이블 (컬럼명1 [ASC(기본)|DESC], 컬럼명2 [ASC(기본)|DESC]);

--UNIQUE INDEX를 ename에 걸었기 때문에 같은 ename은 입력될 수 없다.
CREATE UNIQUE INDEX IDX_emp_ename
ON emp (ename ASC)
;
--Index created.

--데이터 입력
INSERT INTO emp
VALUES(7936,'WOOGIE','CLERCK',7902,'1980-12-17',880,100,20)
;
--ORA-00001: unique constraint (SCOTT.IDX_EMP_ENAME) violated

--2. NONE Unique Index
--중복될 데이터가 있는 컬럼일 경우 사용

--문법
--CREATE INDEX 인덱스명(IX/IDX_테이블이름_컬럼)
--ON 테이블 (컬럼명1 [ASC(기본)|DESC], 컬럼명2 [ASC(기본)|DESC]);

--NONE Unique Index이기 때문에 job칼럼에 중복값이 입력 될 수 있다.
CREATE INDEX IDX_emp_job
ON emp (job DESC)
;
--Index created.

--데이터 입력
INSERT INTO emp
VALUES(7937,'WOOGIE2','CLERCK',7902,'1980-12-17',880,100,20)
;
--     EMPNO ENAME     JOB           MGR HIREDATE        SAL       COMM     DEPTNO
------------ --------- ---------- ------ -------- ---------- ---------- ----------
--      7369 SMITH     CLERK        7902 80/12/17        880                    20
--      7499 ALLEN     SALESMAN     7698 81/02/20       1600        300         30
--      7521 WARD      SALESMAN     7698 81/02/22       1250        500         30
--      7566 JONES     MANAGER      7839 81/04/02     3272.5                    20
--      7654 MARTIN    SALESMAN     7698 81/09/28       1250       1400         30
--      7698 BLAKE     MANAGER      7839 81/05/01       2850                    30
--      7782 CLARK     MANAGER      7839 81/06/09       2450                    10
--      7839 KING      PRESIDENT         81/11/17       5000                    10
--      7844 TURNER    SALESMAN     7698 81/09/08       1500          0         30
--      7900 JAMES     CLERK        7698 81/12/03        950                    30
--      7902 FORD      ANALYST      7566 81/12/03       3300                    20
--      7934 MILLER    CLERK        7782 82/01/23       1300                    10
--      7935 WOOGIE    CLERCK       7902 80/12/17        880        100         20
--      7937 WOOGIE2   CLERCK       7902 80/12/17        880        100         20

--3. Function Based Index(함수기반 인덱스)
--인덱스는 WHERE 절에 오는 조건컬럼이나 조인컬럼 등에 만들어야 함(ex.WHERE empno = ?)
--하지만 WHERE 절의 조건을 다른형태로 가공시에는 인덱스를 활용할 수 없음
--(ex.WHERE empno * 100 = ? / WHERE empno != ?)

--Index Suppressing Error
--인덱스가 있지만 위와 같이 sql작성오류로 인덱스를 사용할 수 없는 경우

--이를 해결하기 위해 함수처럼 연산을 해서 인덱스 생성
--임시적인 해결책임을 주의

CREATE INDEX IDX_emp_deptno
ON emp(deptno/10)
;
--Index created.

--데이터 조회
SELECT *
FROM emp
WHERE deptno/10 = 1
;
--     EMPNO ENAME    JOB          MGR HIREDATE        SAL       COMM     DEPTNO
------------ -------- ---------- ----- -------- ---------- ---------- ----------
--      7782 CLARK    MANAGER     7839 81/06/09       2450                    10
--      7839 KING     PRESIDENT        81/11/17       5000                    10
--      7934 MILLER   CLERK       7782 82/01/23       1300                    10

--4. Descending Index(내림차순 인덱스)
--오름차순으로 정렬을 했는데 내림차순으로 데이터를 보고 싶은 경우 새로운 인덱스를 생성하면 좋지않음
--인덱스가 많으면 DML 성능에 악영향을 끼침
--오라클에서는 이를 해결하기 위해 '힌트'라는 방법을 제공, 이를 통해 정렬을 한 효과를 내고
--최솟값, 최댓값을 구하기도 함(뒤에서 배움)

--5. Composite Index(결합 인덱스)
--두 개 이상의 컬럼을 합쳐서 인덱스를 생성하는 것
--주로 WHERE조건 컬럼이 2개이상인 경우(AND로 연결될 때, OR는 안됨)
--아주 많이 사용하는 인덱스로, 인덱스 컬럼순서가 성능에 많은 영향을 끼침

CREATE INDEX idx_emp_comp
ON emp(ename, job)
;
--Index created.








