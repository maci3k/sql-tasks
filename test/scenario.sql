--statement="./statements/schema.sql"
--statement="./statements/insert_data.sql"

--statement="../solution/search1.sql"
--expect="expectations/expected_dogs.csv" rows containing 'friend' and 'family' in field temperament

--statement="../solution/search2.sql"
--expect="expectations/expected_dogs2.csv" rows that contains 'hunting' or 'gundog' or 'retrieve' in `family`, `original_function` or `temperament`

--statement="../solution/search3.sql"
--expect="expectations/expected_dogs3.csv" rows that contains 'herding' or 'sheepdog' or 'livestock' but not contain 'mastiff'; in `family` or `original_function`

--statement="./statements/insert_data2.sql"
--statement="../solution/search1.sql"
--expect="expectations/expected_dogs4.csv" rows containing 'friend' and 'family' in field temperament

--statement="../solution/search2.sql"
--expect="expectations/expected_dogs5.csv" rows that contains 'hunting' or 'gundog' or 'retrieve' in `family`, `original_function` or `temperament`

--statement="../solution/search3.sql"
--expect="expectations/expected_dogs6.csv" rows that contains 'herding' or 'sheepdog' or 'livestock' but not contain 'mastiff'; in `family` or `original_function`

--required expression="to_tsvector" statement="../solution/search1.sql"
--required expression="to_tsquery" statement="../solution/search1.sql"

--required expression="to_tsvector" statement="../solution/search2.sql"
--required expression="to_tsquery" statement="../solution/search2.sql"

--required expression="to_tsvector" statement="../solution/search3.sql"
--required expression="to_tsquery" statement="../solution/search3.sql"
