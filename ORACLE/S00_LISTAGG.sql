--LISTAGG: ���� ROW�����͸� �ϳ��� ROW���� ���ļ� �����ִ� �Լ�
--RETURN ������ 4000BYTE�� ������ �ȵ�
--LISTAGG(�÷�,'������') WITHIN GROUP (ORDER BY �÷�2) 

--�μ��� ������ �̸��� �ϳ��� ROW�� ���
COL "LISTAGG" FOR A50
SELECT deptno, LISTAGG(ename,'-') WITHIN GROUP(ORDER BY hiredate)"LISTAGG"
FROM emp
GROUP BY deptno;
--    DEPTNO LISTAGG
------------ --------------------------------------------------
--        10 CLARK-KING-MILLER
--        20 SMITH-JONES-FORD
--        30 ALLEN-WARD-BLAKE-TURNER-MARTIN-JAMES


