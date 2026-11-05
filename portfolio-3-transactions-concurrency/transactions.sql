-- =========================================================================
-- MIT 8103 Advanced Database Systems - Portfolio 3: Transactions & Concurrency
-- Case Study: Nobility Hospital System
-- =========================================================================

-- =========================================================================
-- SECTION 1: Explicit Transaction with COMMIT (Successful Workflow)
-- Scenario: A patient books an appointment and a mandatory initial lab test 
-- is ordered simultaneously within an atomic unit of work.
-- =========================================================================

BEGIN;

-- Step 1.1: Insert appointment record
INSERT INTO appointments (patient_id, doctor_id, appointment_datetime, status, reason_for_visit)
VALUES (1042, 3, '2026-11-15 10:30:00', 'Scheduled', 'Routine cardiology follow-up and ECG screening')
RETURNING appointment_id;

-- Step 1.2: Insert corresponding lab record linked to the patient and doctor
INSERT INTO lab_records (patient_id, ordered_by_doctor_id, test_name, test_status)
VALUES (1042, 3, 'Electrocardiogram (ECG)', 'Pending');

-- If both operations succeed without error, commit the transaction
COMMIT;


-- =========================================================================
-- SECTION 2: Explicit Transaction with ROLLBACK (Failure & Exception Handling)
-- Scenario: Attempting to insert a prescription for a non-existent medical record 
-- violates foreign key constraints, triggering a complete transaction rollback 
-- to preserve database consistency.
-- =========================================================================

BEGIN;

-- Step 2.1: Initial valid operation (e.g., updating patient contact)
UPDATE patients 
SET contact_number = '+234-803-555-0199' 
WHERE patient_id = 1042;

-- Step 2.2: Erroneous operation (violating FK constraint on non-existent record_id = 99999)
INSERT INTO prescriptions (record_id, medication_name, dosage, frequency, duration, instructions)
VALUES (99999, 'Lisinopril', '10mg', 'Once daily', '30 days', 'Take in the morning with water');

-- If an error is caught or constraint fails, rollback all changes in this block
ROLLBACK;


-- =========================================================================
-- SECTION 3: Concurrency Control & Isolation Level Demonstration
-- Scenario: Preventing Non-Repeatable Reads and Dirty Reads during high-volume 
-- doctor schedule updates and billing audits.
-- =========================================================================

-- Session A: Setting strict Serializable / Repeatable Read isolation for financial/scheduling integrity
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Read consultation fee for Doctor ID 3
SELECT doctor_id, first_name, last_name, consultation_fee 
FROM doctors 
WHERE doctor_id = 3;

-- (Simulating concurrent update in Session B occurring here...)
-- Session A re-reads the same data within the active transaction window
-- Under REPEATABLE READ, Session A is insulated from Session B's uncommitted or newly committed changes.
SELECT doctor_id, first_name, last_name, consultation_fee 
FROM doctors 
WHERE doctor_id = 3;

COMMIT;