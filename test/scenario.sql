--statement="drop_schema.sql"
--statement="../solution/schema.sql"
--statement="../solution/insert.sql"

--statement
SELECT * FROM car;

--expect car list
 id,brand,year_of_manufacture,color,weight,secondhand
 1,Bentley,1988,red metallic,1002.72,false
 2,Suzuki,2002,silver,1787.25,true

--statement="data.sql"
--statement="../solution/select_the_heaviest_car.sql"

--expect the heaviest car
 brand,weight
 Suzuki,1787.25

--statement="insert.sql"
--statement="../solution/select_the_heaviest_car.sql"
--expect the heaviest car
 brand,weight
 Bentley,1800.97

--statement="../solution/select_unused_cars.sql"
--expect the list of cars
 brand,year_of_manufacture,color
 Tata,1981,red
 Bentley,1988,red metallic
 Toyota,2000,red

 --statement="../solution/update.sql"
--statement
 SELECT * FROM car ORDER BY year_of_manufacture ASC;
--expect the list of cars
 id,brand,year_of_manufacture,color,weight,secondhand
 7,Tata,1981,red,1492.9,true
 3,SsangYong,1983,yellow,1631.86,true
 6,Bentley,1984,black,1632.97,false
 9,BMW,1986,black metallic,1433.13,false
 1,Bentley,1988,red metallic,1002.72,false
 5,Mercedes,1991,silver,1113.59,true
 4,Toyota,2000,red,1407.99,false
 10,Toyota,2002,blue,1477.07,true
 2,Suzuki,2002,silver,1787.25,true
 11,Bentley,2003,blue metallic,1800.97,false
 8,Renault,2009,yellow,1331.13,false

--statement="../solution/delete.sql"
--statement
 SELECT * FROM car;
--expect the list of cars
 id,brand,year_of_manufacture,color,weight,secondhand
 1,Bentley,1988,red metallic,1002.72,false
 2,Suzuki,2002,silver,1787.25,true
 4,Toyota,2000,red,1407.99,false
 5,Mercedes,1991,silver,1113.59,true
 6,Bentley,1984,black,1632.97,false
 8,Renault,2009,yellow,1331.13,false
 9,BMW,1986,black metallic,1433.13,false
 10,Toyota,2002,blue,1477.07,true
 11,Bentley,2003,blue metallic,1800.97,false


 --statement="insert2.sql"
 --statement="../solution/select_unused_cars.sql"
--expect the list of cars
 brand,year_of_manufacture,color
 Bentley,1988,red metallic
 Bentley,1999,red matte metallic
 Toyota,2000,red
