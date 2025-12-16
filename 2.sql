SELECT * FROM artists;

SELECT COUNT(*) FROM artists;
SELECT COUNT(*) AS artist_cnt FROM artists;

SELECT * FROM artists LIMIT 10;
SELECT name FROM artists LIMIT 10;

SELECT name FROM artists ORDER BY name DESC LIMIT 10;

-- Q. 트랙(노래)는 총 몇곡인가??
SELECT COUNT(*) FROM tracks;
SELECT COUNT(*) AS tracks_count FROM tracks;

-- Q.평균 곡의 길이 구하기
SELECT AVG(milliseconds) FROM tracks;
SELECT AVG(milliseconds)/1000 FROM tracks;
SELECT ROUND(AVG(milliseconds/1000)) FROM tracks;
SELECT ROUND(AVG(milliseconds/1000), 1) FROM tracks;
SELECT ROUND(AVG(milliseconds/1000), 0) FROM tracks;

-- Q. 용량이 큰 곡은? TOP 10으로..
SELECT name, bytes FROM tracks ORDER BY bytes DESC LIMIT 10;
SELECT name, (bytes/1000/1000) AS BytesInMB FROM tracks ORDER BY bytes DESC LIMIT 10;

-- Q. 곡 이름에 "Love" 라는 단어가 들어간 곡 찾기
SELECT trackid, name FROM tracks WHERE name LIKE '%Love%';
SELECT trackid, name FROM tracks WHERE name LIKE '%Love%' LIMIT 10;
SELECT trackid, name FROM tracks WHERE name LIKE '%Love %' OR '%love' LIMIT 10;

-- Q. 앨범별 트랙 갯수는?
-- album 테이블.. track 테이블..
SELECT * FROM track
JOIN albums ON tracks.albumid = albums.albumid;

SELECT count(*) FROM tracks JOIN albums ON tracks.albumid = albums.albumid;
SELECT count(*) FROM tracks JOIN albums ON tracks.albumid = albums.albumid LIMIT 20;

SELECT * FROM tracks JOIN albums ON tracks.albumid = albums.albumid;
SELECT * FROM tracks t JOIN albums a ON t.albumid = a.albumid LIMIT 20;

SELECT t.trackid, t.name, a.title FROM tracks t JOIN albums a ON t.albumid = a.albumid LIMIT 20;

SELECT a.albumid, a.title, COUNT(*) FROM tracks t JOIN albums a ON t.albumid = a.albumid GROUP BY a.albumid LIMIT 10;

SELECT a.albumid, a.title, COUNT(*) 
AS track_count FROM tracks t 
JOIN albums a ON t.albumid = a.albumid 
GROUP BY a.albumid 
ORDER BY track_count DESC LIMIT 10;

-- 1. non_usa_customers.sql: 미국에 거주하지 않는 고객(전체 이름, 고객 ID 및 국가)를 표시하는 쿼리를 제공합니다.
SELECT firstname || ' ' || lastname AS FullName, customerid, country FROM customers WHERE country != 'USA';



-- sqlite3 mycrm.db     <-- 새로운 db 만드는중..
-- .mode csv
-- .import user.csv users   <-- user.csv를 읽어서 users라는 테이블에 넣겠다.
-- .import store.csv stores
-- .import order.csv orders
-- .import item.csv items
-- .import orderitem.csv orderitems

-- .import --skip 1 user.csv users   <-- 헤더를 스킵하고 import 실행
-- .import --skip 1 store.csv stores
-- .import --skip 1 order.csv orders
-- .import --skip 1 item.csv items
-- .import --skip 1 orderitem.csv orderitems


-- 1. 특정 사용자가 주문한 주문 목록을 모두 출력하시오
-- 2. 특정 사용자가 주문한 상점명과 상품명을 모두 출력하시오
-- 3. 특정 사용자가 주문한 유닉한 상품명의 목록을 구하시오
-- 4. 특정 사용자가 주문한 매출액의 합산을 구하시오
-- 5. 상점별 월간 통계(매출액)을 구하시오
-- 6. 특정 사용자가 방문한 상점의 빈도가 높은 순서대로 소팅하여 상위 5개만 구하시오
-- 7. 구매한 매출액의 합산이 가장 높은 사용자 10명을 구하고 각각의 매출액을 구하시오
-- 99. 그 외에도, 남여 성별로, 지역별로, 등등 다양한 통계 구해보기

-- 스키마 데이터 id, orders 둘다 특정 형식 예진이 아이디 컴온
SELECT u.Id, u.Name, o.OrderAt
FROM "users" u
JOIN "orders" o ON u.Id = o.UserId
WHERE u.Id = 'b94a544a-87a0-4696-9863-eb3b1c140291';

-- CREATE TABLE stores (
--   Id TEXT,
--   Name TEXT,
--   Type TEXT,
--   Address TEXT
-- );    2번 구현해보기.. 일단 상점명과 상품명을 출력해야됌 (특정 사용자의 아이디를 찾고 그 사람이 주문한 상점명과 상품명 출력하기)

SELECT o.*
FROM orders o
WHERE o.UserId = 'b94a544a-87a0-4696-9863-eb3b1c140291'
ORDER BY o.OrderAt DESC;
