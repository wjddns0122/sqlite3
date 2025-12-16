--  invoice_totals.sql: 모든 송장 및 고객에 대한 송장 합계, 고객 이름, 국가 및 판매 대리점 이름을 표시하는 쿼리를 제공합니다.
-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT i.InvoiceId, i.Total, c.FirstName || ' ' || c.LastName AS CustomerName, c.Country, e.FirstName || ' ' || e.LastName AS SaleAgentName
FROM invoices i
JOIN customers c ON i.CustomerId = c.CustomerId
JOIN employees e ON c.SupportRepId = e.EmployeeId;


-- .schema invoices
-- .schema customers
-- .schema employees
SELECT  c.FirstName||" "||c.LastName AS "Customer", i.BillingCountry, e.FirstName||" "||e.LastName AS "Sale Agent", i.Total 
FROM Invoices i 
JOIN Customers c ON c.CustomerId = i.CustomerId 
JOIN Employees e ON e.EmployeeId = c.SupportRepId;