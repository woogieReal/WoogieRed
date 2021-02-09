--1.
COL "직원이름" FOR A25
COL "MANAGER이름" FOR A25
COL "부서명" FOR A25
SELECT t1.last_name || ' ' || t1.first_name "직원이름",
	t3.last_name || ' ' || t3.first_name "MANAGER이름",
	t2.department_name "부서명",
	t2.department_id
FROM employees t1 LEFT OUTER JOIN departments t2 
ON t1.department_id = t2.department_id
LEFT OUTER JOIN employees t3
ON t1.manager_id = t3.employee_id
ORDER BY t1.department_id
;

--2.
COL "FULL_NAME" FOR A25
COL "DEPARTMENT_NAME" FOR A25
SELECT TT1.*
FROM(
	SELECT rownum rnum,T1.*
	FROM(
		SELECT t1.last_name || ' ' || t1.first_name "FULL_NAME",
			t2.department_name "DEPARTMENT_NAME",
			TO_CHAR(t1.hire_date,'YYYY-MM-DD')"HIRE_DATE",
			COUNT(*) OVER() "TOTAL"
		FROM employees t1 LEFT OUTER JOIN departments t2 
		ON t1.department_id = t2.department_id
		ORDER BY t1.hire_date
	)T1
)TT1
WHERE rnum BETWEEN 1 AND 15
;

--3.
SELECT 
	--ROWNUM " ",
	t1.employee_id,
	t1.first_name,
	TO_CHAR(t1.hire_date,'YYYY/MM/DD')"hire_date",
	COUNT(t2.hire_date) "COUNT"
FROM employees t1, employees t2
WHERE t1.hire_date < t2.hire_date(+)
GROUP BY t1.employee_id,t1.first_name,t1.hire_date
ORDER BY t1.hire_date DESC
;

--4
--모르겠습니다..