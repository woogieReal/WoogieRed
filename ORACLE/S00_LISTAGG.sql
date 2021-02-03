--LISTAGG: 여러 ROW데이터를 하나의 ROW에서 합쳐서 보여주는 함수
--RETURN 데이터 4000BYTE를 넘으면 안됨
--LISTAGG(컬럼,'구분자') WITHIN GROUP (ORDER BY 컬럼2) 

--부서별 직원의 이름을 하나의 ROW로 출력
COL "LISTAGG" FOR A50
SELECT deptno, LISTAGG(ename,'-') WITHIN GROUP(ORDER BY hiredate)"LISTAGG"
FROM emp
GROUP BY deptno;
--    DEPTNO LISTAGG
------------ --------------------------------------------------
--        10 CLARK-KING-MILLER
--        20 SMITH-JONES-FORD
--        30 ALLEN-WARD-BLAKE-TURNER-MARTIN-JAMES


