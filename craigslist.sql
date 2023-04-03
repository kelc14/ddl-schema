DROP DATABASE IF EXISTS craigslist_db;

CREATE DATABASE craigslist_db;

\c craigslist_db;

CREATE TABLE states (
    id SERIAL PRIMARY KEY,
    state_name TEXT NOT NULL,
    state_abbrev VARCHAR(2) NOT NULL
);

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    us_cities TEXT NOT NULL,
    state_id INTEGER REFERENCES states ON DELETE CASCADE
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    preferred_location INTEGER REFERENCES regions ON DELETE SET NULL
);

CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    category TEXT NOT NULL
);

CREATE TABLE subcategory (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES category ON DELETE CASCADE,
    subcategory TEXT NOT NULL
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    post_date TEXT NOT NULL,
    post_text TEXT NOT NULL,
    user_id INTEGER REFERENCES users ON DELETE CASCADE,
    subcategory_id INTEGER REFERENCES subcategory ON DELETE CASCADE
);

INSERT INTO states (state_name, state_abbrev)  VALUES  ('Alabama', 'AL'),
       ('Alaska', 'AK'),
       ('Arizona', 'AZ'),
       ('Arkansas', 'AR'),
       ('California', 'CA'),
       ('Colorado', 'CO'),
       ('Connecticut', 'CT'),
       ('Delaware', 'DE'),
       ('District of Columbia', 'DC'),
       ('Florida', 'FL'),
       ('Georgia', 'GA'),
       ('Hawaii', 'HI'),
       ('Idaho', 'ID'),
       ('Illinois', 'IL'),
       ('Indiana', 'IN'),
       ('Iowa', 'IA'),
       ('Kansas', 'KS'),
       ('Kentucky', 'KY'),
       ('Louisiana', 'LA'),
       ('Maine', 'ME'),
       ('Maryland', 'MD'),
       ('Massachusetts', 'MA'),
       ('Michigan', 'MI'),
       ('Minnesota', 'MN'),
       ('Mississippi', 'MS'),
       ('Missouri', 'MO'),
       ('Montana', 'MT'),
       ('Nebraska', 'NE'),
       ('Nevada', 'NV'),
       ('New Hampshire', 'NH'),
       ('New Jersey', 'NJ'),
       ('New Mexico', 'NM'),
       ('New York', 'NY'),
       ('North Carolina', 'NC'),
       ('North Dakota', 'ND'),
       ('Ohio', 'OH'),
       ('Oklahoma', 'OK'),
       ('Oregon', 'OR'),
       ('Pennsylvania', 'PA'),
       ('Rhode Island', 'RI'),
       ('South Carolina', 'SC'),
       ('South Dakota', 'SD'),
       ('Tennessee', 'TN'),
       ('Texas', 'TX'),
       ('Utah', 'UT'),
       ('Vermont', 'VT'),
       ('Virginia', 'VA'),
       ('Washington', 'WA'),
       ('West Virginia', 'WV'),
       ('Wisconsin', 'WI'),
       ('Wyoming', 'WY');


INSERT INTO regions (us_cities, state_id) VALUES ('Atlanta', 11), ('Austin', 44), ('Boston', 22), ('Chicago', 14);

INSERT INTO users (first_name, last_name, preferred_location) VALUES ('John', 'Miller', 2), ('Abby', 'Smith', 1), ('Nicole', 'Scott', 4), ('Matthew', 'Cole', 4);

INSERT INTO category (category) VALUES ('For Sale'), ('Housing'), ('Jobs'), ('Gigs'), ('Services');

INSERT INTO subcategory (category_id, subcategory) VALUES (1, 'antiques'), (1, 'appliances'), (1, 'art+crafts'), (1, 'atv/utv/sno');

INSERT INTO posts (title, post_text, post_date, user_id, subcategory_id) VALUES ('Lamp for Sale', 'Antique lamp for sale. Price $125', '2023-12-12', 1, 1), ('Samsung Fridge - Bespoke White', 'Barely used Samsung Fridge for Sale. Bespoke fridge with white glass panels.', '2023-12-12', 3, 2);



-- SELECT users.id AS user_id, first_name, last_name, us_cities, state_name, state_abbrev FROM users JOIN regions ON preferred_location = regions.id JOIN states ON state_id = states.id;


-- SELECT category, subcategory from subcategory JOIN category ON category_id = category.id;



-- POST WITH ALL INFO: 

-- SELECT title, post_text, subcategory, category, post_date, first_name, last_name, us_cities, state_abbrev FROM posts 
-- JOIN users on user_id = users.id 
-- JOIN subcategory ON subcategory_id = subcategory.id
-- JOIN category ON category_id = category.id
-- JOIN regions on preferred_location = regions.id 
-- JOIN states on state_id = states.id;