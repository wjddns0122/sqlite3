-- 16. Tracks_no_id.sql: 모든 트랙을 표시하지만 ID는 표시하지 않는 쿼리를 제공합니다. 결과에는 앨범 이름, 미디어 유형 및 장르가 포함되어야 합니다.
-- 16. Tracks_no_id.sql: Provide a query that shows all tracks, but do not display the ID. The result should include the Album name, Media type and Genre.

SELECT t.Name, a.Title AS AlbumName, mt.Name AS MediaType, g.Name AS Genre
FROM tracks t
JOIN albums a ON t.AlbumId = a.AlbumId
JOIN media_types mt ON t.MediaTypeId = mt.MediaTypeId
JOIN genres g ON t.GenreId = g.GenreId;
