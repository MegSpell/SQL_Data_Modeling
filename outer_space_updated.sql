-- from the terminal run:
-- psql < outer_space_updated.sql

DROP DATABASE IF EXISTS outer_space_updated;

CREATE DATABASE outer_space_updated;

\c outer_space_updated

-- Galaxies table
CREATE TABLE galaxies (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

-- Stars table
CREATE TABLE stars (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    galaxy_id INT REFERENCES galaxies
);

-- Planets table
CREATE TABLE planets (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    orbital_period_in_years FLOAT NOT NULL,
    star_id INT REFERENCES stars
);

-- Moons table
CREATE TABLE moons (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    planet_id INT REFERENCES planets
);

-- Insert Data
-- Galaxies
INSERT INTO galaxies (name) VALUES
('Milky Way');

-- Stars
INSERT INTO stars (name, galaxy_id) VALUES
('The Sun', 1),
('Proxima Centauri', 1),
('Gliese 876', 1);

-- Planets
INSERT INTO planets (name, orbital_period_in_years, star_id) VALUES
('Earth', 1.00, 1),
('Mars', 1.88, 1),
('Venus', 0.62, 1),
('Neptune', 164.8, 1),
('Proxima Centauri b', 0.03, 2),
('Gliese 876 b', 0.23, 3);

-- Moons
INSERT INTO moons (name, planet_id) VALUES
('The Moon', 1),
('Phobos', 2),
('Deimos', 2),
('Naiad', 4),
('Thalassa', 4),
('Despina', 4),
('Galatea', 4),
('Larissa', 4),
('S/2004 N 1', 4),
('Proteus', 4),
('Triton', 4),
('Nereid', 4),
('Halimede', 4),
('Sao', 4),
('Laomedeia', 4),
('Psamathe', 4),
('Neso', 4);



----------------------------------------------------------------------------

-- Meg@MacBook-Pro SQL_Data_Modeling % psql < outer_space_updated.sql
-- NOTICE:  database "outer_space_updated" does not exist, skipping
-- DROP DATABASE
-- CREATE DATABASE
-- You are now connected to database "outer_space_updated" as user "Meg".
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- INSERT 0 1
-- INSERT 0 3
-- INSERT 0 6
-- INSERT 0 17
-- Meg@MacBook-Pro SQL_Data_Modeling % psql outer_space_updated      
-- psql (17.0 (Postgres.app))
-- Type "help" for help.

-- outer_space_updated=# SELECT * FROM galaxies;
--  id |   name    
-- ----+-----------
--   1 | Milky Way
-- (1 row)

-- outer_space_updated=# SELECT * FROM stars;
--  id |       name       | galaxy_id 
-- ----+------------------+-----------
--   1 | The Sun          |         1
--   2 | Proxima Centauri |         1
--   3 | Gliese 876       |         1
-- (3 rows)

-- outer_space_updated=# SELECT * FROM planets;
--  id |        name        | orbital_period_in_years | star_id 
-- ----+--------------------+-------------------------+---------
--   1 | Earth              |                       1 |       1
--   2 | Mars               |                    1.88 |       1
--   3 | Venus              |                    0.62 |       1
--   4 | Neptune            |                   164.8 |       1
--   5 | Proxima Centauri b |                    0.03 |       2
--   6 | Gliese 876 b       |                    0.23 |       3
-- (6 rows)

-- outer_space_updated=# SELECT * FROM moons;
--  id |    name    | planet_id 
-- ----+------------+-----------
--   1 | The Moon   |         1
--   2 | Phobos     |         2
--   3 | Deimos     |         2
--   4 | Naiad      |         4
--   5 | Thalassa   |         4
--   6 | Despina    |         4
--   7 | Galatea    |         4
--   8 | Larissa    |         4
--   9 | S/2004 N 1 |         4
--  10 | Proteus    |         4
--  11 | Triton     |         4
--  12 | Nereid     |         4
--  13 | Halimede   |         4
--  14 | Sao        |         4
--  15 | Laomedeia  |         4
--  16 | Psamathe   |         4
--  17 | Neso       |         4
-- (17 rows)
