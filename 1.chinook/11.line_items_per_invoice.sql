-- 11. line_items_per_invoice.sql: InvoiceLine 테이블을 보고 각 Invoice에 대한 라인 항목 수를 계산하는 쿼리를 제공합니다. 힌트: 그룹화 기준
-- 11. line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT COUNT(i.InvoiceLineId) AS LineItemCount FROM invoice_items i GROUP BY i.InvoiceId;