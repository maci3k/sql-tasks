# PostgreSQL scaffolding for RealSkill

You can quickly create PostgreSQL tasks by cloning this repository. 
The scaffolding provide PostgreSQL driver configuration, mocha tests setup and simple SQL test scenarios runner.

## Setup

### To install dependencies 

```
npm install
```

## PgSQL test runner

### Scenarios format

Provided runner parse plain text file as below. For syntax highlighting sql format is recommended.
 
```
--statement="../solution/schema.sql"
--statement insert valid row
INSERT INTO users(email) VALUES ('example@email.com'),('another@email.com');
SELECT * FROM users;
--expect users list
id,email
1,example@email.com
2,another@email.com
--statement insert incorrect row
INSERT INTO users(email) VALUES (1,2,3,4)
--expect syntax error
name,code
error,SQL-42601
```
Scenarios are composed of 2 types of instructions: `statement` and `expect`. Each instruction symbol must be prepended with `--`. Last executed `statement` 
result is stored and compared with following `expect`. `Statement` and `expected` content can be provided inline (in following lines, before next instruction
 symbol) as well as excluded into separate file (see example above). You can put some inline comment after `--statement` or `--expect` statement if 
 instruction doesn't point to external file. Those comments will be displayed with tests results.
 `Expect` must be a valid CSV data set, with column names in first line. You can expect data set response as well as SQL error. To test error you need to 
 specify 2x2 csv table as follow:
 
| name    | code           |
|---------|----------------|
| error   | SQL-errorCode  |

Code value must be [valid PostgreSQL error code](http://www.postgresql.org/docs/9.4/static/errcodes-appendix.html#ERRCODES-TABLE) prepended with string `SQL-`.
Please place your test scenario in `test/scenario.sql` (you can find example scenario file there).
 
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


