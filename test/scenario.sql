--statement="../solution/schema.sql"
--statement
INSERT INTO category (id, name) VALUES (1, 'Cars');
INSERT INTO category (id, name) VALUES (2, 'Bikes');
INSERT INTO category (id, name, parent_category_id) VALUES (3, 'Vans', 1);
INSERT INTO category (id, name, parent_category_id) VALUES (4, 'Pickups', 1);
INSERT INTO category (id, name, parent_category_id) VALUES (5, 'Mountains Bikes', 2);
INSERT INTO category (id, name, parent_category_id) VALUES (6, 'Cross country', 2);
INSERT INTO category (id, name, parent_category_id) VALUES (7, 'Chevrolette', 4);
INSERT INTO category (id, name, parent_category_id) VALUES (8, 'Other Pickups', 7);
INSERT INTO category (id, name, parent_category_id) VALUES (9, 'Oldies', 8);

INSERT INTO product (id, name, category_id) VALUES (1, 'Nissan Quest', 3);
INSERT INTO product (id, name, category_id) VALUES (2, 'Nissan Navarra', 4);
INSERT INTO product (id, name, category_id) VALUES (3, 'Verenti Mesh Acera', 5);
INSERT INTO product (id, name, category_id) VALUES (4, 'Top Fuel 9.9 SL', 6);
INSERT INTO product (id, name, category_id) VALUES (5, '1957 Chevrolet Truck 3100 Standard Cab Pickup 2-Door 4.6L', 9);
--statement="../solution/select_all_bikes.sql"
--expect="select_all_bikes1.csv"
--statement="../solution/select_all_cars.sql"
--expect="select_all_cars1.csv"
--statement
INSERT INTO product (id, name, category_id) VALUES (6, '1987 Chevrolet R10 Silverado Standard Cab Pickup 2-Door 5.7L', 9);
INSERT INTO product (id, name, category_id) VALUES (7, 'Ford : E-Series Van HIGHTOP CONV', 3);
--statement="../solution/select_all_cars.sql"
--expect="select_all_cars2.csv"
