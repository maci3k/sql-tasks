--statement="./schema.sql"
--statement="./data.sql"

--statement="../solution/search1.sql"
--expect rows containing 'friend' and 'family' in field temperament
id,name
11,Golden Retriever
14,Newfoundland

--statement="../solution/search2.sql"
--expect rows that contains 'hunting' or 'gundog' or 'retrieve' in `family`, `original_function` or `temperament`
id,name
1,Akita
2,American Cocker Spaniel
11,Golden Retriever
12,Irish Setter
13,Labrador Retriever
17,Yorkshire Terrier

--statement="../solution/search3.sql"
--expect rows that contains 'herding' or 'sheepdog' or 'livestock' but not contain 'mastiff'; in `family` or `original_function`
id,name
8,Collie
9,Border Collie
18,Shetland Sheepdog
20,German Shepherd Dog

--statement="./data2.sql"
--statement="../solution/search1.sql"
--expect rows containing 'friend' and 'family' in field temperament
id,name
21,Akita
23,Beagle
29,Newfoundland

--statement="../solution/search2.sql"
--expect rows that contains 'hunting' or 'gundog' or 'retrieve' in `family`, `original_function` or `temperament`
id,name
21,Akita
22,American Cocker Spaniel

--statement="../solution/search3.sql"
--expect rows that contains 'herding' or 'sheepdog' or 'livestock' but not contain 'mastiff'; in `family` or `original_function`
id,name
28,Collie
29,Newfoundland

--required expression="to_tsvector" statement="../solution/search1.sql"
--required expression="to_tsquery" statement="../solution/search1.sql"

--required expression="to_tsvector" statement="../solution/search2.sql"
--required expression="to_tsquery" statement="../solution/search2.sql"

--required expression="to_tsvector" statement="../solution/search3.sql"
--required expression="to_tsquery" statement="../solution/search3.sql"
