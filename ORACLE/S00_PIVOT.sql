--PIVOT | UNPIVOT
--PIVOT: ROW������ COLUMN ������ ����
--UNPIVOT: COLUMN������ ROW������ ����
--�÷� ���� �������� ���ο� �÷��� �����Ͽ� �پ��� �����Լ��� ���밡��

--PIVOT�� SAMPLE ������ ����
DROP TABLE tb_pivot;

CREATE TABLE tb_pivot(year varchar(4),month number(2));

INSERT INTO tb_pivot VALUES('2021',	1 );
INSERT INTO tb_pivot VALUES('2021',	2 );
INSERT INTO tb_pivot VALUES('2021',	3 );
INSERT INTO tb_pivot VALUES('2021',	4 );
INSERT INTO tb_pivot VALUES('2021',	5 );
INSERT INTO tb_pivot VALUES('2021',	6 );
INSERT INTO tb_pivot VALUES('2021',	7 );
INSERT INTO tb_pivot VALUES('2021',	8 );
INSERT INTO tb_pivot VALUES('2021',	9 );
INSERT INTO tb_pivot VALUES('2021',	10);
INSERT INTO tb_pivot VALUES('2021',	11);
INSERT INTO tb_pivot VALUES('2021',	12);

COMMIT;

SELECT *
FROM tb_pivot;






