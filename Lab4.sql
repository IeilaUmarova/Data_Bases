--1
CREATE DATABASE lab4;

--2
CREATE TABLE Warehouses(
code INTEGER PRIMARY KEY,
location VARCHAR(225) NOT NULL,
capacity INTEGER
);

INSERT INTO Warehouses (code, location, capacity) VALUES
(1, 'Chicago', 3),
(2, 'Chicago', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'Sun Francisco', 8);

CREATE TABLE Boxes(
    code CHARACTER(4) PRIMARY KEY,
    contents VARCHAR(225) NOT NULL,
    value REAL,
    warehouse INTEGER
);

INSERT INTO Boxes(code, contents, value, warehouse) VALUES
('0MN7', 'Rocks', 180, 3),
('4H8P', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);

--3


--4
SELECT * FROM Warehouses;

--5
SELECT * FROM Boxes
WHERE value > 150;

--6
SELECT DISTINCT contents FROM Boxes;

--7
SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse;

--8
SElECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse
HAVING COUNT(*) > 2;


--9
INSERT INTO Warehouses(code, location, capacity) VALUES
(6, 'New York', 3);

--10
INSERT INTO Boxes(code, contents, value, warehouse) VALUES
('H5RT', 'Papers', 200, 2);

--11
UPDATE Boxes
SET value = value * 0.85
WHERE value = (SELECT MIN(value) FROM (SELECT value FROM Boxes ORDER BY value DESC LIMIT 3) AS third_largest);

--12
DELETE FROM Boxes
WHERE value < 150;

--13
DELETE FROM Boxes
WHERE warehouse IN (SELECT code FROM Warehouses WHERE location = 'New York')
RETURNING *;