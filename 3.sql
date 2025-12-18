SELECT COUNT(*) FROM users;
SELECT * FROM users LIMIT 10;
SELECT * FROM users ORDER BY name LIMIT 20;

SELECT * FROM users ORDER BY age LIMIT 20;
SELECT * FROM users WHERE age BETWEEN 20 and 29 ORDER BY age LIMIT 20;


SELECT * FROM stores LIMIT 20;

SELECT type, name FROM stores GROUP BY type;

-- 통합(그룸핑)을 했으면?? 결국 내가 알고싶은것은 그것에 대한 합산/평균/ 등등..

SELECT type, COUNT(name) FROM stores GROUP BY type;
SELECT type, COUNT(name) FROM stores GROUP BY type ORDER BY COUNT(name) DESC;
SELECT type, COUNT(name) AS num_of_stores FROM stores GROUP BY type ORDER BY num_of_stores DESC;
-- SELECT type, COUNT(name) AS num_of_stores FROM stores WHERE num_of_stores > 20 GROUP BY type ORDER BY num_of_stores DESC; xxxxxx

SELECT type, COUNT(name) AS num_of_stores 
FROM stores 
GROUP BY type 
HAVING num_of_stores > 20 
ORDER BY num_of_stores DESC;

-- ITEM을 가지고 ..
-- Q1. 그룹별로 각 그룹별로 상품은 몇개나 있는가??
SELECT type, COUNT(Name) FROM items GROUP BY type;
-- Q2. 그룹별로의 평균 가격은 어떻게 되는가??
SELECT type, AVG(UnitPrice) FROM items GROUP BY type;
-- Q3. 가격이 비싼 순으로 Top5/Top3는 어떻게 되는가??
SELECT type, UnitPrice FROM items GROUP BY type ORDER BY UnitPrice DESC;

SELECT type, UnitPrice FROM items GROUP BY type HAVING UnitPrice > 5000 ORDER BY UnitPrice DESC;

-- 연령대.....
SELECT 
    CASE
        WHEN age < 20 THEN "10/20대"
        WHEN age < 40 THEN "30대"
        ELSE "40대이후"
    END AS age_band,
    COUNT(*) AS user_cnt
FROM users
GROUP BY age_band
ORDER BY user_cnt DESC;


SELECT 케이스 AS age_band, COUNT(*) AS user_cnt FROM users;

SELECT age FROM users Where age > 20;

--------------------------------------------------------

-- 이너조인 (inner join)
-- 사용자 주문에 이름 붙이기..

SELECT Id, OrderAt, UserId FROM orders LIMIT 10;

SELECT Id, name, Address FROM users WHERE Id="ab2e716f-7614-455d-964d-f56a48eb8ba7";

SELECT Id, OrderAt, UserId FROM orders o JOIN users u On o.UserId = u.Id;

SELECT o.Id, o.OrderAt, o.UserId, u.Id, u.Name, u.Address FROM orders o JOIN users u On o.UserId = u.Id LIMIT 10;

SELECT o.Id, o.OrderAt, u.Name, u.Address FROM orders o JOIN users u On o.UserId = u.Id LIMIT 10;

-- 이너조인은 안쪽 즉 공통분모를 찾아서 합치는것 주문이 있으면? 주문한 고객이 있음
-- 고객이 있으면? 주문한게 무조건 있나요? LEFT JOIN
-- 왼쪽 테이블을 유지한다.. 그리고 ~~~ 더해서 남의 테이블정보를 가져온다..

SELECT u.id, u.name, COUNT(o.id) AS order_cnt FROM users u LEFT JOIN orders o ON u.id = o.userid GROUP BY u.id ORDER BY order_cnt DESC;

-- 주문에서 주문아이템 아이템
-- orders orderitems items

SELECT o.id, o.orderat, i.name FROM orders o 
JOIN orderitems oi ON o.id = oi.orderid 
JOIN items i ON oi.itemid = i.id
ORDER BY o.orderat
LIMIT 20;

SELECT
  o.id AS order_id,
  o.orderAt,
  i.name AS item_name,
  COUNT(*) AS qty
FROM orders o
JOIN order_items oi ON o.id = oi.orderId
JOIN items i        ON oi.itemId = i.id
GROUP BY o.id, i.name
ORDER BY o.orderAt
LIMIT 20;

--------------------------------
SELECT id, name, age, address 
FROM users
WHERE id in (SELECT userid FROM orders GROUP BY userid HAVING count(*) >= 2)
ORDER BY id;