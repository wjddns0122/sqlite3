-- 8. total_invoices_{year}.sql: 2009년과 2011년에 몇 개의 인보이스가 있었습니까?
-- 8. total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?
-- sqlite> .schema invoices

-- CREATE TABLE IF NOT EXISTS "invoices"
-- (
--     [InvoiceId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--     [CustomerId] INTEGER  NOT NULL,
--     [InvoiceDate] DATETIME  NOT NULL,
--     [BillingAddress] NVARCHAR(70),
--     [BillingCity] NVARCHAR(40),
--     [BillingState] NVARCHAR(40),
--     [BillingCountry] NVARCHAR(40),
--     [BillingPostalCode] NVARCHAR(10),
--     [Total] NUMERIC(10,2)  NOT NULL,
--     FOREIGN KEY ([CustomerId]) REFERENCES "customers" ([CustomerId])
-- 		ON DELETE NO ACTION ON UPDATE NO ACTION
-- );
-- CREATE INDEX [IFK_InvoiceCustomerId] ON "invoices" ([CustomerId]);
SELECT SUM(Total) FROM invoices WHERE InvoiceDate LIKE '2009%' OR InvoiceDate LIKE '2011%';