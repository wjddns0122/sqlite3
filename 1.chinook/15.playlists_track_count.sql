-- 15. playlists_track_count.sql: 각 재생 목록의 총 트랙 수를 표시하는 쿼리를 제공합니다. 재생 목록 이름은 결과 테이블에 포함되어야 합니다.
-- 15. playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.

SELECT 
    p.Name AS PlaylistName, 
    COUNT(pt.TrackId) AS TotalTracks
FROM playlists p
JOIN playlist_track pt ON p.PlaylistId = pt.PlaylistId
GROUP BY p.PlaylistId, p.Name;