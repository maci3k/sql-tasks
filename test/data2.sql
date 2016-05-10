--clear breed table
DELETE FROM breed;

INSERT INTO breed("name", "family", "origin", "original_function", "male_height_min","male_height_max", "male_weight_min", "male_weight_max", "female_height_min","female_height_max", "female_weight_min","female_weight_max", "other_names") VALUES
('Rottweiler', 'livestock dog, sheepdog, mastiff (draft/cattle)', 'Germany', 'cattle drover, guardian, draft', 24,27,  85,135, 22,25, 80,100, NULL),
('Yorkshire Terrier', 'terrier', 'England', 'small vermin-hunting', 8,9, 7,7, 8,9, 7,7, NULL),
('Shetland Sheepdog', 'livestock, herding', 'Scotland', 'sheep herding', 13,16, 20,20, 13,16, 20,20, NULL),
('Poodle (Miniature)', 'gun dog, companion, water dog', 'Germany', 'water retrieving, performer', 10,15,  12,18, 10,15, 12,18, 'Barbone, Caniche'),
('German Shepherd Dog', 'livestock, herding', 'Germany', 'sheep herding, guarding, police dog', 24,26,  75,95, 22,24, 75,95, 'Alsatian, Deutscher schaferhund');
