--statement="schema.sql"
--statement="data.sql"

--statement select users
 SELECT *, TO_CHAR(birth_date,'YYYY-MM-DD') AS birth_date FROM users;

--expect users list
 id,nickname,first_name, last_name, birth_date
 1,cfisher0,Chris,Fisher,1985-09-30
 2,kmatthews1,Kimberly,Matthews,1990-06-25
 3,tpeters2,Todd,Peters,1988-09-08
 4,blee3,Betty,Lee,1997-10-07
 5,smoreno4,Sharon,Moreno,1989-06-15
 6,imiller5,Irene,Miller,1986-03-26
 7,jlopez6,John,Lopez,1993-08-24
 8,acole7,Anthony,Cole,1997-09-07
 9,rcruz8,Rachel,Cruz,1971-04-10
 10,dparker9,Denise,Parker,1967-02-24

--statement="../solution/query.sql"

--statement
 SELECT id, nickname, first_name, last_name, TO_CHAR(birth_date,'YYYY-MM-DD') AS birth_date, email FROM users;

--expect users list after add new NOT NULL column
 id,nickname,first_name, last_name, birth_date,email
 1,cfisher0,Chris,Fisher,1985-09-30,test1@test.com
 2,kmatthews1,Kimberly,Matthews,1990-06-25,test2@test.com
 3,tpeters2,Todd,Peters,1988-09-08,test3@test.com
 4,blee3,Betty,Lee,1997-10-07,test4@test.com
 5,smoreno4,Sharon,Moreno,1989-06-15,test5@test.com
 6,imiller5,Irene,Miller,1986-03-26,test6@test.com
 7,jlopez6,John,Lopez,1993-08-24,test7@test.com
 8,acole7,Anthony,Cole,1997-09-07,test8@test.com
 9,rcruz8,Rachel,Cruz,1971-04-10,test9@test.com
 10,dparker9,Denise,Parker,1967-02-24,test10@test.com

--statement
 INSERT INTO users (nickname, first_name, last_name, birth_date, email) values ('ltaylor9', 'Linda', 'Taylor', '1964-01-14','ltaylor9@est.com');
 SELECT id, nickname, first_name, last_name, TO_CHAR(birth_date,'YYYY-MM-DD') AS birth_date, email FROM users;

--expect insert new user with unique nickname and email
 id,nickname,first_name, last_name, birth_date,email
 1,cfisher0,Chris,Fisher,1985-09-30,test1@test.com
 2,kmatthews1,Kimberly,Matthews,1990-06-25,test2@test.com
 3,tpeters2,Todd,Peters,1988-09-08,test3@test.com
 4,blee3,Betty,Lee,1997-10-07,test4@test.com
 5,smoreno4,Sharon,Moreno,1989-06-15,test5@test.com
 6,imiller5,Irene,Miller,1986-03-26,test6@test.com
 7,jlopez6,John,Lopez,1993-08-24,test7@test.com
 8,acole7,Anthony,Cole,1997-09-07,test8@test.com
 9,rcruz8,Rachel,Cruz,1971-04-10,test9@test.com
 10,dparker9,Denise,Parker,1967-02-24,test10@test.com
 11,ltaylor9,Linda,Taylor,1964-01-14,ltaylor9@est.com

--statement
 INSERT INTO users (nickname, first_name, last_name, birth_date, email) values ('ltaylor9', 'Linda', 'Taylor', '1964-01-14','test10@test.com');

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

