-- =========================================================================
-- MIT 8103 Advanced Database Systems - Portfolio 1: Database Design & Modelling
-- Case Study: Nobility Hospital System
-- Target RDBMS: PostgreSQL / MySQL Compatible DDL
-- =========================================================================

-- Drop tables if they already exist (clean re-initialisation order)
DROP TABLE IF EXISTS lab_records CASCADE;
DROP TABLE IF EXISTS prescriptions CASCADE;
DROP TABLE IF EXISTS medical_records CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS patients CASCADE;

-- 1. Patients Table
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20) CHECK (gender IN ('Male', 'Female', 'Other', 'Prefer not to say')),
    contact_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT NOT NULL,
    emergency_contact VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Doctors Table
CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    consultation_fee DECIMAL(10, 2) NOT NULL CHECK (consultation_fee >= 0.00),
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Appointments Table
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_datetime TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled' CHECK (status IN ('Scheduled', 'Completed', 'Cancelled', 'No-Show')),
    reason_for_visit TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE RESTRICT
);

-- 4. Medical Records (Diagnoses & Consultations) Table
CREATE TABLE medical_records (
    record_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT UNIQUE, -- Optional link to a specific scheduled appointment
    diagnosis_notes TEXT NOT NULL,
    treatment_plan TEXT NOT NULL,
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_record_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_record_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE RESTRICT,
    CONSTRAINT fk_record_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE SET NULL
);

-- 5. Prescriptions Table
CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    record_id INT NOT NULL,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL, -- e.g., 'Twice daily'
    duration VARCHAR(50) NOT NULL,  -- e.g., '7 days'
    instructions TEXT,
    CONSTRAINT fk_prescription_record FOREIGN KEY (record_id) REFERENCES medical_records(record_id) ON DELETE CASCADE
);

-- 6. Laboratory Records Table
CREATE TABLE lab_records (
    lab_record_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    ordered_by_doctor_id INT NOT NULL,
    test_name VARCHAR(100) NOT NULL,
    test_status VARCHAR(20) DEFAULT 'Pending' CHECK (test_status IN ('Pending', 'In-Progress', 'Completed', 'Cancelled')),
    results_summary TEXT,
    result_file_path VARCHAR(255),
    ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    CONSTRAINT fk_lab_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_lab_doctor FOREIGN KEY (ordered_by_doctor_id) REFERENCES doctors(doctor_id) ON DELETE RESTRICT
);

-- =========================================================================
-- End of DDL Script for Portfolio 1
-- =========================================================================