# PostgreSQL - procedures & triggers for materialized views

## Summary
Materialized view is a database object that contains the results of a query and represents itself as a regular table. 
It is used to increase the performance on complex schemas with large records sets and to simplify queries. 
In this task simple schema is provided. Two materialized views are already created, but don't work as desired. 
Any change in physical tables data is not reflected in materialized views.

## Goals

The database consists of three tables:

| customer   | product  | orders            |  
|------------|----------|-------------------|
| id (PK)    | id (PK)  | id (PK)           | 
| first_name | name     | customer_id (FK)  | 
| last_name  | price    | product_id (FK)   |
| email      |          | order_date        |
|            |          | product_quantity  |

 and two views:
 
* `daily_sum_of_orders` - the sum of the products bought every day

| order_date | product_total  |
|------------|----------------|
| 2016-01-25 | 56             | 
| 2016-01-24 | 60             | 
| ...        | ...            | 


* `top_100_buyers` - 100 customers who spend the most money

| first_name   | last_name  | total_amount      |  
|--------------|------------|-------------------|
| Craig        | Rivera     | 4686.65           | 
| Douglas      | Brooks     | 4664.66           | 
| ...          | ...        | ...               |


Modify **daily_sum_of_orders.sql** and **top_100_buyers.sql** files so that the views refresh every time the data change in the depended physical tables. 
In other words, provide solution that will keep materialized views in sync with actual data.


## Setup

### Install dependencies 

```
npm install
```
 
### Database connection

You are required to provide valid connection to working PostgreSQL instance. This scaffolding is tested on PostgreSQL 9.4, however it should work on other 
database server version. 
If you have just installed fresh version of PostgreSQL server don't forget to enable listening, setting `listen_address = 'localhost'` in PostgreSQL configuration
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
