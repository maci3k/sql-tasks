--clear breed table
DELETE FROM breed;

INSERT INTO breed("name", "family", "origin", "original_function", "male_height_min","male_height_max", "male_weight_min", "male_weight_max", "female_height_min","female_height_max", "female_weight_min","female_weight_max", "other_names") VALUES
('Chihuahua', 'companion, southern (pariah)', 'Mexico', 'ceremonial', 6,9, 6,6, 6,9, 6,6, NULL),
('Boxer', 'livestock dog, mastiff (bulldog)', 'Germany', 'bullbaiting, guardian', 22.5,25,  65,80, 21,23.5, 50,65, NULL),
('Poodle (Miniature)', 'gun dog, companion, water dog', 'Germany', 'water retrieving, performer', 10,15,  12,18, 10,15, 12,18, 'Barbone, Caniche'),
('Bull Terrier', 'terrier, mastiff (bull)', 'England', 'dog fighting', 21,22,  55,65, 21,22, 45,55, 'English bull terrier'),
('Golden Retriever', 'gundog, retriever', 'England', 'retrieving', 23,24,  65,75, 21.5,22.5, 55,65, 'yellow retriever'),
('Yorkshire Terrier', 'terrier', 'England', 'small vermin-hunting', 8,9, 7,7, 8,9, 7,7, NULL);
