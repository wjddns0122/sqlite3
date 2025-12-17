-- 14. country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY
-- 14. country_invoices.sql: 국가별 송장 수를 표시하는 쿼리를 제공합니다. 힌트: 그룹화 기준

SELECT BillingCountry, SUM(Total) FROM invoices GROUP BY BillingCountry;