# PostgreSQL stored procedures & triggers for nested categories

## Summary

Get all products from given category or any child category with single query.
 
# Goal

We have simple shop schema with products associated with only one category. Categories may have parent categories.
Until now we were displaying only products associated directly with given category.

```
SELECT
  product.id,
  product.name,
  product.category_id
FROM product
WHERE product.category_id=?
```

Now we want to be able to retrieve all products from given category or any of it's child categories in single query.
Read about [Storing Hierarchical Data in a Database](http://www.sitepoint.com/hierarchical-data-database-2/) by Gijs Van Tulder and adjust schema appropriately.
Keep in mind that `lft` and `rtg` must be recalculated whenever category tree changes, so you will need to add stored procedures and triggers
to update the `lft` and `rtg` values.

You can modify `solution/schema.sql`, `solution/select_all_bikes.sql` and `solution/select_all_cars.sql`

`select_all_bikes.sql` should contain query that retrieves all products (id,name,category_id) from category named `Bikes` or any of it's child categories, ordered by product id.
 
`select_all_cars.sql` should contain query that retrieves all products (id,name,category_id) from category named `Cars` or any of it's child categories, ordered by product id.

## Setup

### To install dependencies 

```
npm install
```

## PgSQL test runner

### Database connection

You are required to provide valid connection to working PostgreSQL instance. This scaffolding is tested on PostgreSQL 9.4, however it should work on other 
database versions. 
If you just installed fresh version of PostgreSQL server don't forget to enable listening, setting `listen_address = 'localhost'` in PostgreSQL configuration
 file (on most *nix system it's located at `/etc/postgresql/9.4/main/postgresql.conf`). You may also have to adjust Host Based Authentication Policy that is 
 described in `pg_hba.conf` file (recommended authentication method is MD5).
 
## User, database and schema

### Configuration on *nix systems

You can manually prepare database connection or use command below that will create user, database, and set appropriate ownerships.
*Command below must be run from postgres system user* (switch to root user then switch to postgres by `su postgres`). When will be prompted for password, enter
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
