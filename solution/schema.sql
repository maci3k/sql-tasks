DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE SEQUENCE post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE thread_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE post (
  id          BIGINT                                 DEFAULT nextval('post_id_seq'::regclass) NOT NULL,
  body        TEXT,
  author_id   BIGINT                                 NOT NULL,
  thread_id   BIGINT                                 NOT NULL,
  create_date TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);


CREATE TABLE thread (
  id          BIGINT                                 DEFAULT nextval('thread_id_seq'::regclass) NOT NULL,
  title       CHARACTER VARYING(256)                 NOT NULL,
  body        TEXT,
  author_id   BIGINT                                 NOT NULL,
  create_date TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);


CREATE TABLE users (
  id          BIGINT                                 DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
  email       CHARACTER VARYING(256)                 NOT NULL
);


ALTER TABLE ONLY post
ADD CONSTRAINT post_pk PRIMARY KEY (id);


ALTER TABLE ONLY thread
ADD CONSTRAINT thread_pk PRIMARY KEY (id);


ALTER TABLE ONLY users
ADD CONSTRAINT unique_email UNIQUE (email);


ALTER TABLE ONLY users
ADD CONSTRAINT users_pk PRIMARY KEY (id);


ALTER TABLE ONLY post
ADD CONSTRAINT fk___post___author FOREIGN KEY (author_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY post
ADD CONSTRAINT fk___post___thread FOREIGN KEY (id) REFERENCES thread (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY thread
ADD CONSTRAINT fk___thread___author FOREIGN KEY (id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
