-- 13. line_item_track_artist.sql: 구매한 트랙 이름과 아티스트 이름을 포함하는 쿼리를 각 송장 라인 항목과 함께 제공합니다.
-- 13. line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.


-- Parse error: no such column: t.ArtistId

SELECT t.Name AS TrackName, a.Name AS ArtistName 
FROM tracks t 
JOIN artists a ON t.ArtistId = a.ArtistId 
JOIN invoice_items i ON t.TrackId = i.TrackId;

-- Parse error: no such column: t.ArtistId

SELECT a.Name FROM artists a;
SELECT t.Name FROM tracks t;

SELECT * FROM artists a JOIN tracks t ON a.Name = t.Name;

SELECT 
    li.InvoiceLineId,
    t.Name AS TrackName,     
    art.Name AS ArtistName   
FROM invoice_items li
JOIN tracks t ON li.TrackId = t.TrackId           
JOIN albums alb ON t.AlbumId = alb.AlbumId        
JOIN artists art ON alb.ArtistId = art.ArtistId;  