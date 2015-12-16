CREATE TABLE posts (
  id          BIGINT                                 NOT NULL,
  body        TEXT,
  author_id   BIGINT                                 NOT NULL,
  thread_id   BIGINT                                 NOT NULL,
  create_date TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);


CREATE TABLE threads (
  id          BIGINT                                 NOT NULL,
  title       CHARACTER VARYING(256)                 NOT NULL,
  body        TEXT,
  author_id   BIGINT                                 NOT NULL,
  create_date TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);


CREATE TABLE users (
  id    BIGINT                 NOT NULL,
  email CHARACTER VARYING(256) NOT NULL
);


ALTER TABLE ONLY posts
ADD CONSTRAINT posts_pk PRIMARY KEY (id);


ALTER TABLE ONLY threads
ADD CONSTRAINT threads_pk PRIMARY KEY (id);


ALTER TABLE ONLY users
ADD CONSTRAINT unique_email UNIQUE (email);


ALTER TABLE ONLY users
ADD CONSTRAINT users_pk PRIMARY KEY (id);


ALTER TABLE ONLY posts
ADD CONSTRAINT fk___post___author FOREIGN KEY (id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY posts
ADD CONSTRAINT fk___post___thread FOREIGN KEY (id) REFERENCES threads (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY threads
ADD CONSTRAINT fk___thread___author FOREIGN KEY (id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
