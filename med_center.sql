DROP DATABASE IF EXISTS medical_center_db;

CREATE DATABASE medical_center_db;

\c medical_center_db;


CREATE TABLE doctors (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  mobile_phone TEXT NOT NULL
--   dob DATE,
--   email_address TEXT,
--   mobile_phone_number TEXT
);

CREATE TABLE patients(
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    dob TEXT NOT NULL
);

CREATE TABLE hospital_visit(
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients ON DELETE CASCADE,
    check_in_date TEXT NOT NULL,
    check_in_time TEXT NOT NULL
);

CREATE TABLE diagnosis (
    id SERIAL PRIMARY KEY,
    diagnosis TEXT NOT NULL
);

CREATE TABLE visit_diagnosis (
    visit_id INTEGER REFERENCES hospital_visit ON DELETE CASCADE,
    diagnosis_id INTEGER REFERENCES diagnosis ON DELETE CASCADE
);

CREATE TABLE doctor_patient_interactions (
    visit_id INTEGER REFERENCES hospital_visit ON DELETE CASCADE,
    patient_id INTEGER REFERENCES patients ON DELETE CASCADE,
    doctor_id INTEGER REFERENCES doctors ON DELETE CASCADE
);

INSERT INTO doctors (first_name, last_name, mobile_phone)
VALUES ('Meredith', 'Grey', '555-123-4567'), ('Derek', 'Shepherd', '716-999-1234'), ('Addison', 'Shepherd', '513-123-0009');

INSERT INTO patients (first_name, last_name, dob)
VALUES ('Steven', 'Miller', '1990-04-20'), ('Alex', 'Jones', '1973-01-29'), ('Peter', 'Williams', '2000-11-07');

INSERT INTO hospital_visit (patient_id, check_in_date, check_in_time) VALUES (1, '2023-12-12', '12:01 PM'), (2, '2023-12-13', '01:32 AM'), (3, '2023-12-18', '09:13 PM');

INSERT INTO diagnosis (diagnosis) VALUES ('Broken Arm'), ('Contusion'), ('Migraine'), ('Strep Throat'), ('Flu'), ('Covid-19');

INSERT INTO visit_diagnosis (visit_id, diagnosis_id) VALUES (1,2), (1,1), (2,2);

INSERT INTO doctor_patient_interactions (visit_id, patient_id, doctor_id) VALUES (1,1,1), (1,1,2), (2,3,2);




-- SELECT check_in_date, check_in_time, first_name, last_name, diagnosis from visit_diagnosis JOIN hospital_visit ON visit_id = hospital_visit.id JOIN patients on patient_id = patients.id JOIN diagnosis ON diagnosis_id = diagnosis.id;


-- SELECT * FROM doctor_patient_interactions JOIN hospital_visit ON visit_id = hospital_visit.id JOIN patients ON doctor_patient_interactions.patient_id = patients.id JOIN doctors ON doctor_id = doctors.id;
