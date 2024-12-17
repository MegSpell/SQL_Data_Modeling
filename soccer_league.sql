-- from the terminal run:
-- psql < soccer_league.sql

DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT UNIQUE NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    player_name TEXT NOT NULL,
    team_id INT REFERENCES teams
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    ref_name TEXT NOT NULL
);

CREATE TABLE season (
    id SERIAL PRIMARY KEY,
    begin_date DATE,
    end_date DATE
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    home_team_id INT NOT NULL REFERENCES teams,
    away_team_id INT NOT NULL REFERENCES teams,
    stadium TEXT NOT NULL,
    date_and_time TIMESTAMP NOT NULL,
    head_referee_id INT NOT NULL REFERENCES referees,
    assistant_ref_id INT NOT NULL REFERENCES referees,
    assistant_ref_2_id INT REFERENCES referees,
    season_id INT NOT NULL REFERENCES season
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    player_id INT NOT NULL REFERENCES players,
    match_id INT NOT NULL REFERENCES matches
);



INSERT INTO teams (team_name, city)
VALUES
('AFC', 'Richmond'),
('United F.C', 'West Ham');

INSERT INTO players (player_name, team_id)
VALUES
('Roy Kent', 1),
('Dani Rojas' ,1),
('Sam Obisanya', 1),
('Jamie Tart', 2),
('Zava', 2);

INSERT INTO referees (ref_name)
VALUES
('Keely Jones'),
('Rebecca Welton'),
('Nathan Shelley'),
('Trent Crimm'),
('Leslie Higgins');

INSERT INTO season (begin_date, end_date)
VALUES
('2020-08-01', '2021-05-05'),
('2021-08-01', '2022-05-05');

INSERT INTO matches (home_team_id, away_team_id, stadium, date_and_time, head_referee_id, assistant_ref_id, assistant_ref_2_id, season_id)
VALUES
(1, 2, 'Nelson Road', '2020-08-03 14:30:00', 1, 2, NULL, 1),
(2, 1, 'London Stadium', '2020-09-26 14:30:00', 4, 3, 5, 2);

INSERT INTO goals (player_id, match_id)
VALUES
(1, 1),
(1, 1),
(2, 1),
(2, 1),
(3, 2),
(1, 2),
(1, 2),
(4, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2);




-- QUERIES FOR STANDINGS: with ALOT of help from ChatGPT.....

-- Add the winner_team_id column
ALTER TABLE matches ADD COLUMN winner_team_id INT REFERENCES teams;

-- Update the winner_team_id column based on goals scored
UPDATE matches
SET winner_team_id = CASE
    WHEN (SELECT COUNT(*) FROM goals g1 JOIN players p1 ON g1.player_id = p1.id
          WHERE g1.match_id = matches.id AND p1.team_id = matches.home_team_id) >
         (SELECT COUNT(*) FROM goals g2 JOIN players p2 ON g2.player_id = p2.id
          WHERE g2.match_id = matches.id AND p2.team_id = matches.away_team_id)
    THEN home_team_id
    WHEN (SELECT COUNT(*) FROM goals g1 JOIN players p1 ON g1.player_id = p1.id
          WHERE g1.match_id = matches.id AND p1.team_id = matches.away_team_id) >
         (SELECT COUNT(*) FROM goals g2 JOIN players p2 ON g2.player_id = p2.id
          WHERE g2.match_id = matches.id AND p2.team_id = matches.home_team_id)
    THEN away_team_id
    ELSE NULL
END;



SELECT
    teams.id AS team_id, -- Select the team's unique ID
    teams.team_name, -- Select the team's name
    SUM(CASE WHEN matches.winner_team_id = teams.id THEN 1 ELSE 0 END) AS wins, -- Count matches where the team was the winner
    SUM(CASE WHEN matches.home_team_id != matches.winner_team_id 
             AND matches.away_team_id != matches.winner_team_id THEN 1 ELSE 0 END) AS draws, -- Count matches that ended in a draw
    SUM(CASE WHEN matches.winner_team_id IS NOT NULL 
             AND matches.winner_team_id != teams.id THEN 1 ELSE 0 END) AS losses, -- Count matches where the team was not the winner
    COALESCE(SUM(goals_count.goals), 0) AS goals_scored -- Sum up the goals scored by the team, default to 0 if no goals
FROM
    teams -- Start with the list of teams
LEFT JOIN matches
    ON teams.id = matches.home_team_id OR teams.id = matches.away_team_id -- Join matches to include all matches involving each team
