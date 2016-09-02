-- Write your solution here
ALTER TABLE users ADD COLUMN email TEXT UNIQUE;

UPDATE users u SET email = (SELECT 'test' || p.id || '@test.com' FROM users p WHERE u.id=p.id);

ALTER TABLE users ALTER COLUMN email SET NOT NULL;