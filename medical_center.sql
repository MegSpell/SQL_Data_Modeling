-- from the terminal run:
-- psql < medical_center.sql

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    specialty TEXT NOT NULL,
    accepting_new_patients BOOLEAN NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT,
    insurance TEXT NOT NULL,
    birthday DATE NOT NULL,
    height_inches INT NOT NULL,
    weight_pounds INT NOT NULL
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    doctor_id INT REFERENCES doctors,
    patient_id INT REFERENCES patients,
    date DATE NOT NULL,
    notes TEXT
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name TEXT,
    description TEXT
);

CREATE TABLE diagnoses (
    id SERIAL PRIMARY KEY,
    visit_id INT REFERENCES visits,
    disease_id INT REFERENCES diseases,
    notes TEXT
);

INSERT INTO doctors (first_name, last_name, specialty, accepting_new_patients)
VALUES 
('Howard', 'Walowitz', 'Allergy Specialist', true),
('Leonard', 'Hofstadter', 'Primary Care', true),
('Raj', 'Koothrappali', 'OBGYN', false),
('Sheldon', 'Cooper', 'Cardiology', true);

INSERT INTO patients (first_name, last_name, insurance, birthday, height_inches, weight_pounds)
VALUES
('Penny', NULL, 'BlueCross BlueShield', '1985-11-30', 66, 120),
('Amy', 'Farrah Fowler', 'Tufts', '1975-12-12', 66, 155),
('Bernadette', 'Rostenkowski-Wolowitz', 'Harvard Pilgrim', '1980-06-23', 60, 110);

INSERT INTO visits (doctor_id, patient_id, date, notes)
VALUES
(1, 3, '2024-12-23', 'consult'),
(2, 1, '2024-02-14', 'pregnancy check'),
(4, 2, '2024-12-31', 'heart palpitations');

INSERT INTO diseases (name, description)
VALUES
('pregnant', 'with child'),
('peanut allergy', 'anaphylaxis with peanut exposure'),
('heart palpitations', 'fluttering heart beats');

INSERT INTO diagnoses (visit_id, disease_id, notes)
VALUES
(2, 1, '12 weeks along'),
(1, 2, 'anaphylaxis with peanut exposure'),
(3, 3, 'love struck!');



---------------------------------------------------------------------------------

-- medical_center=# SELECT * FROM doctors                                                                                    ;
--  id | first_name |  last_name   |     specialty      | accepting_new_patients 
-- ----+------------+--------------+--------------------+------------------------
--   1 | Howard     | Walowitz     | Allergy Specialist | t
--   2 | Leonard    | Hofstadter   | Primary Care       | t
--   3 | Raj        | Koothrappali | OBGYN              | f
--   4 | Sheldon    | Cooper       | Cardiology         | t
-- (4 rows)

-- medical_center=# SELECT * FROM patients;                                                                                  ;
--  id | first_name |       last_name       |      insurance       |  birthday  | height_inches | weight_pounds 
-- ----+------------+-----------------------+----------------------+------------+---------------+---------------
--   1 | Penny      |                       | BlueCross BlueShield | 1985-11-30 |            66 |           120
--   2 | Amy        | Farrah Fowler         | Tufts                | 1975-12-12 |            66 |           155
--   3 | Bernadette | Rostenkowski-Wolowitz | Harvard Pilgrim      | 1980-06-23 |            60 |           110
-- (3 rows)

-- medical_center=# SELECT * FROM visits;                                                                                    ;
--  id | doctor_id | patient_id |    date    |       notes        
-- ----+-----------+------------+------------+--------------------
--   1 |         1 |          3 | 2024-12-23 | consult
--   2 |         2 |          1 | 2024-02-14 | pregnancy check
--   3 |         4 |          2 | 2024-12-31 | heart palpitations
-- (3 rows)

-- medical_center=# SELECT * FROM diseases;                                                                                  ;
--  id |        name        |           description            
-- ----+--------------------+----------------------------------
--   1 | pregnant           | with child
--   2 | peanut allergy     | anaphylaxis with peanut exposure
--   3 | heart palpitations | fluttering heart beats
-- (3 rows)

-- medical_center=# SELECT * FROM diagnoses;                                                                                 ;
--  id | visit_id | disease_id |              notes               
-- ----+----------+------------+----------------------------------
--   1 |        2 |          1 | 12 weeks along
--   2 |        1 |          2 | anaphylaxis with peanut exposure
--   3 |        3 |          3 | love struck!
-- (3 rows)

-- medical_center=# 