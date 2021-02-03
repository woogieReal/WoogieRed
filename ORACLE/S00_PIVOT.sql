--PIVOT | UNPIVOT
--PIVOT: ROW단위를 COLUMN 단위로 변경
--UNPIVOT: COLUMN단위를 ROW단위로 변경
--컬럼 값을 기준으로 새로운 컬럼을 도출하여 다양한 집계함수를 적용가능

--PIVOT에 SAMPLE 데이터 생성
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






