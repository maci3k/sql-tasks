--statement="../solution/schema.sql"
--statement
INSERT INTO users(email) VALUES ('example@email.com'),('another@email.com');
SELECT * FROM users;
--expect
id,email
1,example@email.com
2,another@email.com
