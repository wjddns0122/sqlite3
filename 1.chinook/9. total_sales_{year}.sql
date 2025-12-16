-- 9. total_sales_{year}.sql: What are the respective total sales for each of those years?
-- 9. total_sales_{year}.sql: 각 연도의 총 매출은 얼마입니까?

-- sqlite> .schema invoices
SELECT SUM(Total) FROM invoices WHERE InvoiceDate LIKE "2009%"; 
SELECT SUM(Total) FROM invoices WHERE InvoiceDate LIKE "2010%";
SELECT SUM(Total) FROM invoices WHERE InvoiceDate LIKE "2011%";
SELECT SUM(Total) FROM invoices WHERE InvoiceDate LIKE "2012%";
SELECT SUM(Total) FROM invoices WHERE InvoiceDate LIKE "2013%";