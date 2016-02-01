--statement="./schema.sql"
--statement="./data.sql"

--statement="../solution/search1.sql"
--expect rows containing 'friendly' and 'family' in field temperament
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
19,Poodle (Miniature)

--statement="../solution/search3.sql"
--expect rows that contains 'herding' or 'sheepdog' or 'livestock' but not contain 'mastiff'; in `family` or `original_function`
id,name
8,Collie
9,Border Collie
18,Shetland Sheepdog
20,German Shepherd Dog
