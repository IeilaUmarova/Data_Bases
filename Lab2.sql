-- 1
CREATE DATABASE lab2;

-- 2
CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL,
    region_id INT NOT NULL,
    population INT
);

-- 3
INSERT INTO countries(country_id,country_name, region_id, population)
VALUES (1,'USA', 06, 39000000);

-- 4
INSERT INTO countries(country_id, country_name, region_id, population)
VALUES(2, 'Korea', DEFAULT, DEFAULT);

-- 5
INSERT INTO countries(country_name, region_id, population)
VALUES('China', NULL, 34000000);

-- 6
INSERT INTO countries(country_name, region_id, population)
VALUES
    ('Canada', 04, 38000000),
    ('Russia', 01, 45000000),
    ('Uzbekistan', 05, 40000000);

-- 7
ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

-- 8
INSERT INTO countries(country_name, region_id, population)
VALUES(DEFAULT, 04, 56000000);

-- 9
INSERT INTO countries(country_name, region_id, population)
VALUES(DEFAULT, DEFAULT, DEFAULT);

-- 10
CREATE TABLE countries_new LIKE countries;

-- 11
INSERT INTO countries_new
SELECT * FROM countries;

-- 12
UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

-- 13
SELECT country_name,
       population * 1,10 AS "New Population"
FROM countries;

-- 14
DELETE FROM countries
WHERE population < 100000
RETURNING *;

-- 15
DELETE FROM countries_new
WHERE country_id IN(SELECT country_id FROM countries)
RETURNING *;

-- 16
DELETE FROM countries
RETURNING *;