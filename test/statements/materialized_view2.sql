CREATE MATERIALIZED VIEW top_100_buyers AS
SELECT c.first_name, c.last_name, SUM(o.product_quantity * p.price) AS total_amount FROM orders o
JOIN customer c ON o.customer_id = c.id
JOIN product p ON o.product_id = p.id
GROUP BY first_name, last_name
ORDER BY total_amount DESC
LIMIT 100;
