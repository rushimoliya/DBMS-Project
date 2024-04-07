CREATE TABLE patient (
    pat_id INT PRIMARY KEY,
    pat_first_name VARCHAR(20) NOT NULL,
    pat_last_name VARCHAR(20) NOT NULL,
    pat_insurance_no VARCHAR(30) NOT NULL,
    pat_ph_no VARCHAR(20) NOT NULL,
    pat_date DATE DEFAULT CURRENT_DATE,
    pat_address VARCHAR(40) NOT NULL
);

CREATE TABLE doctor (
    doc_id INT PRIMARY KEY,
    doc_first_name VARCHAR(20) NOT NULL,
    doc_last_name VARCHAR(20) NOT NULL,
    doc_ph_no VARCHAR(20) NOT NULL,
    doc_date DATE DEFAULT CURRENT_DATE,
    doc_address VARCHAR(40) NOT NULL
);

CREATE TABLE nurse (
    nur_id INT PRIMARY KEY,
    nur_first_name VARCHAR(20) NOT NULL,
    nur_last_name VARCHAR(20) NOT NULL,
    nur_ph_no VARCHAR(20) NOT NULL,
    nur_date DATE DEFAULT CURRENT_DATE,
    nur_address VARCHAR(40) NOT NULL
);

CREATE TABLE appointment (
    app_id INT PRIMARY KEY,
    pat_id INT,
    doc_id INT,
    appointment_date DATE NOT NULL,
    FOREIGN KEY (pat_id) REFERENCES patient(pat_id),
    FOREIGN KEY (doc_id) REFERENCES doctor(doc_id)
);

CREATE TABLE room (
    room_no INT PRIMARY KEY,
    room_type VARCHAR(20) NOT NULL,
    available INT NOT NULL
);

CREATE TABLE medication (
    code INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    brand VARCHAR(20) NOT NULL,
    description VARCHAR(20)
);

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    head_id INT NOT NULL,
    FOREIGN KEY (head_id) REFERENCES doctor(doc_id)
);

CREATE TABLE procedures (
    code INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    cost INT NOT NULL
);

CREATE TABLE prescribes (
    pre_id INT PRIMARY KEY,
    doc_id INT,
    pat_id INT,
    med_code INT,
    p_date DATE NOT NULL,
    app_id INT,
    dose INT NOT NULL,
    FOREIGN KEY (doc_id) REFERENCES doctor(doc_id),
    FOREIGN KEY (pat_id) REFERENCES patient(pat_id),
    FOREIGN KEY (med_code) REFERENCES medication(code),
    FOREIGN KEY (app_id) REFERENCES appointment(app_id)
);

CREATE TABLE Signup (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    usertype ENUM('patient', 'doctor', 'nurse') NOT NULL
);

-- Inserting records into the patient table
INSERT INTO patient (pat_id, pat_first_name, pat_last_name, pat_insurance_no, pat_ph_no, pat_address)
VALUES
(1, 'John', 'Doe', 'INS123456', '123-456-7890', '123 Main St'),
(2, 'Jane', 'Smith', 'INS789012', '456-789-0123', '456 Oak St'),
(3, 'Michael', 'Johnson', 'INS345678', '789-012-3456', '789 Elm St'),
(4, 'Emily', 'Williams', 'INS901234', '012-345-6789', '901 Maple St'),
(5, 'David', 'Brown', 'INS567890', '234-567-8901', '345 Pine St');

-- Inserting records into the doctor table
INSERT INTO doctor (doc_id, doc_first_name, doc_last_name, doc_ph_no, doc_address)
VALUES
(1, 'Dr. Sarah', 'Lee', '111-222-3333', '123 Oak St'),
(2, 'Dr. Robert', 'Garcia', '222-333-4444', '456 Elm St'),
(3, 'Dr. Jennifer', 'Martinez', '333-444-5555', '789 Maple St'),
(4, 'Dr. Michael', 'Nguyen', '444-555-6666', '901 Pine St'),
(5, 'Dr. Emily', 'Kim', '555-666-7777', '234 Cedar St');

-- Inserting records into the nurse table
INSERT INTO nurse (nur_id, nur_first_name, nur_last_name, nur_ph_no, nur_address)
VALUES
(1, 'Alice', 'Brown', '111-222-3333', '123 Oak St'),
(2, 'Bob', 'Smith', '222-333-4444', '456 Elm St'),
(3, 'Carol', 'Johnson', '333-444-5555', '789 Maple St'),
(4, 'David', 'Garcia', '444-555-6666', '901 Pine St'),
(5, 'Emma', 'Martinez', '555-666-7777', '234 Cedar St');

-- Inserting records into the appointment table
INSERT INTO appointment (app_id, pat_id, doc_id, appointment_date)
VALUES
(1, 1, 1, '2024-04-10'),
(2, 2, 2, '2024-04-11'),
(3, 3, 3, '2024-04-12'),
(4, 4, 4, '2024-04-13'),
(5, 5, 5, '2024-04-14');

-- Inserting records into the room table
INSERT INTO room (room_no, room_type, available)
VALUES
(101, 'Standard', 1),
(102, 'Standard', 1),
(103, 'VIP', 1),
(104, 'Standard', 1),
(105, 'VIP', 1);

-- Inserting records into the medication table
INSERT INTO medication (code, name, brand, description)
VALUES
(1, 'Aspirin', 'Bayer', 'Pain reliever'),
(2, 'Amoxicillin', 'Generic', 'Antibiotic'),
(3, 'Lisinopril', 'Novartis', 'Blood pressure medication'),
(4, 'Atorvastatin', 'Pfizer', 'Cholesterol-lowering medication'),
(5, 'Metformin', 'Merck', 'Diabetes medication');

-- Inserting records into the department table
INSERT INTO department (department_id, name, head_id)
VALUES
(1, 'Cardiology', 1),
(2, 'Pediatrics', 2),
(3, 'Orthopedics', 3),
(4, 'Oncology', 4),
(5, 'Neurology', 5);

-- Inserting records into the procedures table
INSERT INTO procedures (code, name, cost)
VALUES
(1, 'MRI Scan', 500),
(2, 'X-Ray', 200),
(3, 'Endoscopy', 1000),
(4, 'Colonoscopy', 1500),
(5, 'Biopsy', 800);

-- Inserting records into the prescribes table
INSERT INTO prescribes (pre_id, doc_id, pat_id, med_code, p_date, app_id, dose)
VALUES
(1, 1, 1, 1, '2024-04-10', 1, 1),
(2, 2, 2, 2, '2024-04-11', 2, 1),
(3, 3, 3, 3, '2024-04-12', 3, 1),
(4, 4, 4, 4, '2024-04-13', 4, 1),
(5, 5, 5, 5, '2024-04-14', 5, 1);

CREATE TABLE undergoes (
    under_id SERIAL PRIMARY KEY,
    pat_id INTEGER REFERENCES patient(pat_id),
    proc_code INTEGER REFERENCES procedures(code),
    u_date DATE,
    doc_id INTEGER REFERENCES doctor(doc_id),
    nur_id INTEGER REFERENCES nurse(nur_id),
    room_no INTEGER REFERENCES room(room_no)
);

-- Inserting records into the undergoes table
INSERT INTO undergoes (pat_id, proc_code, u_date, doc_id, nur_id, room_no)
VALUES
(1, 1, '2024-04-10', 1, 1, 101),
(2, 2, '2024-04-11', 2, 2, 102),
(3, 3, '2024-04-12', 3, 3, 103),
(4, 4, '2024-04-13', 4, 4, 104),
(5, 5, '2024-04-14', 5, 5, 105);

