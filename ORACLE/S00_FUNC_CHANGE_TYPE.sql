--CHAR(n): ���������� ���ڸ� ����, �ִ��� 2000����Ʈ(�� ������ ������ �����Ϳ��� �� ��)
--VARCHAR2(n): ���ϴ� ������ ���ڸ� ����, �ִ��� 4000����Ʈ
--NUMBER(p,s): ���� ���� ����, P�� ��ü �ڸ����� 1~38�ڸ����� ����, s�� �Ҽ��� ���� �ڸ����� -84~127�ڸ����� ����
--DATE: �� 7����Ʈ�� BC4712�� 1�� 1�Ϻ��� AD9999�� 12�� 31�ϱ����� ��¥�� ���尡��
--LONG: ���������� ���ڸ� �����ϸ� �ִ� 2GB���� ���尡��(������ ������ ���ɼ��� �����Ƿ� �������)
--CLOB: ���������� ���ڸ� �����ϸ� �ִ� 4GB���� ���尡��
--BLOB: ���������� ���̳ʸ� �����͸� �ִ� 4GB���� ���尡��
--RAW(n): �������� �����ͷ� �ִ� 2000����Ʈ���� ���尡��
--LONG RAW(n): �������� �����ͷ� �ִ� 2GB���� ���尡��
--BFILE: �ܺ����Ͽ� ����� �����ͷ� �ִ� 4GB���� ���尡��

--������(�ڵ�) ����ȯ
--�ش��÷��� �ε����� �����Ǿ� ���� ��� ������ �Ǿ� �ӵ��� ������
SELECT '11'+'13'
FROM dual;
-- '11'+'13'
------------
--        24
--�����(����) ����ȯ
SELECT 11+TO_NUMBER('13')
FROM dual;
--11+TO_NUMBER('13')
--------------------
--                24

--TO_CHAR: ��¥ -> ����
--TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
--	����		�ǹ�								  	��뿹
-- YYYY | ������ 4�ڸ��� ǥ��						| 2021
-- RRRR | ���� ����       	                  	| 2021
-- YY   | ������ ���ڸ� 2�ڸ�	                  	| 21
-- RR	| ���� ���� 	   	                  	| 21
-- YEAR | ������ ������ ��ü 	                  	| TWENTY TWENTY ONE
-- MM	| ���� ���� 2�ڸ���	                  	| 02
-- MON	| ��(���н��� ��3����,������� MONTH�� ����)	| FEB
-- MONTH| ���� ������ ��ü	                  	| FEBRUARY
-- DD	| ���� ���� 2�ڸ���	                  	| 26
-- DAY	| ����(���н��� ����,������� �ѱ�)			| ������
-- DDTH	| �� ��° �������� ǥ��					| 22ND
-- HH24 | �Ϸ縦 24�ð����� ǥ��					| 23
-- HH	| �Ϸ縦 12�ð����� ǥ��					| 11
-- MI	| ��									| 20
-- SS	| ��									| 30
SELECT SYSDATE
	,TO_CHAR(SYSDATE, 'YYYY')"YYYY"
	,TO_CHAR(SYSDATE, 'MM')"MM"
	,TO_CHAR(SYSDATE, 'DD')"DD"
	,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')"YYYY-MM-DD HH24:MI:SS"
FROM dual;
--SYSDATE  YYYY     MM   DD   YYYY-MM-DD HH24:MI:SS
---------- -------- ---- ---- --------------------------------------
--21/02/01 2021     02   01   2021-02-01 10:43:00

--P105����
SELECT studno, name, TO_CHAR(birthday, 'DD-MM-YY')
FROM student
WHERE EXTRACT(MONTH FROM birthday) = 1;
--    STUDNO NAME                      TO_CHAR(BIRTHDAY
------------ ------------------------- ----------------
--      9511 Billy Crystal             23-01-76
--      9514 Bill Murray               20-01-76
--      9712 Sean Connery              05-01-78

--p106����
SELECT empno, ename, hiredate
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) IN(1,2,3);
--     EMPNO ENAME                HIREDATE
------------ -------------------- --------
--      7499 ALLEN                81/02/20
--      7521 WARD                 81/02/22
--      7934 MILLER               82/01/23

--TO_CHAR: ���� -> ����
--����		�ǹ�					��� ��			  ���
-- 9 | 9�� ������ŭ �ڸ��� | TO_CHAR(1234,'99999')   | 1234
-- 0 | ���ڸ��� 0���� ä�� | TO_CHAR(1234,'099999')  | 001234
-- $ | $ǥ�ø� �ٿ��� ǥ�� | TO_CHAR(1234,'$9999')   | $1234
-- . | �Ҽ��� ���ϸ� ǥ��  | TO_CHAR(1234,'9999.99') | 1234.00
-- , | õ���� ������ ǥ��  | TO_CHAR(12345,'99,999') | 12,345
SELECT empno, ename, sal, comm, TO_CHAR((sal*12)+comm,'$99,999')"SALARY"
FROM emp
WHERE ename = 'ALLEN';
--     EMPNO ENAME                       SAL       COMM SALARY
------------ -------------------- ---------- ---------- ----------------
--      7499 ALLEN                      1600        300  $19,500

SELECT name, pay, bonus, pay*12+bonus"TOTAL"
FROM professor
WHERE deptno = 201;

--108P ����
SELECT empno, ename
	,TO_CHAR(hiredate,'YYYY-MM-DD')"HIREDATE"
	,TO_CHAR(sal*12+comm,'$999,999')"SAL"
	,TO_CHAR((sal*12+comm)*1.15,'$999,999')"15% UP"
FROM emp
WHERE comm IS NOT NULL;
--     EMPNO ENAME                HIREDATE             SAL                15% UP
------------ -------------------- -------------------- ------------------ ------------------
--      7499 ALLEN                1981-02-20             $19,500            $22,425
--      7521 WARD                 1981-02-22             $15,500            $17,825
--      7654 MARTIN               1981-09-28             $16,400            $18,860
--      7844 TURNER               1981-09-08             $18,000            $20,700

--TO_NUMBER: ���ڰ� �ƴ� ���ڹ��ڸ� ���ڷ� �ٲپ��ִ� �Լ�
SELECT TO_NUMBER('5')
FROM dual;
--TO_NUMBER('5')
----------------
--             5

SELECT ASCII('A')
FROM dual;
--ASCII('A')
------------
--        65

--TO_DATE: ��¥�� �ƴ� ��¥ó�� ���� ���ڸ� ��¥�� �ٲ��ִ� �Լ�
SELECT TO_DATE('20210201')"date"
FROM dual;
--date
----------
--21/02/01