-- 12. line_item_track.sql: 각 송장 라인 항목에 구매한 트랙 이름을 포함하는 쿼리를 제공합니다.
-- 12. line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

SELECT t.Name AS TrackName
FROM invoice_items li
JOIN tracks t ON li.TrackId = t.TrackId;