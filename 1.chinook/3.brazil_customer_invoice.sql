-- 3. brazil_customers_invoices.sql: 브라질 고객의 송장을 보여주는 쿼리를 제공합니다. 결과 테이블에는 고객의 전체 이름, 송장 ID, 송장 날짜 및 청구 국가가 표시되어야 합니다.

SELECT c.firstname || ' ' || c.lastname AS FullName, i.InvoiceId, i.InvoiceDate, i.BillingCountry 
FROM customers c 
JOIN invoices i ON c.CustomerId = i.CustomerId 
WHERE c.Country = "Brazil";