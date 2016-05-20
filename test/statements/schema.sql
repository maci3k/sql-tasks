DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE SEQUENCE breed_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

CREATE TABLE breed (
	id bigint DEFAULT nextval('breed_id_seq'::regclass) NOT NULL,
	name varchar(512),
	family varchar(512),
	origin varchar(512),
	original_function varchar(512),
	male_height_min integer,
	male_height_max integer,
	male_weight_min integer,
	male_weight_max integer,
	female_height_min integer,
	female_height_max integer,
	female_weight_min integer,
	female_weight_max integer,
	other_names varchar(512)
);

ALTER TABLE ONLY breed ADD CONSTRAINT breed_pk PRIMARY KEY (id);
