# SQL - procedures & triggers for materialized views

## Summary
Materialized view is a database object that contains the results of a query, it is use to increase the speed of queries on very large databases. Now, you are 
provided with a simplified database of orders storing the large amounts of data and using two materialized views. Something goes wrong, because the views are 
the same despite changes in the database. 

## Goals

The database consist of three tables:

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


Modify **daily_sum_of_orders.sql** and **top_100_buyers.sql** files so that the views were refreshed when the change in the database affecting them.


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
