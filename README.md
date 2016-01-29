# PostgreSQL - Foreign Keys and Unique Index

## Summary
You starts with a simplified "online shop" schema that have `address`, `users`, `product`, `order` and `assessment` tables. Unfortunately, it 
turned out that some reflations are missing. Add necessary columns and constraints according to the requirements.

## Goals

First part of this task it ensure schema consistency by modifications that will add following relations:

* from `users` to `address` and name the column `address_id`
* from `product` to `users` and name the column `user_id`
* from `orders` to `product` and name the column `product_id`
* from `orders` to `user` and name the column `user_id`
* from `assessment` to `product` and name the column `product_id`
* from `assessment` to `users` and name the column `users_id`

Your modifications should also guarantee data consistency after `DELETE` and `UPDATE` operations. Other words, if some product has been delete, all dependent rows of orders and assessment should be also delete. 

### Schema structure without consistency constraints:

| address   | users    | product     | orders      | assessment  | 
|-----------|----------|-------------|-------------|-------------| 
| id        | id       | id          | id          | id          | 
| street    | nickname | name        | order_date  | rating      | 
| number    | email    | description |             | comment     | 
| city      | gender   | price       |             |             |
| zip_code  |          |             |             |             |
| country   |          |             |             |             |

Second part of task is to provide appropriate constraints that will ensure uniqueness of following fields:

* `users`.`nickname`
* `users`.`email`
* `address`'s fields: `street`, `number`, `city`, `zip_code` and `country` taken together


## Setup

### Install dependencies 

```
npm install
```
 
### Database connection

You are required to provide valid connection to working PostgreSQL instance. This scaffolding is tested on PostgreSQL 9.4, however it should work on other 
database server version. 
If you just installed fresh version of PostgreSQL server don't forget to enable listening, setting `listen_address = 'localhost'` in PostgreSQL configuration
 file (on most *nix system it's located at `/etc/postgresql/9.4/main/postgresql.conf`). You may also have to adjust Host Based Authentication Policy that is 
 described in `pg_hba.conf` file (recommended authentication method is MD5).
 
## User, database and schema

### Configuration on *nix systems

You can manually prepare database connection or use command below that will create user, database, and set appropriate ownerships.
*Command below must be run from postgres system user* (switch to root user then switch to postgres by `su postgres`). When will be prompt for password, enter
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

You will be prompt for new user password twice, then postgres superuser password (default is **postgres**).

Create database `realskill` and set ownership to user `realskill` (you will be prompt for **postgres** password).

```
createdb -O realskill -U postgres -W realskill
```

Change schema public (of realskill database) ownership to user `realskill` (you will be prompt for **postgres** password).

```
psql -d realskill -U postgres -W -c "ALTER SCHEMA public OWNER TO realskill;"
```

### Run tests

    npm test

Good luck!
