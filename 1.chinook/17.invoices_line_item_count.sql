-- 17. invoices_line_item_count.sql: 모든 송장을 표시하지만 송장 라인 항목의 수를 포함하는 쿼리를 제공합니다.
-- 17. invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT i.InvoiceId AS Id, COUNT(item.InvoiceLineId) AS Item 
FROM invoices i 
JOIN invoice_items item ON i.InvoiceId = item.InvoiceId 
GROUP BY i.InvoiceId, item.InvoiceId;