-- 6. sales_agent_invoices.sql: 각 판매 에이전트와 연결된 송장을 표시하는 쿼리를 제공합니다. 결과 테이블에는 영업 에이전트의 전체 이름이 포함되어야 합니다.
-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT e.LastName || ' ' || e.FirstName AS FullName , i.InvoiceId
FROM employees e 
JOIN customers c ON e.EmployeeId = c.SupportRepId
JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE e.Title LIKE "Sales%";
