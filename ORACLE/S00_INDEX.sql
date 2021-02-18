--OLTP: B-Tree �ε��� ���(�ǽð� ������ ������ϴ� �뵵)
--OLAP: BITMAP �ε��� ���(�뷮�� �����͸� �м��ϴ� �뵵)

--B-TREE �ε���
--Root Block, Branch Block, Leaf Block���� ����
--������ �����Ͱ� ����ִ� ���� Leaf Block

--������: Leaf Block -> Branch Block -> Root Block
--������ ��ȸ��: Root Block -> Branch Block -> Leaf Block

--B-Tree�� B�� Binary�� �ǹ̵� �ְ� Balance��� �ǹ̵� �ִ�.
--Root Block�� �������� ���ʰ� ������ �������� balance�� ���� �� ������ ���

--B-Tree �ε���: 
--1. Unique Index
--2. NONE Unique Index
--3. Function Based Index(�Լ���� �ε���)
--4. Descending Index(�������� �ε���)
--5. Composite Index(���� �ε���)

--BITMAP INDEX
--OLAP���� �ַ� ����
--B-TREE�� ���� ������ ���� ������ �����Ͱ� ���� ��� ���
--BITMAP�� ��� ���� ������ ���� ������ �����Ͱ� ���� ��� ���(ex.����)

--����
--CREATE BITMAP INDEX �ε�����
--ON ���̺��(�÷���1 [ASC(�⺻)|DESC],�÷���2 [ASC(�⺻)|DESC]);

CREATE BITMAP INDEX idx_emp_deptno
ON emp(deptno)
;
-- Standard Edition ����(�������)������ ��� ����
-- ORA-00439: feature not enabled: Bit-mapped indexes

--1. Unique Index
--key���� �ߺ��Ǵ� �����Ͱ� ����.
--�ߺ��� ?�� �Էµ� ���ɼ��� �ִ� �÷����� ����� �� ����.
--������ ����

--����
--CREATE UNIQUE INDEX �ε�����(IX/IDX_���̺��̸�_�÷�)
--ON ���̺� (�÷���1 [ASC(�⺻)|DESC], �÷���2 [ASC(�⺻)|DESC]);

--UNIQUE INDEX�� ename�� �ɾ��� ������ ���� ename�� �Էµ� �� ����.
CREATE UNIQUE INDEX IDX_emp_ename
ON emp (ename ASC)
;
--Index created.

--������ �Է�
INSERT INTO emp
VALUES(7936,'WOOGIE','CLERCK',7902,'1980-12-17',880,100,20)
;
--ORA-00001: unique constraint (SCOTT.IDX_EMP_ENAME) violated

--2. NONE Unique Index
--�ߺ��� �����Ͱ� �ִ� �÷��� ��� ���

--����
--CREATE INDEX �ε�����(IX/IDX_���̺��̸�_�÷�)
--ON ���̺� (�÷���1 [ASC(�⺻)|DESC], �÷���2 [ASC(�⺻)|DESC]);

--NONE Unique Index�̱� ������ jobĮ���� �ߺ����� �Է� �� �� �ִ�.
CREATE INDEX IDX_emp_job
ON emp (job DESC)
;
--Index created.

--������ �Է�
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

--3. Function Based Index(�Լ���� �ε���)
--�ε����� WHERE ���� ���� �����÷��̳� �����÷� � ������ ��(ex.WHERE empno = ?)
--������ WHERE ���� ������ �ٸ����·� �����ÿ��� �ε����� Ȱ���� �� ����
--(ex.WHERE empno * 100 = ? / WHERE empno != ?)

--Index Suppressing Error
--�ε����� ������ ���� ���� sql�ۼ������� �ε����� ����� �� ���� ���

--�̸� �ذ��ϱ� ���� �Լ�ó�� ������ �ؼ� �ε��� ����
--�ӽ����� �ذ�å���� ����

CREATE INDEX IDX_emp_deptno
ON emp(deptno/10)
;
--Index created.

--������ ��ȸ
SELECT *
FROM emp
WHERE deptno/10 = 1
;
--     EMPNO ENAME    JOB          MGR HIREDATE        SAL       COMM     DEPTNO
------------ -------- ---------- ----- -------- ---------- ---------- ----------
--      7782 CLARK    MANAGER     7839 81/06/09       2450                    10
--      7839 KING     PRESIDENT        81/11/17       5000                    10
--      7934 MILLER   CLERK       7782 82/01/23       1300                    10

--4. Descending Index(�������� �ε���)
--������������ ������ �ߴµ� ������������ �����͸� ���� ���� ��� ���ο� �ε����� �����ϸ� ��������
--�ε����� ������ DML ���ɿ� �ǿ����� ��ħ
--����Ŭ������ �̸� �ذ��ϱ� ���� '��Ʈ'��� ����� ����, �̸� ���� ������ �� ȿ���� ����
--�ּڰ�, �ִ��� ���ϱ⵵ ��(�ڿ��� ���)

--5. Composite Index(���� �ε���)
--�� �� �̻��� �÷��� ���ļ� �ε����� �����ϴ� ��
--�ַ� WHERE���� �÷��� 2���̻��� ���(AND�� ����� ��, OR�� �ȵ�)
--���� ���� ����ϴ� �ε�����, �ε��� �÷������� ���ɿ� ���� ������ ��ħ

CREATE INDEX idx_emp_comp
ON emp(ename, job)
;
--Index created.








