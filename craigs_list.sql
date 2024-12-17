-- from the terminal run:
-- psql < craigs_list.sql

DROP DATABASE IF EXISTS craigs_list;

CREATE DATABASE craigs_list;

\c craigs_list

CREATE TABLE region (
    id SERIAL PRIMARY KEY,
    region_name TEXT NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(20) NOT NULL,
    user_password VARCHAR(15) NOT NULL,
    preferred_region INT 
);


CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name TEXT
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    date_posted DATE NOT NULL,
    description_text TEXT NOT NULL,
    user_id INT REFERENCES users,
    region_id INT REFERENCES region,
    category_id INT REFERENCES categories
);

INSERT INTO region (region_name)
VALUES 
('Hill Valley, California'),
('Twin Pine Mall, California'),
('Old Old West');

INSERT INTO users (user_name, user_password, preferred_region)
VALUES
('Marty McFly', 'flyflyaway123', 1),
('Doc Brown', 'fluxcapcitator', 3),
('Biff Tannen', 'makelikeatree', 2);

INSERT INTO categories (category_name)
VALUES
('sports equipment'),
('cleaning supplies'),
('chemical reactors');

INSERT INTO posts (title, date_posted, description_text, user_id, region_id, category_id)
VALUES
('ISO Plutonimum', '1955-01-01', 'Deserately need Plutonium, trapped in the past, only way home!', 2, 1, 3),
('FOR SALE: HOVERBOARD', '2015-01-01', 'Prefer the old school skateboard, in good working condition, great for escaping bullies', 1, 2, 1),
('ISO manure stain removal...', '1955-01-01', 'Had a little run in with a pile of manure, need your best stain removal products, asap', 3, 1, 2);




-----------------------------------------------------------------------------------

-- craigs_list=# SELECT * FROM region;
--  id |        region_name         
-- ----+----------------------------
--   1 | Hill Valley, California
--   2 | Twin Pine Mall, California
--   3 | Old Old West
-- (3 rows)

-- craigs_list=# SELECT * FROM users;
--  id |  user_name  | user_password  | preferred_region 
-- ----+-------------+----------------+------------------
--   1 | Marty McFly | flyflyaway123  |                1
--   2 | Doc Brown   | fluxcapcitator |                3
--   3 | Biff Tannen | makelikeatree  |                2
-- (3 rows)

-- craigs_list=# SELECT * FROM categories;
--  id |   category_name   
-- ----+-------------------
--   1 | sports equipment
--   2 | cleaning supplies
--   3 | chemical reactors
-- (3 rows)

-- craigs_list=# SELECT * FROM posts;
--  id |            title            | date_posted |                                    description_text                                     | user_id | region_id | category_id 
-- ----+-----------------------------+-------------+-----------------------------------------------------------------------------------------+---------+-----------+-------------
--   1 | ISO Plutonimum              | 1955-01-01  | Deserately need Plutonium, trapped in the past, only way home!                          |       2 |         1 |           3
--   2 | FOR SALE: HOVERBOARD        | 2015-01-01  | Prefer the old school skateboard, in good working condition, great for escaping bullies |       1 |         2 |           1
--   3 | ISO manure stain removal... | 1955-01-01  | Had a little run in with a pile of manure, need your best stain removal products, asap  |       3 |         1 |           2
-- (3 rows)