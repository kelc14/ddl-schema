DROP DATABASE IF EXISTS soccer_db;

CREATE DATABASE soccer_db;

\c soccer_db;

CREATE TABLE uefa_leagues (
    id SERIAL PRIMARY KEY,
    league TEXT NOT NULL
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT NOT NULL,
    -- city TEXT NOT NULL,
    stadium TEXT NOT NULL,
    league_id INTEGER REFERENCES uefa_leagues ON DELETE SET NULL
);

CREATE TABLE positions (
    id SERIAL PRIMARY KEY,
    position TEXT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    position_id INTEGER REFERENCES positions ON DELETE SET NULL,
    nationality TEXT NOT NULL,
    team_id INTEGER REFERENCES teams ON DELETE SET NULL
);

CREATE TABLE season (
    id SERIAL PRIMARY KEY,
    year TEXT NOT NULL,
    begin_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    league_id INTEGER REFERENCES uefa_leagues ON DELETE SET NULL
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    season_id INTEGER REFERENCES season ON DELETE SET NULL,
    mdate VARCHAR NOT NULL,
    home_team_id INTEGER REFERENCES teams ON DELETE SET NULL,
    away_team_id INTEGER REFERENCES teams ON DELETE SET NULL,
    home_score INTEGER NOT NULL,
    away_score INTEGER NOT NULL
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players ON DELETE SET NULL,
    game_id INTEGER REFERENCES games ON DELETE SET NULL,
    mtime INTEGER NOT NULL
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE referees_games (
    game_id INTEGER REFERENCES games,
    ref_id INTEGER REFERENCES referees
);

INSERT INTO uefa_leagues (league) VALUES ('FA Premier League'), ('League 1'), ('Bundesliga'), ('Serie A'), ('La Liga');

INSERT INTO teams (team_name, stadium, league_id) VALUES ('Bournemouth', 'Vitality Stadium',1), ('Arsenal', 'Emirates Stadium',1), ('Aston Villa', 'Villa Park',1 ), ('Brentford', 'Gtech Community Stadium',1), ('Brighton & Hove Albion', 'Amex Stadium',1), ('Chelsea', 'Stamford Bridge',1), ('Crystal Palace', 'Selhurst Park',1), ('Everton', 'Goodison Park',1), ('Fulham', 'Craven Cottage',1), ('Leeds United', 'Elland Road',1), ('Leicester City', 'King Power Stadium',1), ('Manchester United', 'Old Trafford', 1), ('Tottenham Hotspur', 'Tottenham Hotspur Stadium', 1), ('West Ham United', 'London Stadium', 1);

INSERT INTO positions (position) VALUES ('Goalkeeper'), ('Defender'), ('Midfielder'), ('Forward');

INSERT INTO players (first_name, last_name, position_id, nationality, team_id) VALUES ('Mark', 'Travers', 1, 'Ireland', 1), ('Lloyd ', 'Kelly', 2, 'England', 1), ('Kai', 'Havertz', 3, 'Germany', 6), ('Aaron', 'Cresswell', 2, 'England', 14);

INSERT INTO season (year, begin_date, end_date, league_id) VALUES ('2000-01', '19 August 2000', '19 May 2001', 1), ('2001-02', '18 August 2001', '11 May 2002', 1);

INSERT INTO games (season_id, mdate, home_team_id, away_team_id, home_score, away_score) VALUES (2, '29-September-2001',13, 12, 3, 5), (2, '16-March-2002',14, 12, 3, 5);

INSERT INTO goals (player_id, game_id, mtime) VALUES (4, 1, 14);

INSERT INTO referees (first_name, last_name) VALUES ('John', 'Wick'), ('Maddox', 'Johnson');

INSERT INTO referees_games (game_id, ref_id) VALUES (1, 1), (2,2);




-- SELECT first_name, last_name, position, team_name FROM players JOIN positions ON position_id = positions.id JOIN teams ON team_id = teams.id;



-- view teams and leagues

-- SELECT * FROM teams JOIN uefa_leagues ON league_id = uefa_leagues.id;


-- SELECT * from goals JOIN players on player_id = players.id JOIN teams on team_id = teams.id;
