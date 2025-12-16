-- unique_invoice_countries.sql: 송장 테이블에서 청구 국가의 고유(unique)/고유(distinct) 목록을 표시하는 쿼리를 제공합니다.

SELECT DISTINCT BillingCountry FROM Invoices;
