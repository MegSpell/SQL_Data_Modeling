-- from the terminal run:
-- psql < music_updated.sql


DROP DATABASE IF EXISTS music_updated;

CREATE DATABASE music_updated;

\c music_updated

-- Artists Table
CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

-- Albums Table
CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL UNIQUE,
  release_date DATE NOT NULL
);

-- Producers Table
CREATE TABLE producers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

-- Songs Table
CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  album_id INT REFERENCES albums(id) ON DELETE CASCADE
);

-- Song-Artist Relationship Table
CREATE TABLE song_artists (
  song_id INT REFERENCES songs(id) ON DELETE CASCADE,
  artist_id INT REFERENCES artists(id) ON DELETE CASCADE,
  PRIMARY KEY (song_id, artist_id)
);

-- Song-Producer Relationship Table
CREATE TABLE song_producers (
  song_id INT REFERENCES songs(id) ON DELETE CASCADE,
  producer_id INT REFERENCES producers(id) ON DELETE CASCADE,
  PRIMARY KEY (song_id, producer_id)
);


--Populating the Tables:

-- Insert Artists
INSERT INTO artists (name)
VALUES
  ('Hanson'),
  ('Queen'),
  ('Mariah Carey'),
  ('Boyz II Men'),
  ('Lady Gaga'),
  ('Bradley Cooper'),
  ('Nickelback'),
  ('Jay Z'),
  ('Alicia Keys'),
  ('Katy Perry'),
  ('Juicy J'),
  ('Maroon 5'),
  ('Christina Aguilera'),
  ('Avril Lavigne'),
  ('Destiny''s Child');

-- Insert Albums
INSERT INTO albums (title, release_date)
VALUES
  ('Middle of Nowhere', '1997-04-15'),
  ('A Night at the Opera', '1975-10-31'),
  ('Daydream', '1995-11-14'),
  ('A Star Is Born', '2018-09-27'),
  ('Silver Side Up', '2001-08-21'),
  ('The Blueprint 3', '2009-10-20'),
  ('Prism', '2013-12-17'),
  ('Hands All Over', '2011-06-21'),
  ('Let Go', '2002-05-14'),
  ('The Writing''s on the Wall', '1999-11-07');

-- Insert Producers
INSERT INTO producers (name)
VALUES
  ('Dust Brothers'),
  ('Stephen Lironi'),
  ('Roy Thomas Baker'),
  ('Walter Afanasieff'),
  ('Benjamin Rice'),
  ('Rick Parashar'),
  ('Al Shux'),
  ('Max Martin'),
  ('Cirkut'),
  ('Shellback'),
  ('Benny Blanco'),
  ('The Matrix'),
  ('Darkchild');

-- Insert Songs
INSERT INTO songs (title, duration_in_seconds, album_id)
VALUES
  ('MMMBop', 238, 1),
  ('Bohemian Rhapsody', 355, 2),
  ('One Sweet Day', 282, 3),
  ('Shallow', 216, 4),
  ('How You Remind Me', 223, 5),
  ('New York State of Mind', 276, 6),
  ('Dark Horse', 215, 7),
  ('Moves Like Jagger', 201, 8),
  ('Complicated', 244, 9),
  ('Say My Name', 240, 10);

-- Link Songs with Artists
INSERT INTO song_artists (song_id, artist_id)
VALUES
  (1, 1), -- MMMBop: Hanson
  (2, 2), -- Bohemian Rhapsody: Queen
  (3, 3), (3, 4), -- One Sweet Day: Mariah Carey, Boyz II Men
  (4, 5), (4, 6), -- Shallow: Lady Gaga, Bradley Cooper
  (5, 7), -- How You Remind Me: Nickelback
  (6, 8), (6, 9), -- New York State of Mind: Jay Z, Alicia Keys
  (7, 10), (7, 11), -- Dark Horse: Katy Perry, Juicy J
  (8, 12), (8, 13), -- Moves Like Jagger: Maroon 5, Christina Aguilera
  (9, 14), -- Complicated: Avril Lavigne
  (10, 15); -- Say My Name: Destiny's Child

