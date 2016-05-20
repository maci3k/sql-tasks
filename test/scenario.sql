--statement="statements/schema.sql" seed schema
--statement="statements/insert_data.sql" seed data

--statement="statements/materialized_view.sql" daily_sum_of_orders materialized view
--statement="statements/materialized_view2.sql" top_100_buyers materialized view

--statement="../solution/daily_sum_of_orders.sql" daily_sum_of_orders.sql
--statement="../solution/top_100_buyers.sql" top_100_buyers.sql

--statement select daily sum of orders
 SELECT * FROM daily_sum_of_orders;
--expect="expectations/daily_sum_of_orders_1.csv"

--statement select top 100 buyers
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_1.csv"

--statement insert order
 INSERT INTO orders (customer_id, product_id, product_quantity, order_date) VALUES (90, 688, 9, '2016-01-25');

--statement select daily sum of orders after insert specific order
 SELECT * FROM daily_sum_of_orders;
--expect="expectations/daily_sum_of_orders_2.csv"

--statement select top 100 buyers after insert specific order
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_2.csv"

--statement insert order
 INSERT INTO orders (customer_id, product_id, product_quantity, order_date) VALUES (9, 68, 4, '2015-11-01');

--statement select daily sum of orders after insert next order
 SELECT * FROM daily_sum_of_orders;
--expect="expectations/daily_sum_of_orders_3.csv"

--statement select top 100 buyers after insert next order
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_3.csv"

--statement delete order
 DELETE FROM orders WHERE id=54;

--statement select daily sum of orders after delete order
 SELECT * FROM daily_sum_of_orders;
--expect="expectations/daily_sum_of_orders_4.csv"

--statement delete customer
 DELETE FROM customer WHERE id=774;

--statement select top 100 buyers after delete order
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_4.csv"

--statement update product quantity in specific order
 UPDATE orders SET product_quantity=10 WHERE id=462;

--statement select daily sum of orders after update order
 SELECT * FROM daily_sum_of_orders;
--expect="expectations/daily_sum_of_orders_5.csv"

--statement update customer first and last name
 UPDATE customer SET first_name='Margaret', last_name='Smith' WHERE id=356;

--statement select top 100 buyers after update first and last name of customer
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_5.csv"

--statement update product price
  UPDATE product SET price=100.00 WHERE id=472;

--statement select top 100 buyers after update product price
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_6.csv"

--statement delete customer
 DELETE FROM customer WHERE id=356;

--statement select top 100 buyers after delete customer
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_7.csv"

--statement select daily sum of orders after delete customer
 SELECT * FROM daily_sum_of_orders;
--expect="expectations/daily_sum_of_orders_6.csv"

--statement delete product
  DELETE FROM product WHERE id=472;

--statement select top 100 buyers after delete product
 SELECT * FROM top_100_buyers;
--expect="expectations/top_100_buyers_8.csv"

--statement select daily sum of orders after delete product
 SELECT * FROM daily_sum_of_orders;
--expect="expectations/daily_sum_of_orders_7.csv"
