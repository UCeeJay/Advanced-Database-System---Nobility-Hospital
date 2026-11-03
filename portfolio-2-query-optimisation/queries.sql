-- =========================================================================
-- MIT 8103 Advanced Database Systems - Portfolio 2: Query Processing & Optimisation
-- Case Study: Nobility Hospital System
-- =========================================================================

-- 1. Patient Longitudinal Clinical History Query
-- Joins patients, appointments, medical records, doctors, and prescriptions
SELECT 
    p.patient_id,
    p.first_name || ' ' || p.last_name AS patient_name,
    a.appointment_datetime,
    d.first_name || ' ' || d.last_name AS attending_doctor,
    d.specialization,
    mr.diagnosis_notes,
    mr.treatment_plan,
    pr.medication_name,
    pr.dosage,
    pr.frequency
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN medical_records mr ON a.appointment_id = mr.appointment_id
LEFT JOIN prescriptions pr ON mr.record_id = pr.record_id
WHERE p.patient_id = 1042
ORDER BY a.appointment_datetime DESC;

-- 2. Doctor Workload and Consultation Revenue Aggregation
SELECT 
    d.doctor_id,
    d.first_name || ' ' || d.last_name AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(d.consultation_fee) AS potential_revenue
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization
ORDER BY total_appointments DESC;

-- 3. Pending Laboratory Diagnostics Queue Filter
SELECT 
    lr.lab_record_id,
    p.patient_id,
    p.first_name || ' ' || p.last_name AS patient_name,
    lr.test_name,
    lr.test_status,
    lr.ordered_at,
    doc.first_name || ' ' || doc.last_name AS ordered_by_doctor
FROM lab_records lr
JOIN patients p ON lr.patient_id = p.patient_id
JOIN doctors doc ON lr.ordered_by_doctor_id = doc.doctor_id
WHERE lr.test_status = 'Pending'
ORDER BY lr.ordered_at ASC;