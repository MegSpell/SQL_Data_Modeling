-- from the terminal run:
-- psql < air_traffic_updated.sql

DROP DATABASE IF EXISTS air_traffic_updated;
CREATE DATABASE air_traffic_updated;
\c air_traffic_updated

-- Table to store passengers
CREATE TABLE passengers (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

-- Table to store airlines
CREATE TABLE airlines (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Table to store cities and their associated countries
CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    city_name TEXT NOT NULL,
    country_name TEXT NOT NULL
);

-- Table to store flights
CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    airline_id INT REFERENCES airlines(id),
    departure_city_id INT REFERENCES cities(id),
    arrival_city_id INT REFERENCES cities(id),
    departure TIMESTAMP NOT NULL,
    arrival TIMESTAMP NOT NULL
);

-- Table to store tickets
CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    passenger_id INT REFERENCES passengers(id),
    flight_id INT REFERENCES flights(id),
    seat TEXT NOT NULL
);

-- Populate tables with data
INSERT INTO passengers (first_name, last_name)
VALUES
    ('Jennifer', 'Finch'),
    ('Thadeus', 'Gathercoal'),
    ('Sonja', 'Pauley'),
    ('Waneta', 'Skeleton'),
    ('Berkie', 'Wycliff'),
    ('Alvin', 'Leathes'),
    ('Cory', 'Squibbes');

INSERT INTO airlines (name)
VALUES
    ('United'),
    ('British Airways'),
    ('Delta'),
    ('TUI Fly Belgium'),
    ('Air China'),
    ('American Airlines'),
    ('Avianca Brasil');

INSERT INTO cities (city_name, country_name)
VALUES
    ('Washington DC', 'United States'),
    ('Seattle', 'United States'),
    ('Tokyo', 'Japan'),
    ('London', 'United Kingdom'),
    ('Los Angeles', 'United States'),
    ('Las Vegas', 'United States'),
    ('Mexico City', 'Mexico'),
    ('Paris', 'France'),
    ('Casablanca', 'Morocco'),
    ('Dubai', 'UAE'),
    ('Beijing', 'China'),
    ('New York', 'United States'),
    ('Charlotte', 'United States'),
    ('Cedar Rapids', 'United States'),
    ('Chicago', 'United States'),
    ('Sao Paolo', 'Brazil'),
    ('Santiago', 'Chile'),
    ('New Orleans', 'United States');

INSERT INTO flights (airline_id, departure_city_id, arrival_city_id, departure, arrival)
VALUES
    (1, 1, 2, '2018-04-08 09:00:00', '2018-04-08 12:00:00'), -- United: Washington DC -> Seattle
    (2, 3, 4, '2018-12-19 12:45:00', '2018-12-19 16:15:00'), -- British Airways: Tokyo -> London
    (3, 5, 6, '2018-01-02 07:00:00', '2018-01-02 08:03:00'), -- Delta: Los Angeles -> Las Vegas
    (3, 2, 7, '2018-04-15 16:50:00', '2018-04-15 21:00:00'), -- Delta: Seattle -> Mexico City
    (4, 8, 9, '2018-08-01 18:30:00', '2018-08-01 21:50:00'), -- TUI Fly Belgium: Paris -> Casablanca
    (5, 10, 11, '2018-10-31 01:15:00', '2018-10-31 12:55:00'), -- Air China: Dubai -> Beijing
    (1, 12, 13, '2019-02-06 06:00:00', '2019-02-06 07:47:00'), -- United: New York -> Charlotte
    (6, 14, 15, '2018-12-22 14:42:00', '2018-12-22 15:56:00'), -- American Airlines: Cedar Rapids -> Chicago
    (6, 13, 18, '2019-02-06 16:28:00', '2019-02-06 19:18:00'), -- American Airlines: Charlotte -> New Orleans
    (7, 16, 17, '2019-01-20 19:30:00', '2019-01-20 22:45:00'); -- Avianca Brasil: Sao Paolo -> Santiago

INSERT INTO tickets (passenger_id, flight_id, seat)
VALUES
    (1, 1, '33B'),
    (2, 2, '8A'),
    (3, 3, '12F'),
    (1, 4, '20A'),
    (4, 5, '23D'),
    (2, 6, '18C'),
    (5, 7, '9E'),
    (6, 8, '1A'),
    (5, 9, '32B'),
    (7, 10, '10D');




