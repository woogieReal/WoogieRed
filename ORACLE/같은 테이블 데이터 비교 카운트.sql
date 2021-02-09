SELECT empno, ename, hiredate, ROWNUM-1 COUNT
FROM(
	SELECT empno, ename, hiredate
	FROM emp
	ORDER BY hiredate
)
;

SELECT t1.empno,
	t1.ename,
	t1.hiredate,
	COUNT(t2.hiredate)
FROM emp t1, emp t2
WHERE t1.hiredate > t2.hiredate(+)
GROUP BY t1.empno,t1.ename,t1.hiredate
ORDER BY t1.hiredate
;