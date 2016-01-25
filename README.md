# SQL - Foreign Keys and Unique Index

## Summary
You are provided with a simplified "online shop" database schema with `address`, `users`, `product`, `order` and `assessment` tables. Unfortunately, it 
turned out that some of constraints are missing. Fix them according to the description - pay attention to the **keywords**.

## Goals

Each user must have an original (not used by another user) **nickname** and **email**. It is required to each of them should have an **address**. In the 
`address` table isn't allowed to add rows with exactly the same addresses but two users can have the same address. Each `product` belong to a specific **user**. The 
**user** can buy the **product** and this information is stored in a `orders` table. The **user** can also assess the **product** and comment it.

Names of new properties should be created according to the pattern: **singularNameOfTable_id** for example **user_id**. The necessary modifications add to 
`solution/schema.sql` file.

### Database structure without constraints:

| address   | users    | product     | orders      | assessment  | 
|-----------|----------|-------------|-------------|-------------| 
| id        | id       | id          | id          | id          | 
| street    | nickname | name        | order_date  | rating      | 
| number    | email    | description |             | comment     | 
| city      | gender   | price       |             |             |
| zip_code  |          |             |             |             |
| country   |          |             |             |             |



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
 
### User, database and schema

#### Configuration on *nix systems

You can manually prepare database connection or use command below that will create user, database, and set appropriate ownerships.
*Command below must be run from postgres system user* (switch to root user then switch to postgres by `su postgres`). When will be prompt for password, enter
 password `realskill`.
 
```  
createuser realskill -P && createdb realskill -O realskill && psql -d realskill -c 'ALTER SCHEMA public OWNER TO realskill;'
```

#### Configuration on Windows systems

Use pgadmin GUI tool to set following configuration:
```
user: realskill
password: realskill
database: realskill
schema: public
```
Database and schema owner must be set to `realskill` user.

### Run tests

    npm test


Good luck!
