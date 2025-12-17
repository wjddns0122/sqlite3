-- 10. invoice_37_line_item_count.sql: InvoiceLine 테이블을 보고 Invoice ID 37에 대한 라인 항목 수를 계산하는 쿼리를 제공합니다.
-- 10. invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

-- CREATE TABLE IF NOT EXISTS "invoice_items"
-- (
--     [InvoiceLineId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--     [InvoiceId] INTEGER  NOT NULL,
--     [TrackId] INTEGER  NOT NULL,
--     [UnitPrice] NUMERIC(10,2)  NOT NULL,
--     [Quantity] INTEGER  NOT NULL,
--     FOREIGN KEY ([InvoiceId]) REFERENCES "invoices" ([InvoiceId])
-- 		ON DELETE NO ACTION ON UPDATE NO ACTION,
--     FOREIGN KEY ([TrackId]) REFERENCES "tracks" ([TrackId])
-- 		ON DELETE NO ACTION ON UPDATE NO ACTION
-- );
-- CREATE INDEX [IFK_InvoiceLineInvoiceId] ON "invoice_items" ([InvoiceId]);
-- CREATE INDEX [IFK_InvoiceLineTrackId] ON "invoice_items" ([TrackId]);

SELECT (i.InvoiceId + i.TrackId + i.UnitPrice + i.Quantity) AS TotalSum FROM invoice_items i WHERE i.InvoiceLineId = 37;