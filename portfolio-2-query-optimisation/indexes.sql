-- =========================================================================
-- Indexing Strategy for Nobility Hospital Performance Optimisation
-- =========================================================================

-- 1. Optimise foreign key joins between appointments and patients/doctors
CREATE INDEX CONCURRENTLY idx_appointments_patient_id ON appointments(patient_id);
CREATE INDEX CONCURRENTLY idx_appointments_doctor_id ON appointments(doctor_id);

-- 2. Optimise lookup on medical records linked to appointments
CREATE INDEX CONCURRENTLY idx_medical_records_appointment_id ON medical_records(appointment_id);

-- 3. Optimise filtering and sorting for pending lab diagnostic queues (Partial Index)
-- This partial index only indexes rows where status is 'Pending', saving storage and memory.
CREATE INDEX CONCURRENTLY idx_lab_records_pending_status 
ON lab_records(test_status, ordered_at) 
WHERE test_status = 'Pending';