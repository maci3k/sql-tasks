DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

--SEQUENCES

CREATE SEQUENCE customer_id_seq
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

CREATE SEQUENCE order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--CORE MODEL

CREATE TABLE customer (
  id BIGINT DEFAULT nextval('customer_id_seq'::regclass) NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL
);

CREATE TABLE product (
  id BIGINT DEFAULT nextval('product_id_seq'::regclass) NOT NULL,
  name TEXT NOT NULL,
  price FLOAT NOT NULL
);

CREATE TABLE orders (
  id BIGINT DEFAULT nextval('order_id_seq'::regclass) NOT NULL,
  customer_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  product_quantity INTEGER NOT NULL
);

--PRIMARY KEYS
ALTER TABLE ONLY customer ADD CONSTRAINT customer_PK PRIMARY KEY (id);
ALTER TABLE ONLY product ADD CONSTRAINT product_PK PRIMARY KEY (id);
ALTER TABLE ONLY orders ADD CONSTRAINT orders_PK PRIMARY KEY (id);

--INDEXES
CREATE INDEX idx_orders__customer_id ON orders (customer_id);
CREATE INDEX idx_orders__product_id ON orders (product_id);

--FOREIGN KEYS
ALTER TABLE orders ADD CONSTRAINT fk_orders__customer_id FOREIGN KEY (customer_id) REFERENCES customer (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE orders ADD CONSTRAINT fk_orders__product_id FOREIGN KEY (product_id) REFERENCES product (id) ON UPDATE CASCADE ON DELETE CASCADE;
