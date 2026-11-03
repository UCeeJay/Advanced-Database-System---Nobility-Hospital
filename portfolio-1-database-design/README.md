## 1. Case Study Overview
* **Organisation Name:** Nobility Hospital
* **Nature of Business:** A multi-specialty healthcare institution delivering outpatient care, emergency diagnostics, inpatient admissions, pharmaceutical dispensations, and laboratory pathology testing.
* **Database Users:** Patients, attending physicians/specialists, laboratory technicians, and system administrators.
* **Core Operations:** Registering patient profiles, scheduling/rescheduling clinical appointments, capturing clinical diagnoses and treatment plans, issuing electronic prescriptions, and tracking laboratory test workflows.

## 2. Entity-Relationship (ER) Diagram
<img width="1024" height="559" alt="image" src="https://github.com/user-attachments/assets/f977bdff-768c-413a-a6cb-bf1f5c002609" />


### Relationship Summary:
* **Patients to Appointments (1:M):** A patient can book multiple appointments over time.
* **Doctors to Appointments (1:M):** A doctor manages multiple appointment schedules.
* **Patients to Medical Records (1:M):** Patients build a longitudinal medical history.
* **Doctors to Medical Records (1:M):** Doctors author consultation notes and diagnoses.
* **Medical Records to Prescriptions (1:M):** A single consultation can yield multiple prescribed medications.
* **Patients to Lab Records (1:M):** Patients undergo diagnostic lab tests ordered by physicians.

## 3. Relational Schema & Constraints Summary
The database is structured across 6 core normalized tables:
1. `patients`: Stores demographic and emergency contact data (`patient_id` as PK).
2. `doctors`: Stores staff credentials, specializations, and consultation fees (`doctor_id` as PK).
3. `appointments`: Manages booking schedules and statuses with foreign keys linking patients and doctors.
4. `medical_records`: Captures clinical diagnoses and treatment plans.
5. `prescriptions`: Details medication instructions linked to specific medical records.
6. `lab_records`: Tracks diagnostic test lifecycles from pending to completion.

*Refer to `schema.sql` in this directory for the full executable DDL code containing all Primary Keys, Foreign Keys with cascading/restrictive referential integrity rules, and CHECK constraints.*

## 4. Normalisation Explanation (Up to 3NF)
* **First Normal Form (1NF):** All table columns contain atomic, indivisible values. Repeating groups or multi-valued lists (such as multi-medication prescriptions) have been atomized into dedicated child relations (`prescriptions`).
* **Second Normal Form (2NF):** The schema is in 1NF and all non-key attributes are fully functionally dependent on the primary key. All tables utilize single-attribute surrogate primary keys (`SERIAL`), eliminating partial dependencies in composite keys.
* **Third Normal Form (3NF):** The schema is in 2NF and contains no transitive dependencies. Non-key attributes (e.g., doctor consultation fees, patient addresses) depend exclusively on the primary key of their respective entities rather than other non-key attributes.
