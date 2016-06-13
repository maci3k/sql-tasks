# PostgreSQL - simple view

## Summary

Primitive one-table schema with 20 sample records is provided. 
The table contains too specific information about dog breeds size. 
The task is to provide SQL view that will horizontally aggregate sizes and also convert measure units.

## Goal

Provided `breed` table contains following breed size description columns:

```
male_height_min
male_height_max
male_weight_min
male_weight_max
female_height_min
female_height_max
female_weight_min
female_weight_max
```
We want to be able to roughly order breeds by height and weight. With structure above it's a bit difficult and may cause unnecessary query complexity. 
The way it has to be solved is to horizontally aggregate height and weight; regardless of minimum, maximum and whether it is male or female. 
In other words we want to calculate average value of height and average value of weight for each breed. Finally height and weight should be casted to an integer.

Second part of this task is to convert US measure units to metric SI standard. 
Table `breed` describes all height values in inches and weight in pounds, but desired units are centimeters and kilograms. 
For dimension use 2.54 multiplier to get centimeters and for weight 0.4536 multiplier to get kilograms.
Result data set should be ordered by weight and height, both descending.

Your aim is to combine all requirements above and provide SQL view named `view_breed`. 
The view should contain following columns: `id`, `name`, `origin`, `height`, `weight`.
Please save view creation script in file `solution/view_breed.sql`. 

Table below shows results set of `SELECT * FROM view_breed` of valid solution. 

|id|name|origin|height|weight|
|----|--------------|--------|----|----|
| 14 | Newfoundland | Canada | 69 | 57 |
| 16 | Rottweiler | Germany | 61 | 45 |
| 1 | Akita | Japan | 64 | 44 |
| 20 | German Shepherd Dog | Germany | 61 | 39 |
| 13 | Labrador Retriever | Canada | 58 | 30 |
| 12 | Irish Setter | Ireland | 66 | 29 |
| 11 | Golden Retriever | England | 58 | 29 |
| 4 | Boxer | Germany | 58 | 29 |
| 8 | Collie | Scotland | 61 | 28 |
| 7 | Chow Chow | China | 46 | 26 |
| 5 | Bull Terrier | England | 53 | 25 |
| 10 | Dalmatian | Yugoslavia | 53 | 23 |
| 9 | Border Collie | Great Britain | 51 | 17 |
| 2 | American Cocker Spaniel | United States | 38 | 12 |
| 3 | Beagle | England | 36 | 11 |
| 18 | Shetland Sheepdog | Scotland | 36 | 9 |
| 19 | Poodle (Miniature) | Germany | 30 | 7 |
| 15 | Papillon | France | 23 | 4 |
| 17 | Yorkshire Terrier | England | 20 | 3 |
| 6 | Chihuahua | Mexico | 18 | 3 |

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
    
