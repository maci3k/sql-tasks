--statement="statements/schema.sql" seed schema
--statement="statements/insert_data.sql" insert data
--statement="../solution/view_breed.sql" view_breed.sql
--statement select basic breed information
SELECT * FROM view_breed;
--expect="expectations/expected_dogs.csv" breed listing with SI metrics

--statement="statements/insert_data2.sql"
--statement="../solution/view_breed.sql"
--statement select basic breed information
SELECT * FROM view_breed;
--expect="expectations/expected_dogs2.csv" breed listing with SI metrics
