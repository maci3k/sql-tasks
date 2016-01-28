DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE users (
  id BIGINT DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
  nickname TEXT NOT NULL,
  first_name TEXT,
  last_name TEXT,
  birth_date DATE NOT NULL
);

ALTER TABLE ONLY users
ADD CONSTRAINT unique_nickname UNIQUE (nickname);

ALTER TABLE ONLY users
ADD CONSTRAINT users_pk PRIMARY KEY (id);
