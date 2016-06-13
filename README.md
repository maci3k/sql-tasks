# PostgreSQL scaffolding for RealSkill

You can quickly create PostgreSQL tasks by cloning this repository. 
The scaffolding provides PostgreSQL driver configuration, mocha tests setup and simple SQL test scenarios runner.

## Setup

### To install dependencies 

```
npm install
```

## PgSQL test runner

### Scenarios format

Provided runner parses plain text file as below (for syntax highlighting the sql format is recommended).
 
```
--statement="../solution/schema.sql" Seed schema
--statement insert valid row
INSERT INTO users(email) VALUES ('example@email.com'),('another@email.com');
--statement
SELECT * FROM users;
--expect 2 users
id,email
1,example@email.com
2,another@email.com
--statement="select_all_users.sql" Select all users
--expect="expected_users.csv" 2 users
--statement insert incorrect row
INSERT INTO users(email) VALUES (1,2,3,4)
--expect syntax error
name,code
error,SQL-42601
```

That would be translated into following scenarios:

```
Evaluate scenario
    Statement Seed schema
      ✓ should be successfull
    Statement insert valid row
      ✓ should be successfull
    Statement SELECT * FROM users;
      ✓ should return 2 users
    Statement Select all users
      ✓ should return 2 users
    Statement insert incorrect row
      ! error: INSERT has more expressions than target columns
        code: 42601
        routine: transformInsertRow 
      ✓ should return syntax error
```

Scenarios are composed of 2 types of instructions: `statement` and `expect`. Each instruction symbol must be prepended with `--`. Last executed `statement` 
result is stored and compared with subsequent `expect`. `Statement` and `expected` content can be provided inline (in subsequent lines, before next instruction
 symbol) as well as extracted into separate file (see example above). You can put some inline comment after `--statement` or `--expect` statement if 
 instruction doesn't point to external file. Those comments will be displayed with tests results.
 `Expect` must be a valid CSV data set, with column names in first row. You can expect data set response as well as SQL error. To test error you need to 
 specify 2x2 csv table as follows:
 
| name    | code           |
|---------|----------------|
| error   | SQL-errorCode  |

Code value must be [valid PostgreSQL error code](http://www.postgresql.org/docs/9.4/static/errcodes-appendix.html#ERRCODES-TABLE) prefixed with `SQL-` string.
Please place your test scenario in `test/scenario.sql` (you can find example scenario file there).
 
### Database connection

You are required to provide valid connection to working PostgreSQL instance. This scaffolding is tested on PostgreSQL 9.4, however it should work on other 
database versions. 
If you just installed fresh version of PostgreSQL server don't forget to enable listening, setting `listen_address = 'localhost'` in PostgreSQL configuration
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


