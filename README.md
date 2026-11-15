# Advanced-Database-System---Nobility-Hospital

**Full Name:** Chibuikem Joshua Anunobi-Ukwuoma  
**Email Address:** c.anunobi-ukwuoma28251@miva.edu.ng  

---

## 1. Project Overview
This repository contains the progressive practical evidence and technical documentation for the MIT 8103 Advanced Database Systems Continuous Assessment. It demonstrates the end-to-end design, implementation, analysis, and optimization of a high-performance database architecture tailored to a real-world enterprise healthcare scenario.

## 2. Database Case Study: Nobility Hospital System
This portfolio consistently utilizes **Nobility Hospital** as its core case study across all technical implementations.

*   **Nature of Business:** A multi-specialty healthcare institution managing outpatient care, emergency diagnostics, inpatient admissions, pharmaceutical dispensations, and laboratory pathology testing.
*   **Database Users:** Patients, attending physicians/specialists, laboratory technicians, and system administrators.
*   **Major Data Stored:** Patient demographics, doctor credentials, medical appointments, clinical diagnoses, prescriptions, diagnostic laboratory records, and high-velocity patient wearable telemetry (e.g., ECG and SpO2 readings).
*   **Key Database Operations:** Registering patient profiles, scheduling and rescheduling clinical appointments, capturing clinical diagnoses and treatment plans, storing electronic prescriptions, tracking laboratory test workflows, and managing concurrent billing operations.

---

## 3. Repository Structure and Deliverables
The project is strictly organized into five progressive portfolio milestones, each addressing a core advanced database paradigm. 

### [Portfolio 1: Database Design and Modelling](./portfolio-1-database-design/)
*   **Focus:** Conceptual and logical data modeling.
*   **Evidence:** Entity-Relationship (ER) diagram, complete PostgreSQL relational schema (`schema.sql`), defined primary/foreign key constraints, and a formal explanation of data normalization up to 3NF.

### [Portfolio 2: Query Processing and Optimisation](./portfolio-2-query-optimisation/)
*   **Focus:** Query performance tuning and execution analysis.
*   **Evidence:** Advanced multi-table SQL queries (`queries.sql`), concurrency-safe B-Tree and Partial index implementations (`indexes.sql`), and comparative `EXPLAIN ANALYZE` execution plans detailing performance gains.

### [Portfolio 3: Transactions and Concurrency](./portfolio-3-transactions-concurrency/)
*   **Focus:** ACID compliance and isolation mechanisms.
*   **Evidence:** Executable transaction scripts (`transactions.sql`) demonstrating explicit `COMMIT` and `ROLLBACK` error handling, alongside manual terminal logs (`concurrency_logs.txt`) proving the prevention of dirty and non-repeatable reads using `REPEATABLE READ` isolation levels.

### [Portfolio 4: NoSQL and Advanced Data Models](./portfolio-4-nosql/)
*   **Focus:** Managing semi-structured, high-velocity data.
*   **Evidence:** A MongoDB Document database model (`mongodb_queries.js`) designed to ingest patient wearable telemetry. Includes execution logs (`nosql_logs.txt`) demonstrating compound indexing and aggregation pipelines, alongside an architectural justification for the Document paradigm.

### [Portfolio 5: Distributed and Cloud Database Exercise](./portfolio-5-distributed-cloud/)
*   **Focus:** High Availability (HA), replication, and CAP Theorem trade-offs.
*   **Evidence:** A containerized PostgreSQL Primary-Replica distributed cluster configuration (`docker-compose.yml`) deployed to an Ubuntu cloud server, supported by replication verification logs (`cloud_replication_logs.txt`) and discussions on sharding and consistency.

---

## 4. Execution and Testing Environment
All scripts and deployments within this repository were manually verified and rigorously tested. 
*   **Relational Engine:** PostgreSQL 18
*   **NoSQL Engine:** MongoDB Community Server (via `mongosh`)
*   **Cloud Infrastructure:** Ubuntu Linux VM, Docker Engine, and Docker Compose Plugin

To replicate the execution outputs, initialize the respective databases locally or via the provided `docker-compose.yml` stack, execute the schema definitions, and run the queries as outlined in the `README.md` of each specific portfolio directory.

---

## 5. Academic Integrity
This repository represents individual technical work[cite: 23]. All external documentation, container images (e.g., Bitnami PostgreSQL), and tools have been appropriately referenced. A formal AI-Use Declaration detailing the use of generative AI as a learning and debugging aid, along with the subsequent manual validation procedures, is included in the accompanying LMS submission document.
