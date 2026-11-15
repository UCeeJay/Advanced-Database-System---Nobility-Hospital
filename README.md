# Advanced-Database-System---Nobility-Hospital

**Full Name:** Chibuikem Joshua Anunobi-Ukwuoma  
**Email Address:** c.anunobi-ukwuoma28251@miva.edu.ng  
**GitHub Repository Link:** [https://github.com/UCeeJay/Advanced-Database-System---Nobility-Hospital](https://github.com/UCeeJay/Advanced-Database-System---Nobility-Hospital)  

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

## 3. Summary of Portfolio Activities & Deliverables
Over the course of the semester, the Nobility Hospital database was engineered through five progressive phases to meet advanced computing requirements. 

### [Portfolio 1: Database Design and Modelling](./portfolio-1-database-design/)
*   **Summary:** Designed a fully normalized relational architecture (up to 3NF) comprising six core entities (`patients`, `doctors`, `appointments`, `medical_records`, `prescriptions`, `lab_records`). Delivered a comprehensive Entity-Relationship (ER) diagram and an executable PostgreSQL DDL schema enforcing strict primary and foreign key referential integrity.
*   **Evidence:** Entity-Relationship (ER) diagram (`er_diagram.jpeg`), complete PostgreSQL relational schema (`schema.sql`), and a formal explanation of data normalization.

### [Portfolio 2: Query Processing and Optimisation](./portfolio-2-query-optimisation/)
*   **Summary:** Developed complex multi-table SQL queries for longitudinal patient tracking and departmental workload aggregation. Addressed high-volume performance bottlenecks by implementing targeted B-Tree and memory-efficient Partial Indexes, reducing sequential scan execution times by over 90% as evidenced by `EXPLAIN ANALYZE` execution plans.
*   **Evidence:** Advanced multi-table SQL queries (`queries.sql`), concurrency-safe index implementations (`indexes.sql`), and comparative execution plans.

### [Portfolio 3: Transactions and Concurrency](./portfolio-3-transactions-concurrency/)
*   **Summary:** Ensured strict ACID compliance for sensitive medical workflows (e.g., dual appointment and lab request bookings). Implemented explicit `COMMIT` and `ROLLBACK` boundaries to maintain atomicity and configured `REPEATABLE READ` transaction isolation levels to prevent non-repeatable and dirty reads during concurrent billing updates.
*   **Evidence:** Executable transaction scripts (`transactions.sql`) and manual terminal logs proving the prevention of concurrency anomalies.

### [Portfolio 4: NoSQL and Advanced Data Models](./portfolio-4-nosql/)
*   **Summary:** Integrated a MongoDB Document database to handle semi-structured, high-velocity patient wearable telemetry (e.g., continuous ECG and SpO2 monitor payloads). The flexible JSON document model allowed for the ingestion of heterogeneous device payloads without schema rigidness, supported by compound indexing and aggregation pipelines for clinical alert filtering.
*   **Evidence:** A MongoDB Document database model (`mongodb_queries.js`) and execution logs (`nosql_logs.txt`) demonstrating document ingestion and aggregation.

### [Portfolio 5: Distributed and Cloud Database Exercise](./portfolio-5-distributed-cloud/)
*   **Summary:** Architected and deployed a highly available (HA) PostgreSQL Primary-Replica distributed cluster using Docker on a cloud virtual machine. This separated read/write workloads to eliminate geographic bottlenecks and addressed CAP theorem trade-offs, prioritizing strict Consistency for financial/pharmacy data and Availability for NoSQL telemetry ingestion.
*   **Evidence:** A containerized PostgreSQL cluster configuration (`docker-compose.yml`) and replication verification logs (`cloud_replication_logs.txt`).

---

## 4. Individual Technical Reflection
Throughout the implementation of this advanced database portfolio, transitioning from theoretical design to practical cloud deployment presented several complex engineering challenges that required active debugging and system adaptation:

1.  **Cloud Containerization & Legacy Versioning:** While deploying the Primary-Replica cluster on an Ubuntu cloud server, I encountered parsing issues with obsolete `docker-compose.yml` top-level versioning (`version: '3.8'`). Furthermore, Docker Hub's restriction on free unversioned short tags caused reference resolution failures. I resolved this by purging legacy Docker engines, installing the modern Compose plugin, removing the obsolete version tag, and pinning an immutable image version (`bitnamilegacy/postgresql:16.4.0-debian-12-r7`).
2.  **Replica Initialization Failures:** During the HA cluster spin-up, the read replica container continually aborted. Through log analysis, I discovered that Bitnami’s PostgreSQL replica requires a local administrative password during initialization despite being a slave node. By manually injecting the `POSTGRESQL_PASSWORD` environment variable into the replica's configuration and rebuilding the volumes (`docker compose down -v`), I successfully established the streaming replication.
3.  **Headless NoSQL Execution:** When executing my MongoDB scripts via the system terminal to capture continuous logs, I encountered syntax errors because interactive shell helpers (like `use nobility_hospital_telemetry`) are not supported in `mongosh` script execution. I successfully refactored the codebase to use standard JavaScript (`db = db.getSiblingDB()`), wrapped operations in `printjson()`, and appended `.toArray()` to cursors. This allowed me to safely switch contexts and generate formatted, readable terminal evidence for my portfolio.

---

## 5. Execution and Testing Environment
All scripts and deployments within this repository were manually verified and rigorously tested. 
*   **Relational Engine:** PostgreSQL 18
*   **NoSQL Engine:** MongoDB Community Server (via `mongosh`)
*   **Cloud Infrastructure:** Ubuntu Linux VM, Docker Engine, and Docker Compose Plugin

To replicate the execution outputs, initialize the respective databases locally or via the provided `docker-compose.yml` stack, execute the schema definitions, and run the queries as outlined in the `README.md` of each specific portfolio directory.

---

## 6. Repository Structure

```text
advanced-database-portfolio/
├── portfolio-1-database-design/
│   ├── README.md
│   ├── schema.sql
│   └── er_diagram.jpeg
├── portfolio-2-query-optimisation/
│   ├── README.md
│   ├── queries.sql
│   └── indexes.sql
├── portfolio-3-transactions-concurrency/
│   ├── README.md
│   ├── transactions.sql
│   └── concurrency_logs.txt
├── portfolio-4-nosql/
│   ├── README.md
│   ├── mongodb_queries.js
│   └── nosql_logs.txt
├── portfolio-5-distributed-cloud/
│   ├── README.md
│   ├── docker-compose.yml
│   └── cloud_replication_logs.txt
└── README.md
```

---

## 7. Academic Integrity & AI-Use Declaration
This repository represents individual technical work. All external documentation, container images, and tools have been appropriately referenced. In compliance with the University's academic integrity guidelines, this section outlines the utilization of AI tools during the development of this portfolio:

*   **AI Tool Used:** Google Gemini
*   **Purpose of Use:** Gemini was utilized as a technical co-pilot to assist in brainstorming the Nobility Hospital architecture, formatting markdown documentation, generating initial drafts of SQL/DDL boilerplate based on my defined parameters, and producing the Entity-Relationship diagram.
*   **Verification and Testing:** No AI output was submitted unverified. All generated scripts were subjected to rigorous manual testing in local and cloud environments. I independently provisioned an Ubuntu cloud server, executed the SQL and NoSQL scripts via `psql` and `mongosh`, rewrote JavaScript shell commands to ensure successful headless execution, and diagnosed and fixed environment variable omissions in Docker configurations. All provided execution plans, replication logs, and performance metrics are authentic outputs generated from my manual terminal testing.
