# PostgreSQL - CRUD

## Summary

Provide SQL schema and perform basic CRUD operations.

## Goals

Create `car` schema with automatically generated **id** (1,2,3...) according to the structure below (`solution/schema.sql`):

| car                        | 
|----------------------------|
| id (PK)                    |
| brand **STR**              |
| year_of_manufacture **INT**|
| color **STR**              |
| weight **FLOAT**           |
| secondhand **BOOL**        |

Add to the `car` table two rows with data like below (`solution/insert.sql`): 

|  id   | brand       | year_of_manufacture | color        | weight  | secondhand |
|-------|-------------|---------------------|--------------|---------|------------|
|  1    | Bentley     | 1988                | red metallic | 1002.72 | false      |
|  2    | Suzuki      | 2002                | silver       | 1787.25 | true       |

Then execute queries which:

* choose name and weight the heaviest car of all vehicles (`solution/select_the_heaviest_car.sql`)

|  brand  | weight      |
|---------|-------------|
|  Suzuki | 1787.25     |

* choose the brand, year of production and color of all unused cars, produced in 2000 (or below), which color is a variation of the red, sorted by the earliest year of production (`solution/select_unused_cars.sql`)

| brand    | year_of_manufacture | color        | 
|----------|---------------------|--------------|
| Tata     | 1981                | red          |
| Bentley  | 1988                | red metallic |

* change the oldest car as used (`solution/update.sql`) 

* remove all used cars, which in 2000 had more than 10 years (`solution/delete.sql`)

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
*Command below must be run from postgres system user* (switch to root user then switch to postgres by `su postgres`). When prompted for password, enter
 `realskill`.
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
