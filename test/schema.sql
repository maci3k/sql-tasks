DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public AUTHORIZATION realskill;

CREATE TABLE student (
  id SERIAL,
  email TEXT NOT NULL,
  first_name TEXT,
  last_name TEXT
);

ALTER TABLE ONLY student
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE ONLY student
ADD CONSTRAINT student_pk PRIMARY KEY (id);
