--statement="../solution/schema.sql" Seed schema
--statement insert valid row
INSERT INTO users(email) VALUES ('example@email.com'),('another@email.com');
--statement
SELECT * FROM users;
--expect 2 users
id,email
1,example@email.com
2,another@email.com
--statement="statements/select_all_users.sql" Select all users
--expect="expectations/expected_users.csv" 2 users
--statement insert incorrect row
INSERT INTO users(email) VALUES (1,2,3,4)
--expect syntax error
name,code
error,SQL-42601
--required expression="users" file="../solution/schema.sql" use "users" table
