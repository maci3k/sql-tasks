DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;


CREATE SEQUENCE product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE product (
  id          BIGINT DEFAULT nextval('product_id_seq' :: REGCLASS) NOT NULL,
  name        CHARACTER VARYING(256)                               NOT NULL,
  category_id BIGINT                                               NOT NULL
);


CREATE TABLE category (
  id                 BIGINT DEFAULT nextval('category_id_seq' :: REGCLASS) NOT NULL,
  name               CHARACTER VARYING(256)                                NOT NULL,
  parent_category_id BIGINT
);


ALTER TABLE ONLY product
ADD CONSTRAINT product_pk PRIMARY KEY (id);


ALTER TABLE ONLY category
ADD CONSTRAINT category_pk PRIMARY KEY (id);


ALTER TABLE ONLY category
ADD CONSTRAINT fk___category___parent_category FOREIGN KEY (parent_category_id) REFERENCES category (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY product
ADD CONSTRAINT fk___product___category FOREIGN KEY (category_id) REFERENCES category (id) ON UPDATE CASCADE ON DELETE CASCADE;
