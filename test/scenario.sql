--statement="statements/schema.sql" Seed schema
--statement="statements/insert_data.sql" insert data

--statement select users
 SELECT *, TO_CHAR(birth_date,'YYYY-MM-DD') AS birth_date FROM users;
--expect="expectations/expected_users.csv" users list

--statement="../solution/query.sql" query.sql

--statement
 SELECT id, nickname, first_name, last_name, TO_CHAR(birth_date,'YYYY-MM-DD') AS birth_date, email FROM users;
--expect="expectations/expected_users2.csv" users list after add new NOT NULL column

--statement
 INSERT INTO users (nickname, first_name, last_name, birth_date, email) values ('ltaylor9', 'Linda', 'Taylor', '1964-01-14','ltaylor9@est.com');
 SELECT id, nickname, first_name, last_name, TO_CHAR(birth_date,'YYYY-MM-DD') AS birth_date, email FROM users;
--expect="expectations/expected_users3.csv" insert new user with unique nickname and email

--statement
 INSERT INTO users (nickname, first_name, last_name, birth_date, email) values ('ltaylord9', 'Linda', 'Taylor', '1964-01-14','test10@test.com');
--expect error when insert user without email that already exist
 code, name
 SQL-23505, error

--statement
 INSERT INTO users (nickname, first_name, last_name, birth_date) values ('ltaylor9', 'Linda', 'Taylor', '1964-01-14');
--expect error when insert user without email
 code, name
 SQL-23502, error

--statement
 INSERT INTO users (nickname, first_name, last_name, birth_date, email) values ('ltaylor9', 'Linda', 'Taylor', '1964-01-14',null);
--expect error when insert user email is null
 code, name
 SQL-23502, error

