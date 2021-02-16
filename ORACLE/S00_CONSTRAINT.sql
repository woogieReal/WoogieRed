--Constraint ��������
--���̺� �ùٸ� �����͸� �Է¹ް� �߸��� ������ ������ ���ϵ���
--�÷����� ���ϴ� ��Ģ
--�ϳ��� ���������� ���� �÷��� �ߺ����� ����
--�ϳ��� �÷��� �������ǵ��� �ߺ����� ����

--�÷��� Ÿ�� CONSTRAINT ���������̸� ��������
--�÷��� Ÿ�� CONSTRAINT ���������̸� REFERENCES �������̺�(�����÷�)
--�������� �̸��� ���� ���: �������� ������ ������� �ִ�.
--not null ������� ����� ��� �������Ǹ��� ���ִ� ��찡 ����.
--pk, fk�� ������ �̸��� �ش�
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

--���̺� ���� �� �������� �߰�
--new_emp3 name�÷��� UNIQUE�߰�
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_name_uk UNIQUE(name)
;

--new_emp3 hiredate�÷��� not null�������� ����
ALTER TABLE new_emp3
MODIFY(hiredate CONSTRAINT emp3_hiredate_nn NOT NULL)
;

--new_emp3 no�÷��� emp2���̺��� empno�÷��� �����ϵ��� ���������� ����
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_no_fk FOREIGN KEY(no)
REFERENCES emp2(empno)
;

--FK �ۼ��� PARENT���̺��� �ش� �÷��� UNIQUE KEY���� �Ѵ�.
ALTER TABLE new_emp3
ADD CONSTRAINT emp3_name_fk FOREIGN KEY(name)
REFERENCES emp2(name)
;
--�����߻�
--ORA-02270: no matching unique or primary key for this column-list





















