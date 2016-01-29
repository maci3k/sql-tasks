# PostgreSQL - JSON builiding and aggregation

## Summary

PostgreSQL 9.3 introduced json support to the database. One of many improvements was ability to aggregate rows set into json array. Next version - 9.4 introduced building json in convenient way on the data query language level. This task examine knowledge 
of both that capabilities.

## Goal

Table `breed` describe dogs breeds with few basic characteristics like origin, original function or sizes. The goal of this task is to aggregate breeds by their origin so that gives a 3-column result set as shown table below.

| origin | count | breeds |
|--------|-------|--------|
| Canada | 2 | json |
| China | 1 | json |
| England | 4 | json |
| France | 1 | json |
| Germany | 4 | json |
| Great Britain | 1 | json |
| Ireland | 1 | json |
| Japan | 1 | json |
| Mexico | 1 | json |
| Scotland | 2 | json |
| United States | 1 | json |
| Yugoslavia | 1 | json |

Column `count` should be a total number of breeds from each origin. 
Field `breeds` should contain json array of objects with breeds originated each origin. Each object of that array should have two properties: `name` and `family` which are values of corresponding `breed` table columns. Listing below represent `breeds` column 
value for first group - Canada.

```
[
    {
        "name" : "Labrador Retriever", 
        "family" : "gundog, retriever"
    }, 
    {
        "name" : "Newfoundland",
        "family" : "livestock dog, sheepdog, mastiff"
    }
]
```

Finally, sort result alphabetically by origin.  
*For tests assertion purpose, please cast breeds `json` field into `text` data type.*

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
