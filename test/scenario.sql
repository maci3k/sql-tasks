--statement="statements/schema.sql"  seed schema
--statement="../solution/alters.sql" alters.sql
--statement="statements/insert_data.sql" seed data

--statement
SELECT u.id, u.nickname, a.country FROM users u JOIN address a ON u.address_id = a.id ORDER BY country;
--expect="expectations/expected_users.csv" users nicknames and their countries

--statement
SELECT u.nickname, p.name AS product_name, p.price AS product_price FROM product p JOIN users u ON p.user_id = u.id ORDER BY price DESC;
--expect="expectations/expected_users2.csv" users nicknames and their products with price

--statement
SELECT u.email, COUNT(o.user_id) AS amount_of_orders FROM orders o JOIN users u ON o.user_id = u.id GROUP BY u.email ORDER BY COUNT(o.user_id) DESC;
--expect="expectations/expected_users3.csv" users emails and their orders quantity

--statement
SELECT u.nickname, p.name AS product_name, TO_CHAR(o.order_date,'YYYY-MM-DD') AS order_date FROM orders o
LEFT OUTER JOIN users u ON o.user_id = u.id
LEFT OUTER JOIN product p ON o.product_id = p.id
ORDER BY order_date;
--expect="expectations/expected_users4.csv" users nicknames and their orders (product + date)

--statement
SELECT u.nickname, p.name AS product_name, a.rating AS product_rating FROM assessment a
LEFT OUTER JOIN users u ON a.user_id = u.id
LEFT OUTER JOIN product p ON a.product_id = p.id
ORDER BY product_name DESC;
--expect="expectations/expected_users5.csv" users nicknames and their assessments (product + rate)

--statement
DELETE FROM users WHERE id = 1;
SELECT * FROM users;
--expect="expectations/expected_users6.csv" updated users list after delete user

--statement
SELECT * FROM product;
--expect="expectations/expected_users7.csv" updated product list after delete user

--statement
 SELECT id, user_id, product_id, TO_CHAR(order_date,'YYYY-MM-DD') AS order_date FROM orders;
--expect="expectations/expected_users8.csv" updated orders list after delete user

--statement
 SELECT * FROM assessment;
--expect="expectations/expected_users9.csv" updated assessment list after delete user

--statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Crosss', 21, 'Villeneuve-d', '59-652', 'France');
 SELECT * FROM address;
--expect="expectations/expected_users10.csv" updated addresses list after insert new correct address

--statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 211, 'Villeneuve-d', '59-652', 'France');
 SELECT * FROM address;
--expect="expectations/expected_users11.csv" updated addresses list after insert new correct address

 --statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 21, 'Villeneuve', '59-652', 'France');
 SELECT * FROM address;
--expect="expectations/expected_users12.csv" updated addresses list after insert new correct address

 --statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 21, 'Villeneuve-d', '59-52', 'France');
 SELECT * FROM address;
--expect="expectations/expected_users13.csv" updated addresses list after insert new correct address

 --statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 21, 'Villeneuve-d', '59-652', 'Francja');
 SELECT * FROM address;
--expect="expectations/expected_users14.csv" updated addresses list after insert new correct address

--statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 21, 'Villeneuve-d', '59-652', 'France');
 SELECT * FROM address;
--expect SQL-23505 error after insert address that already exists
 code, name
 SQL-23505, error

--statement
INSERT INTO users (nickname, email, gender, address_id) values ('Geraldes', 'gfreeman1@parallels.com', 'Male', 1);
--expect SQL-23505 error after insert user that email already exists
 code, name
 SQL-23505, error

--statement
INSERT INTO users (nickname, email, gender, address_id) values ('Gerald', 'g@parallels.com', 'Male', 1);
--expect SQL-23505 error after insert user that nickname already exists
 code, name
 SQL-23505, error