LEFT JOIN (
    SELECT
        players.team_id, -- Group goals by the team of the player who scored
        goals.match_id, -- Include the match ID to ensure goals are linked correctly
        COUNT(*) AS goals -- Count the number of goals
    FROM goals
    JOIN players ON goals.player_id = players.id -- Connect each goal to the player who scored it
    GROUP BY players.team_id, goals.match_id -- Group by team and match for accurate totals
) AS goals_count
    ON goals_count.team_id = teams.id
    AND (matches.id = goals_count.match_id) -- Ensure goals are matched to the correct match
GROUP BY teams.id, teams.team_name -- Group the final results by each team
ORDER BY wins DESC, goals_scored DESC; -- Sort teams by wins (highest first), then by goals scored



-------------------------------------------------------------------
-- Meg@MacBook-Pro SQL_Data_Modeling % psql < soccer_league.sql
-- DROP DATABASE
-- CREATE DATABASE
-- You are now connected to database "soccer_league" as user "Meg".
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- CREATE TABLE
-- INSERT 0 2
-- INSERT 0 5
-- INSERT 0 5
-- INSERT 0 2
-- INSERT 0 2
-- INSERT 0 12
-- ALTER TABLE
-- UPDATE 2
--  team_id | team_name  | wins | draws | losses | goals_scored 
-- ---------+------------+------+-------+--------+--------------
--        1 | AFC        |    1 |     0 |      1 |            7
--        2 | United F.C |    1 |     0 |      1 |            5
-- (2 rows)
-- Meg@MacBook-Pro SQL_Data_Modeling % psql soccer_league
-- psql (17.0 (Postgres.app))
-- Type "help" for help.

-- soccer_league=# SELECT * FROM teams;
--  id | team_name  |   city   
-- ----+------------+----------
--   1 | AFC        | Richmond
--   2 | United F.C | West Ham
-- (2 rows)

-- soccer_league=# SELECT * FROM players;
--  id | player_name  | team_id 
-- ----+--------------+---------
--   1 | Roy Kent     |       1
--   2 | Dani Rojas   |       1
--   3 | Sam Obisanya |       1
--   4 | Jamie Tart   |       2
--   5 | Zava         |       2
-- (5 rows)

-- soccer_league=# SELECT * FROM referees;
--  id |    ref_name    
-- ----+----------------
--   1 | Keely Jones
--   2 | Rebecca Welton
--   3 | Nathan Shelley
--   4 | Trent Crimm
--   5 | Leslie Higgins
-- (5 rows)

-- soccer_league=# SELECT * FROM matches;
--  id | home_team_id | away_team_id |    stadium     |    date_and_time    | head_referee_id | assistant_ref_id | assistant_ref_2_id | season_id 
-- ----+--------------+--------------+----------------+---------------------+-----------------+------------------+--------------------+-----------
--   1 |            1 |            2 | Nelson Road    | 2020-08-03 14:30:00 |               1 |                2 |                    |         1
--   2 |            2 |            1 | London Stadium | 2020-09-26 14:30:00 |               4 |                3 |                  5 |         2
-- (2 rows)

-- soccer_league=# SELECT * FROM season;
--  id | begin_date |  end_date  
-- ----+------------+------------
--   1 | 2020-08-01 | 2021-05-05
--   2 | 2021-08-01 | 2022-05-05
-- (2 rows)

-- soccer_league=# SELECT * FROM goals;
--  id | player_id | match_id 
-- ----+-----------+----------
--   1 |         1 |        1
--   2 |         1 |        1
--   3 |         2 |        1
--   4 |         2 |        1
--   5 |         3 |        2
--   6 |         1 |        2
--   7 |         1 |        2
--   8 |         4 |        2
--   9 |         5 |        2
--  10 |         5 |        2
--  11 |         5 |        2
--  12 |         5 |        2
-- (12 rows)

-- soccer_league=# SELECT * FROM matches;
--  id | home_team_id | away_team_id |    stadium     |    date_and_time    | head_referee_id | assistant_ref_id | assistant_ref_2_id | season_id | winner_team_id 
-- ----+--------------+--------------+----------------+---------------------+-----------------+------------------+--------------------+-----------+----------------
--   1 |            1 |            2 | Nelson Road    | 2020-08-03 14:30:00 |               1 |                2 |                    |         1 |              1
--   2 |            2 |            1 | London Stadium | 2020-09-26 14:30:00 |               4 |                3 |                  5 |         2 |              2
-- (2 rows)