-------------------------------------------------------------------------------------------------

-- Meg@MacBook-Pro SQL_Data_Modeling % psql < air_traffic_updated.sql
-- DROP DATABASE
-- CREATE DATABASE
-- You are now connected to database "air_traffic_updated" as user "Meg".
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- INSERT 0 7
-- INSERT 0 7
-- INSERT 0 18
-- INSERT 0 10
-- INSERT 0 10
-- Meg@MacBook-Pro SQL_Data_Modeling % psql air_traffic_updated
-- psql (17.0 (Postgres.app))
-- Type "help" for help.

-- air_traffic_updated=# SELECT * FROM passengers;
--  id | first_name | last_name  
-- ----+------------+------------
--   1 | Jennifer   | Finch
--   2 | Thadeus    | Gathercoal
--   3 | Sonja      | Pauley
--   4 | Waneta     | Skeleton
--   5 | Berkie     | Wycliff
--   6 | Alvin      | Leathes
--   7 | Cory       | Squibbes
-- (7 rows)

-- air_traffic_updated=# SELECT * FROM airlines;
--  id |       name        
-- ----+-------------------
--   1 | United
--   2 | British Airways
--   3 | Delta
--   4 | TUI Fly Belgium
--   5 | Air China
--   6 | American Airlines
--   7 | Avianca Brasil
-- (7 rows)

-- air_traffic_updated=# SELECT * FROM cities;
--  id |   city_name   |  country_name  
-- ----+---------------+----------------
--   1 | Washington DC | United States
--   2 | Seattle       | United States
--   3 | Tokyo         | Japan
--   4 | London        | United Kingdom
--   5 | Los Angeles   | United States
--   6 | Las Vegas     | United States
--   7 | Mexico City   | Mexico
--   8 | Paris         | France
--   9 | Casablanca    | Morocco
--  10 | Dubai         | UAE
--  11 | Beijing       | China
--  12 | New York      | United States
--  13 | Charlotte     | United States
--  14 | Cedar Rapids  | United States
--  15 | Chicago       | United States
--  16 | Sao Paolo     | Brazil
--  17 | Santiago      | Chile
--  18 | New Orleans   | United States
-- (18 rows)

-- air_traffic_updated=# SELECT * FROM flights;
--  id | airline_id | departure_city_id | arrival_city_id |      departure      |       arrival       
-- ----+------------+-------------------+-----------------+---------------------+---------------------
--   1 |          1 |                 1 |               2 | 2018-04-08 09:00:00 | 2018-04-08 12:00:00
--   2 |          2 |                 3 |               4 | 2018-12-19 12:45:00 | 2018-12-19 16:15:00
--   3 |          3 |                 5 |               6 | 2018-01-02 07:00:00 | 2018-01-02 08:03:00
--   4 |          3 |                 2 |               7 | 2018-04-15 16:50:00 | 2018-04-15 21:00:00
--   5 |          4 |                 8 |               9 | 2018-08-01 18:30:00 | 2018-08-01 21:50:00
--   6 |          5 |                10 |              11 | 2018-10-31 01:15:00 | 2018-10-31 12:55:00
--   7 |          1 |                12 |              13 | 2019-02-06 06:00:00 | 2019-02-06 07:47:00
--   8 |          6 |                14 |              15 | 2018-12-22 14:42:00 | 2018-12-22 15:56:00
--   9 |          6 |                13 |              18 | 2019-02-06 16:28:00 | 2019-02-06 19:18:00
--  10 |          7 |                16 |              17 | 2019-01-20 19:30:00 | 2019-01-20 22:45:00
-- (10 rows)

-- air_traffic_updated=# SELECT * FROM tickets;
--  id | passenger_id | flight_id | seat 
-- ----+--------------+-----------+------
--   1 |            1 |         1 | 33B
--   2 |            2 |         2 | 8A
--   3 |            3 |         3 | 12F
--   4 |            1 |         4 | 20A
--   5 |            4 |         5 | 23D
--   6 |            2 |         6 | 18C
--   7 |            5 |         7 | 9E
--   8 |            6 |         8 | 1A
--   9 |            5 |         9 | 32B
--  10 |            7 |        10 | 10D
-- (10 rows)