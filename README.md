# SQL - NOT NULL column on the existing database 

## Summary
Sometimes it happens that you need to change the schema of the table. In this tasks, `users` table (already containing some data), needs an additional column.

## Goals

Add to the `users` table ***not null*** and and at the same time ***unique*** **email** column. 

The initial `users` table structure:

| user       | 
|------------|
| id (PK)    |
| nickname   |
| first_name |
| last_name  |
| birth_date |


Complete missing emails field according to the pattern:
**testID`@`test.com** for example: **test1`@`test.com**

Table below shows results of valid solution.

|  id   | nickname    | first_name | last_name  | birth_date | email            |
|-------|-------------|------------|------------|------------|------------------|
|  1    | cfisher0    | Chris      | Fisher     | 1985-09-30 | test1@test.com   |
|  2    | kmatthews1  | Kimberly   | Matthews   | 1990-06-25 | test2@test.com   |
|  3    | tpeters2    | Todd       | Peters     | 1988-09-08 | test3@test.com   |
|  4    | blee3       | Betty      | Lee        | 1997-10-07 | test4@test.com   |
|  5    | smoreno4    | Sharon     | Moreno     | 1989-06-15 | test5@test.com   |
|  6    | imiller5    | Irene      | Miller     | 1986-03-26 | test6@test.com   |
|  7    | jlopez6     | John       | Lopez      | 1993-08-24 | test7@test.com   |
|  8    | acole7      | Anthony    | Cole       | 1997-09-07 | test8@test.com   |
|  9    | rcruz8      | Rachel     | Cruz       | 1971-04-10 | test9@test.com   |
|  10   | dparker9    | Denise     | Parker     | 1967-02-24 | test10@test.com  |
|  11   | ltaylor9    | Linda      | Taylor     | 1964-01-14 | ltaylor9@est.com |

Write your solution in `solution/query.sql` file.

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
createuser realskill -P && createdb realskill -O realskill && psql -d realskill -c 'ALTER SCHEMA public OWNER TO realskill|'
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
