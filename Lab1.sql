CREATE DATABASE lab1;

CREATE TABLE users(
    id SERIAL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL
);

ALTER TABLE users ADD COLUMN isadmin INTEGER DEFAULT 0;

ALTER TABLE users ALTER COLUMN isadmin TYPE BOOLEAN USING (isadmin::BOOLEAN);

ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT FALSE;

ALTER TABLE users ADD PRIMARY KEY (id);

CREATE TABLE tasks(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE tasks;

DROP DATABASE lab1;