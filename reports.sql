SELECT
    COUNT(*) AS total_orders,
    SUM(quantity * price * (1 - COALESCE(discount_pct, 0) / 100)) AS total_revenue,
    AVG(quantity * price * (1 - COALESCE(discount_pct, 0) / 100)) AS average_order_value
FROM orders
JOIN products
    ON orders.product_id = products.product_id;
    
    SELECT
    COUNT(*) AS total_orders,
    COUNT(rating) AS rated_orders,
    COUNT(*) - COUNT(rating) AS unrated_orders
FROM orders;

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);



SELECT
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE WHEN o.returned = TRUE THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        100.0 * SUM(CASE WHEN o.returned = TRUE THEN 1 ELSE 0 END)
        / COUNT(o.order_id),
        2
    ) AS return_rate
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING return_rate > 20;

SELECT
    c.customer_id,
    c.customer_name,
    SUM(
        o.quantity * p.price *
        (1 - COALESCE(o.discount_pct, 0) / 100)
    ) AS total_spend
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spend DESC
LIMIT 5;


SELECT
    c.customer_id,
    c.customer_name,
    SUM(
        o.quantity * p.price *
        (1 - COALESCE(o.discount_pct, 0) / 100)
    ) AS total_spend
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spend DESC
LIMIT 3 OFFSET 2;

SELECT
    p.category,
    COUNT(o.order_id) AS order_count,
    SUM(
        o.quantity * p.price *
        (1 - COALESCE(o.discount_pct, 0) / 100)
    ) AS revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY revenue DESC;

SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_name LIKE 'A%';

SELECT DISTINCT
    acquisition_source
FROM customers
ORDER BY acquisition_source;

USE mamaearth;

SET SQL_SAFE_UPDATES = 0;
UPDATE customers
SET loyalty_tier =
    CASE
        WHEN city IN (
            'Delhi',
            'Mumbai',
            'Bangalore',
            'Bengaluru',
            'Hyderabad',
            'Chennai',
            'Kolkata',
            'Pune'
        )
        THEN 'Gold'
        ELSE 'Silver'
    END;
SET SQL_SAFE_UPDATES = 1;
SELECT
    loyalty_tier,
    COUNT(*) AS customer_count
FROM customers
GROUP BY loyalty_tier;

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;