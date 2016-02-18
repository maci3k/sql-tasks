# PostgreSQL - Basics of full text search

## Summary

Provide SQL query that will efficiently search textual data for words occurrences in specific manner.  

## Goal

There is a table that contains 20 sample dog breeds. We would like to filter out that data searching for records that contain:

* 'friendly' and 'family' in `temperament` column
* 'hunting' or 'gundog' or 'retrieve' in `family`, `original_function` or `temperament`
* 'herding' or 'sheepdog' or 'livestock' but not contain 'mastiff'; in `family` or `original_function`

Save your queries in following files: `solution/search1.sql`, `solution/search2.sql` and `solution/search3.sql`

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

### Run tests

    npm test


