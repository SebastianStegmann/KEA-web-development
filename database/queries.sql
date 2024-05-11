SELECT * FROM orders ORDER BY RANDOM() LIMIT 20


SELECT item_id, item_price FROM items

SELECT * FROM orders_items ORDER BY orders_items_order_fk

SELECT * FROM users WHERE user_email = 'admin@company.com'

UPDATE users
SET user_name = 'jude'
WHERE user_id = '77921e6026278234ad41f7707e1c954b'


SELECT * FROM users LIMIT 10

CREATE VIEW get_10_users AS
SELECT * FROM users Limit 10

SELECT * FROM get_10_users

DROP VIEW get_10_users

-- employees for the salary
-- users for name and last name
CREATE VIEW employees_info AS
SELECT user_name, user_last_name, employee_salary
FROM users 
JOIN employees 
ON user_id = employee_id

SELECT * FROM employees_info

SELECT * FROM users WHERE users.user_id = 'cfd1820f70a47d110320f9ac4876c41b'

SELECT user_name, user_last_name, employee_salary
FROM users 
JOIN employees 
ON user_id = employee_id
WHERE user_name LIKE '%e%' COLLATE NOCASE OR user_last_name LIKE '%x%' COLLATE NOCASE

-- get all usefull information on orders
-- pagination
-- join multiple tables OR create view
CREATE VIEW order_view_admin AS
SELECT 
    order_id, 
    user_id, 
    user_name,
    user_last_name, 
    user_email, 
    user_address, 
    orders_items_item_quantity, 
    item_name, 
    item_price, 
    orders_items_order_fk

FROM orders
INNER JOIN users ON order_created_by_user_fk = user_id
INNER JOIN orders_items ON order_id = orders_items_order_fk
INNER JOIN items ON orders_items_item_fk = item_id
ORDER BY order_id DESC 

-- check if an order has multiple items

SELECT
    orders_items_order_fk,
    COUNT(orders_items_order_fk) AS order_id_count
FROM
    orders_items
GROUP BY
    orders_items_order_fk
HAVING
    order_id_count > 1



-----



SELECT
    order_id,
    user_id,
    user_name,
    user_last_name,
    user_email,
    user_address,
    (
    SELECT GROUP_CONCAT(orders_items_item_quantity || ' ' || item_name || ' ' || item_price, ', ')
    FROM orders_items
    JOIN items ON orders_items_item_fk = item_id
    WHERE orders_items_order_fk = order_id
) AS order_items,
(
    SELECT SUM(GROUP_CONCAT(item_price, ', '))
    FROM orders_items
    JOIN items ON orders_items_item_fk = item_id
    WHERE orders_items_order_fk = order_id
) AS item_prices
FROM
    orders 
INNER JOIN users  ON order_created_by_user_fk = user_id
ORDER BY order_created_at DESC;



---- show total item price instead of list of prices

DROP VIEW order_view_admin

CREATE VIEW order_view_admin AS
SELECT
    order_id,
    order_created_at,
    order_delivered_at,
    order_delivered_by_user_fk,
    user_id,
    user_name,
    user_last_name,
    user_email,
    user_address,
    
    (
        SELECT GROUP_CONCAT(
            orders_items_item_quantity || ' ' || item_name || ' ' || item_price, ','
        ) 
        FROM orders_items
        JOIN items ON orders_items_item_fk = item_id
        WHERE orders_items_order_fk = order_id
    ) AS order_items,
    (
    SELECT item_created_by_user_fk
    FROM items
    WHERE item_id = (
        SELECT orders_items_item_fk
        FROM orders_items
        WHERE orders_items_order_fk = order_id
        LIMIT 1
    )
) AS partner_id,
    (
        SELECT SUM(item_price)
        FROM orders_items
        JOIN items ON orders_items_item_fk = item_id
        WHERE orders_items_order_fk = order_id
    ) AS total_item_price
FROM
    orders 
INNER JOIN users ON order_created_by_user_fk = user_id;



-- ORDER BY order_created_at DESC

SELECT COUNT(*) FROM users WHERE user_role_name = "customer"

SELECT * FROM order_view_admin
                  WHERE user_id = '93661369be9fbe4f1aafde5c8fcdeb7d'
                  LIMIT 10 OFFSET 0

SELECT user_id, user_name, user_last_name, user_email, user_tag_color, user_is_blocked, user_deleted_at
FROM users WHERE user_role_name = "customer" AND user_deleted_at BETWEEN 1 AND 2147483647





SELECT order_id, user_name, user_last_name, user_email, order_created_at, order_items, item_created_by_user_fk
     FROM order_view_admin  
     WHERE (order_id LIKE :word COLLATE NOCASE 
        OR user_name LIKE :word COLLATE NOCASE
        OR user_last_name LIKE :word COLLATE NOCASE
        OR user_email LIKE :word COLLATE NOCASE
        OR order_items LIKE :word COLLATE NOCASE)
     AND user_id LIKE '%'
     AND item_created_by_user_fk LIKE '%'


SELECT * FROM users 
                    WHERE user_name = 'as' COLLATE NOCASE 
                    OR user_last_name = 'as' COLLATE NOCASE



-- for DB phpmyadmin mandatory 
SELECT *
FROM orders
JOIN orders_items ON orders.order_id = orders_items.orders_items_order_fk
WHERE orders_items.orders_items_item_fk = '8ac35327102a91d34d3afa3085c73359';


CREATE PROCEDURE `get_orders_with_product`(IN `_item_id` BIGINT(20)) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER SELECT * FROM orders JOIN orders_items ON orders.order_id = orders_items.orders_items_order_fk WHERE orders_items.orders_items_item_fk = _item_id;


UPDATE orders 
SET order_delivered_at = unixepoch()
WHERE order_id = "7a29a0721ab0a7d81ec91132a8d27ec3"

SELECT COUNT(*) FROM users WHERE user_email = 'admin@company.com'