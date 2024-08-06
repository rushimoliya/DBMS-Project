# Hospital Management System (HMS)

## Project Overview

The Hospital Management System (HMS) is a comprehensive software solution designed to streamline the operations and management of a hospital or healthcare facility. It provides a centralized platform for managing various aspects of hospital administration, including patient registration, appointment scheduling, doctor and staff management, inventory control, billing, and more. This system offers a broad overview of underlying operational factors that influence hospital management.

## Team Members

- **Rushi Moliya** (Roll Number: AU2240020)
- **Shrey Salvi** (Roll Number: AU2240033)
- **Purvansh Desai** (Roll Number: AU2240036)

## Introduction

The HMS aims to improve hospital operations, enhance patient care, and optimize resource utilization within the healthcare facility. The project includes modules for patient management, doctor and staff management, appointment management, inventory and resource management, department management, medical procedures, and prescription management.

## Project Description

The objective of this project is to design and implement a system that manages hospital-related details such as drug management, patient management, doctor management, and more. This system provides a comprehensive view of operational factors that influence hospital management.

## System Requirements

1. **Database Sections:** The system consists of different sections for various operations.
2. **Tables:** The database includes Patient, Doctor, Nurse, Appointment, Room, Medication, Department, Procedure, Undergoes, and Prescription modules.
3. **Primary and Foreign Keys:** 
   - Patient table: `patient_id` (primary key)
   - Doctor table: `doctor_id` (primary key)
   - Appointment table: References `patient_id` and `doctor_id` (foreign keys)
   - Undergoes table: References `patient_id`, `proc_code`, `doctor_id`, `nurse_id`, and `room_no` (foreign keys)

## Tools Used

- **Database:** MySQL
- **Framework:** Flask, Jinja2
- **Front-end Design:** HTML, CSS, Bootstrap 5, JavaScript, and Django
- **Browsers:** Google Chrome, Brave, Microsoft Edge
- **Other Tools:** VS Code, XAMPP, DrawSQL
- **Libraries:** `datetime`, `sqlalchemy`, `flask`, `flask_sqlalchemy`, `flask_login`, `werkzeug.security`, `flask_mail`, `json`

## ER Diagram

The ER diagram serves as a blueprint for database design, aiding in communication among developers, designers, and stakeholders, and facilitating the process of database development, maintenance, and optimization.

### Cardinality of Relationships

- **Doctor Appoints Patient:** Many-to-Many (m:n)
- **Room Has Room Availability:** One-to-Many (1:m)
- **Patient is Undergoes:** One-to-Many (1:m)
- **Doctor is Undergoes:** One-to-Many (1:m)
- **Nurse is Undergoes:** One-to-Many (1:m)
- **Room Contains Undergoes:** One-to-Many (1:m)
- **Doctor Gives Prescription:** One-to-Many (1:m)
- **Patient Takes Prescription:** One-to-Many (1:m)
- **Appointment Results Prescription:** One-to-Many (1:m)
- **Appointment Results Room Availability:** One-to-Many (1:m)

## Relational Schema

The relational schema follows the 3rd Normalization form to ensure the reduction of data redundancy and improve data integrity.

### Tables Description

1. **Patient Table:** Attributes include `patient_id`, `first_name`, `last_name`, `insurance_no`, `phone_no`, `date`, `address`.
2. **Doctor Table:** Attributes include `doctor_id`, `first_name`, `last_name`, `phone_no`, `date`, `address`.
3. **Nurse Table:** Attributes include `nurse_id`, `first_name`, `last_name`, `phone_no`, `date`, `address`.
4. **Appointment Table:** Attributes include `appointment_id`, `patient_id` (foreign key), `doctor_id` (foreign key), `appointment_date`.
5. **Room Table:** Attributes include `room_no`, `room_type`, `available`.
6. **Medication Table:** Attributes include `code`, `name`, `brand`, `description`.
7. **Department Table:** Attributes include `department_id`, `name`, `head_id` (foreign key).
8. **Procedures Table:** Attributes include `code`, `name`, `cost`.
9. **Undergoes Table:** Attributes include `under_id`, `patient_id` (foreign key), `proc_code` (foreign key), `u_date`, `doctor_id` (foreign key), `nurse_id` (foreign key), `room_no` (foreign key).
10. **Prescribes Table:** Attributes include `pres_id`, `doctor_id` (foreign key), `patient_id` (foreign key), `med_code` (foreign key), `p_date`, `app_id` (foreign key), `dose`.
11. **Signup Table:** Attributes include `user_id`, `email`, `username`, `password`, `user_type`.

## Code Integration

The code uses Flask-SQLAlchemy to connect the Flask web application to a MySQL database. Models representing database tables are defined in Python, and these models are used to interact with the database.

### Sample Model Definition

```python
class Patient(db.Model):
    patient_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(20), nullable=False)
    last_name = db.Column(db.String(20), nullable=False)
    insurance_no = db.Column(db.String(30), nullable=False)
    phone_no = db.Column(db.String(20), nullable=False)
    date = db.Column(db.Date, default=date.today())
    address = db.Column(db.String(40), nullable=False)

    def __repr__(self):
        return f"{self.patient_id} - {self.first_name} - {self.last_name} - {self.insurance_no} - {self.phone_no} - {self.date} - {self.address}"

