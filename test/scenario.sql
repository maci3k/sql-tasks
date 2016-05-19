--statement="statements/drop_schema.sql" Drop schema
--statement="../solution/schema.sql" Seed schema
--statement="../solution/insert.sql" insert.sql

--statement
SELECT * FROM car;
--expect car list
 id,brand,year_of_manufacture,color,weight,secondhand
 1,Bentley,1988,red metallic,1002.72,false
 2,Suzuki,2002,silver,1787.25,true

--statement="statements/insert_data.sql" seed data
--statement="../solution/select_the_heaviest_car.sql" select_the_heaviest_car.sql
--expect the heaviest car
 brand,weight
 Suzuki,1787.25

--statement="statements/insert_data2.sql" seed data
--statement="../solution/select_the_heaviest_car.sql" select_the_heaviest_car.sql
--expect the heaviest car
 brand,weight
 Bentley,1800.97

--statement="../solution/select_unused_cars.sql" select_unused_cars.sql
--expect the list of cars
 brand,year_of_manufacture,color
 Tata,1981,red
 Bentley,1988,red metallic
 Toyota,2000,red

--statement="../solution/update.sql" update.sql
--statement
 SELECT * FROM car ORDER BY year_of_manufacture ASC;
--expect="expectations/expected_cars.csv" the list of cars

--statement="../solution/delete.sql" delete.sql
--statement
 SELECT * FROM car;
--expect="expectations/expected_cars2.csv" the list of cars

 --statement="statements/insert_data3.sql" seed data
 --statement="../solution/select_unused_cars.sql" select_unused_cars.sql
--expect the list of cars
 brand,year_of_manufacture,color
 Bentley,1988,red metallic
 BMW,1999,red matte metallic
 Toyota,2000,red

--statement="../solution/select_the_heaviest_car.sql" select_the_heaviest_car.sql
--expect the heaviest car
 brand,weight
 BMW,2800.97

 --statement="../solution/update.sql" update.sql
--statement
 SELECT * FROM car ORDER BY year_of_manufacture ASC;
--expect="expectations/expected_cars3.csv" the list of cars

--statement="../solution/delete.sql" delete.sql
--statement
 SELECT * FROM car;
--expect="expectations/expected_cars4.csv" the list of cars
