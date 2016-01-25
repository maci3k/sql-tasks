--statement="../solution/schema.sql"
--statement="data.sql"

--statement
SELECT u.id, u.nickname, a.country
FROM users u JOIN address a ON u.address_id = a.id
ORDER BY country;

--expect users nicknames and their countries
id, nickname, country
3, Randy, France
1, Linda, United Kingdom
2, Gerald, United States
4, Benjamin, United States

--statement
SELECT u.nickname, p.name AS product_name, p.price AS product_price
FROM product p JOIN users u ON p.user_id = u.id
ORDER BY price DESC;

--expect users nicknames and their products with price
nickname, product_name, product_price
Linda,Apple iMac 27-Inch With Retina 5K Display,$212.10
Gerald,Lenovo ThinkCentre Chromebox Tiny Desktop,$147.27
Gerald,Dell Precision Tower 5810,$99.08
Gerald,Dell Optiplex 9020 Micro,$58.82
Randy,HP Z840 Workstation,$33.55

--statement
SELECT u.email, COUNT(o.user_id) AS amount_of_orders
FROM orders o JOIN users u ON o.user_id = u.id
GROUP BY u.email ORDER BY COUNT(o.user_id) DESC;

--expect users emails and their orders quantity
email, amount_of_orders
bbailey9@blinklist.com, 2
lhicks0@infoseek.co.jp, 2

--statement
SELECT u.nickname, p.name AS product_name, TO_CHAR(o.order_date,'YYYY-MM-DD') AS order_date FROM orders o
LEFT OUTER JOIN users u ON o.user_id = u.id
LEFT OUTER JOIN product p ON o.product_id = p.id
ORDER BY order_date;

--expect users nicknames and their orders (product + date)
nickname, product_name, order_date
Benjamin,Dell Optiplex 9020 Micro,2016-02-11
Benjamin,Lenovo ThinkCentre Chromebox Tiny Desktop,2016-03-11
Linda,HP Z840 Workstation,2016-05-01
Linda,Dell Precision Tower 5810,2016-07-13

--statement
SELECT u.nickname, p.name AS product_name, a.rating AS product_rating FROM assessment a
LEFT OUTER JOIN users u ON a.user_id = u.id
LEFT OUTER JOIN product p ON a.product_id = p.id
ORDER BY product_name DESC;

--expect users nicknames and their assessments (product + rate)
nickname, product_name, product_rating
Gerald, HP Z840 Workstation, 5
Linda, HP Z840 Workstation, 5
Benjamin, Apple iMac 27-Inch With Retina 5K Display, 4

--statement
DELETE FROM users WHERE id = 1;
SELECT * FROM users;

--expect updated users list after delete user
id, address_id, nickname, email, gender
2, 3, Gerald, gfreeman1@parallels.com, Male
3, 1, Randy, rgeorge2@moonfruit.com, Male
4, 3, Benjamin, bbailey9@blinklist.com, Male

--statement
SELECT * FROM product;

--expect updated product list after delete user
id, user_id, name, description, price
1, 2, Lenovo ThinkCentre Chromebox Tiny Desktop, scelerisque sed, $147.27
2, 2, Dell Precision Tower 5810, Lorem ipsum dolor sit amet, $99.08
4, 2, Dell Optiplex 9020 Micro, sed posuere libero dui id orci. Nam congue, $58.82
5, 3, HP Z840 Workstation, Etiam sit amet lectus quis est congue mollis, $33.55

--statement
 SELECT id, user_id, product_id, TO_CHAR(order_date,'YYYY-MM-DD') AS order_date FROM orders;

--expect updated orders list after delete user
id, user_id, product_id, order_date
3, 4, 4, 2016-02-11
4, 4, 1, 2016-03-11

--statement
 SELECT * FROM assessment;

--expect updated assessment list after delete user
 id, product_id, rating, comment, user_id
 1, 5, 5, Lorem ipsum dolor sit amet consectetur adipiscing elit, 2

--statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Crosss', 21, 'Villeneuve-d', '59-652', 'France');
 SELECT * FROM address;

--expect updated addresses list after insert new correct address
 id, street, number, city, zip_code, country
 1, Holy Cross, 21, Villeneuve-d, 59-652, France
 2, Tomscot, 3, Newtown, RG20, United Kingdom
 3, Kenwood, 92, Oklahoma City, 73-167, United States
 4, Holy Crosss, 21, Villeneuve-d, 59-652, France

--statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 211, 'Villeneuve-d', '59-652', 'France');
 SELECT * FROM address;

--expect updated addresses list after insert new correct address
 id, street, number, city, zip_code, country
 1, Holy Cross, 21, Villeneuve-d, 59-652, France
 2, Tomscot, 3, Newtown, RG20, United Kingdom
 3, Kenwood, 92, Oklahoma City, 73-167, United States
 4, Holy Crosss, 21, Villeneuve-d, 59-652, France
 5, Holy Cross, 211, Villeneuve-d, 59-652, France

 --statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 21, 'Villeneuve', '59-652', 'France');
 SELECT * FROM address;

--expect updated addresses list after insert new correct address
 id, street, number, city, zip_code, country
 1, Holy Cross, 21, Villeneuve-d, 59-652, France
 2, Tomscot, 3, Newtown, RG20, United Kingdom
 3, Kenwood, 92, Oklahoma City, 73-167, United States
 4, Holy Crosss, 21, Villeneuve-d, 59-652, France
 5, Holy Cross, 211, Villeneuve-d, 59-652, France
 6, Holy Cross, 21, Villeneuve, 59-652, France

 --statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 21, 'Villeneuve-d', '59-52', 'France');
 SELECT * FROM address;

--expect updated addresses list after insert new correct address
 id, street, number, city, zip_code, country
 1, Holy Cross, 21, Villeneuve-d, 59-652, France
 2, Tomscot, 3, Newtown, RG20, United Kingdom
 3, Kenwood, 92, Oklahoma City, 73-167, United States
 4, Holy Crosss, 21, Villeneuve-d, 59-652, France
 5, Holy Cross, 211, Villeneuve-d, 59-652, France
 6, Holy Cross, 21, Villeneuve, 59-652, France
 7, Holy Cross, 21, Villeneuve-d, 59-52, France

 --statement
 INSERT INTO address (street, number, city, zip_code, country) values ('Holy Cross', 21, 'Villeneuve-d', '59-652', 'Francja');
 SELECT * FROM address;

--expect updated addresses list after insert new correct address
 id, street, number, city, zip_code, country
 1, Holy Cross, 21, Villeneuve-d, 59-652, France
 2, Tomscot, 3, Newtown, RG20, United Kingdom
 3, Kenwood, 92, Oklahoma City, 73-167, United States
 4, Holy Crosss, 21, Villeneuve-d, 59-652, France
 5, Holy Cross, 211, Villeneuve-d, 59-652, France
 6, Holy Cross, 21, Villeneuve, 59-652, France
 7, Holy Cross, 21, Villeneuve-d, 59-52, France
 8, Holy Cross, 21, Villeneuve-d, 59-652, Francja

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
