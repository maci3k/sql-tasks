--statement="statements/schema.sql" seed schema
--statement="../solution/query.sql" query.sql
--statement="statements/insert_data.sql" insert data

--statement select student
 SELECT * FROM student;
--expect="expectations/expected_users.csv" student list

--statement insert new student
 INSERT INTO student (first_name, last_name, email) VALUES ('John', 'Smith', 'smithjohn@dot.com');
 SELECT * FROM student;
--expect="expectations/expected_users2.csv" student list after insert new student
