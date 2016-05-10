--clear breed table and view_breed
DELETE FROM breed;
DROP VIEW view_breed;

INSERT INTO breed("name", "family", "origin", "original_function", "male_height_min","male_height_max", "male_weight_min", "male_weight_max", "female_height_min","female_height_max", "female_weight_min","female_weight_max", "other_names") VALUES
('Akita', 'spitz, northern (hunting)', 'Japan', 'large game hunting, dog fighting', 25,28,  85,130, 23,26, 65,110, 'Akita Inu, Japanese Akita'),
('American Cocker Spaniel', 'gundog, spaniel', 'United States', 'bird flushing and retrieving', 14.5,15.5,  24,28, 13.5,14.5, 24,28, 'Cocker Spaniel'),
('Shetland Sheepdog', 'livestock, herding', 'Scotland', 'sheep herding', 13,16, 20,20, 13,16, 20,20, NULL),
('Poodle (Miniature)', 'gun dog, companion, water dog', 'Germany', 'water retrieving, performer', 10,15,  12,18, 10,15, 12,18, 'Barbone, Caniche'),
('German Shepherd Dog', 'livestock, herding', 'Germany', 'sheep herding, guarding, police dog', 24,26,  75,95, 22,24, 75,95, 'Alsatian, Deutscher schaferhund');
