-- 4. sales_agents.sql: 판매 대리인인 직원만 표시하는 쿼리를 제공하십시오.

SELECT LastName || ' ' || FirstName AS FullName FROM employees WHERE employees.Title LIKE "Sales%";