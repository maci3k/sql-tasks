--statement="../solution/schema.sql"
--statement insert valid row
INSERT INTO users(email) VALUES ('example@email.com'),('another@email.com');
SELECT * FROM users;
--expect users list
id,email
1,example@email.com
2,another@email.com
--statement insert incorrect row
INSERT INTO users(email) VALUES (1,2,3,4)
--expect syntax error
name,code
error,SQL-42601
