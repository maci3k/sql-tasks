CREATE MATERIALIZED VIEW daily_sum_of_orders AS
SELECT TO_CHAR(order_date,'YYYY-MM-DD') AS order_date, SUM(product_quantity)AS product_total
FROM orders GROUP BY order_date ORDER BY order_date DESC;
