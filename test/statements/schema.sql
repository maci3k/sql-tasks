DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

--SEQUENCES

CREATE SEQUENCE address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE assessment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--CORE MODEL

CREATE TABLE address (
  id BIGINT DEFAULT nextval('address_id_seq'::regclass) NOT NULL,
  street TEXT NOT NULL,
  number BIGINT NOT NULL,
  city TEXT NOT NULL,
  zip_code TEXT NOT NULL,
  country TEXT NOT NULL
);

CREATE TABLE users (
  id BIGINT DEFAULT nextval('user_id_seq'::regclass) NOT NULL,
  nickname TEXT NOT NULL,
  email TEXT NOT NULL,
  gender TEXT NOT NULL
);

CREATE TABLE product (
  id BIGINT DEFAULT nextval('product_id_seq'::regclass) NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  price FLOAT NOT NULL
);

CREATE TABLE assessment (
  id BIGINT DEFAULT nextval('assessment_id_seq'::regclass) NOT NULL,
  rating INTEGER NOT NULL,
  comment TEXT NOT NULL
);

CREATE TABLE orders (
  id BIGINT DEFAULT nextval('order_id_seq'::regclass) NOT NULL,
  order_date DATE NOT NULL
);

--PRIMARY KEYS
ALTER TABLE ONLY address ADD CONSTRAINT address_PK PRIMARY KEY (id);
ALTER TABLE ONLY users ADD CONSTRAINT user_PK PRIMARY KEY (id);
ALTER TABLE ONLY product ADD CONSTRAINT product_PK PRIMARY KEY (id);
ALTER TABLE ONLY assessment ADD CONSTRAINT assessment_PK PRIMARY KEY (id);
ALTER TABLE ONLY orders ADD CONSTRAINT order_PK PRIMARY KEY (id);