-- Link Songs with Producers
INSERT INTO song_producers (song_id, producer_id)
VALUES
  (1, 1), (1, 2), -- MMMBop: Dust Brothers, Stephen Lironi
  (2, 3), -- Bohemian Rhapsody: Roy Thomas Baker
  (3, 4), -- One Sweet Day: Walter Afanasieff
  (4, 5), -- Shallow: Benjamin Rice
  (5, 6), -- How You Remind Me: Rick Parashar
  (6, 7), -- New York State of Mind: Al Shux
  (7, 8), (7, 9), -- Dark Horse: Max Martin, Cirkut
  (8, 10), (8, 11), -- Moves Like Jagger: Shellback, Benny Blanco
  (9, 12), -- Complicated: The Matrix
  (10, 13); -- Say My Name: Darkchild



----------------------------------------------------------------------------------------------------------


-- Meg@MacBook-Pro SQL_Data_Modeling % psql < music_updated.sql
-- NOTICE:  database "music_updated" does not exist, skipping
-- DROP DATABASE
-- CREATE DATABASE
-- You are now connected to database "music_updated" as user "Meg".
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- INSERT 0 15
-- INSERT 0 10
-- INSERT 0 13
-- INSERT 0 10
-- INSERT 0 15
-- INSERT 0 13
-- Meg@MacBook-Pro SQL_Data_Modeling % psql music_updated
-- psql (17.0 (Postgres.app))
-- Type "help" for help.

-- music_updated=# SELECT * FROM artists;
--  id |        name        
-- ----+--------------------
--   1 | Hanson
--   2 | Queen
--   3 | Mariah Carey
--   4 | Boyz II Men
--   5 | Lady Gaga
--   6 | Bradley Cooper
--   7 | Nickelback
--   8 | Jay Z
--   9 | Alicia Keys
--  10 | Katy Perry
--  11 | Juicy J
--  12 | Maroon 5
--  13 | Christina Aguilera
--  14 | Avril Lavigne
--  15 | Destiny's Child
-- (15 rows)

-- music_updated=# SELECT * FROM albums;
--  id |           title           | release_date 
-- ----+---------------------------+--------------
--   1 | Middle of Nowhere         | 1997-04-15
--   2 | A Night at the Opera      | 1975-10-31
--   3 | Daydream                  | 1995-11-14
--   4 | A Star Is Born            | 2018-09-27
--   5 | Silver Side Up            | 2001-08-21
--   6 | The Blueprint 3           | 2009-10-20
--   7 | Prism                     | 2013-12-17
--   8 | Hands All Over            | 2011-06-21
--   9 | Let Go                    | 2002-05-14
--  10 | The Writing's on the Wall | 1999-11-07
-- (10 rows)

-- music_updated=# SELECT * FROM producers;
--  id |       name        
-- ----+-------------------
--   1 | Dust Brothers
--   2 | Stephen Lironi
--   3 | Roy Thomas Baker
--   4 | Walter Afanasieff
--   5 | Benjamin Rice
--   6 | Rick Parashar
--   7 | Al Shux
--   8 | Max Martin
--   9 | Cirkut
--  10 | Shellback
--  11 | Benny Blanco
--  12 | The Matrix
--  13 | Darkchild
-- (13 rows)

-- music_updated=# SELECT * FROM songs;
--  id |         title          | duration_in_seconds | album_id 
-- ----+------------------------+---------------------+----------
--   1 | MMMBop                 |                 238 |        1
--   2 | Bohemian Rhapsody      |                 355 |        2
--   3 | One Sweet Day          |                 282 |        3
--   4 | Shallow                |                 216 |        4
--   5 | How You Remind Me      |                 223 |        5
--   6 | New York State of Mind |                 276 |        6
--   7 | Dark Horse             |                 215 |        7
--   8 | Moves Like Jagger      |                 201 |        8
--   9 | Complicated            |                 244 |        9
--  10 | Say My Name            |                 240 |       10
-- (10 rows)

-- music_updated=# SELECT * FROM song_artists;
--  song_id | artist_id 
-- ---------+-----------
--        1 |         1
--        2 |         2
--        3 |         3
--        3 |         4
--        4 |         5
--        4 |         6
--        5 |         7
--        6 |         8
--        6 |         9
--        7 |        10
--        7 |        11
--        8 |        12
--        8 |        13
--        9 |        14
--       10 |        15
-- (15 rows)

-- music_updated=# SELECT * FROM song_producers;
--  song_id | producer_id 
-- ---------+-------------
--        1 |           1
--        1 |           2
--        2 |           3
--        3 |           4
--        4 |           5
--        5 |           6
--        6 |           7
--        7 |           8
--        7 |           9
--        8 |          10
--        8 |          11
--        9 |          12
--       10 |          13
-- (13 rows)