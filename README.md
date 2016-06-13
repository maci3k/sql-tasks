# PostgreSQL - Foreign Keys and Unique Index

## Summary
You are provided with a simplified "online shop" schema that consists of `address`, `users`, `product`, `order` and `assessment` tables. Unfortunately, it 
turned out that some relations are missing. Add necessary columns and constraints according to the requirements.

## Goals

First part of this task is ensurin schema consistency by adding following relations:

* from `users` to `address` and name the column `address_id`
* from `product` to `users` and name the column `user_id`
* from `orders` to `product` and name the column `product_id`
* from `orders` to `user` and name the column `user_id`
* from `assessment` to `product` and name the column `product_id`
* from `assessment` to `users` and name the column `users_id`

Your modifications should also guarantee data consistency after `DELETE` and `UPDATE` operations. 
In other words, if a product gets deleted, all dependent rows of orders and assessment should also be deleted. 

### Schema structure without consistency constraints:

| address   | users    | product     | orders      | assessment  | 
|-----------|----------|-------------|-------------|-------------| 
| id        | id       | id          | id          | id          | 
| street    | nickname | name        | order_date  | rating      | 
| number    | email    | description |             | comment     | 
| city      | gender   | price       |             |             |
| zip_code  |          |             |             |             |
| country   |          |             |             |             |

Second part of this task is to provide appropriate constraints that will ensure uniqueness of following fields:

* `users`.`nickname`
* `users`.`email`
* `address`'s fields: `street`, `number`, `city`, `zip_code` and `country` taken together

All your modifying queries put in the `solution/alters.sql` file.

## Setup

### Install dependencies 

```
npm install
```
 
### Database connection

You are required to provide valid connection to working PostgreSQL instance. This scaffolding is tested on PostgreSQL 9.4, however it should work on other 
database versions. 
If you just have installed fresh version of PostgreSQL server don't forget to enable listening, setting `listen_address = 'localhost'` in PostgreSQL configuration
 file (on most *nix system it's located at `/etc/postgresql/9.4/main/postgresql.conf`). You may also have to adjust Host Based Authentication Policy that is 
 described in `pg_hba.conf` file (recommended authentication method is MD5).
 
## User, database and schema

### Configuration on *nix systems

You can manually prepare database connection or use command below that will create user, database, and set appropriate ownerships.
*Command below must be run from postgres system user* (switch to root user then switch to postgres by `su postgres`). When prompted for password, enter
 password `realskill`.
```  
createuser realskill -P && createdb realskill -O realskill && psql -d realskill -c 'ALTER SCHEMA public OWNER TO realskill;'
```

### Configuration on Windows systems

#### Using GUI tools
Use pgadmin to set following configuration:
```
user: realskill
password: realskill
database: realskill
schema: public
```
Database and schema owner must be set to `realskill` user.

#### Using command line

Open Windows Command Prompt as administrator ([see help](https://technet.microsoft.com/en-us/library/cc947813.aspx)).

Create user `realskill` with `realskill` password.

```
createuser -P -U postgres -W realskill
```

You will be prompted for new user password twice, then postgres superuser password (default is **postgres**).

Create database `realskill` and set ownership to user `realskill` (you will be prompted for **postgres** password).

```
createdb -O realskill -U postgres -W realskill
```

Change schema public (of realskill database) ownership to user `realskill` (you will be prompted for **postgres** password).

```
psql -d realskill -U postgres -W -c "ALTER SCHEMA public OWNER TO realskill;"
```

### Alternative configuration

All you need is to install `docker` and `docker-compose`

* [docker](https://docs.docker.com/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/)

Then you can prepare environment for task on each system and not worry about configuration thanks to command:
    
    docker-compose up

Don't forget to turn off PostgreSQL if you have it already installed. 

### Run tests

    grunt test

Good luck!
