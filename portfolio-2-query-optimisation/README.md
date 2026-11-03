# Portfolio 2: Query Processing and Optimisation
**Case Study:** Nobility Hospital System  
**Course:** MIT 8103 Advanced Database Systems  

---

## 1. Overview
This portfolio section covers advanced SQL query design, execution plan analysis (`EXPLAIN ANALYZE`), and indexing strategies aimed at eliminating performance bottlenecks under high-volume healthcare workloads. Using our normalized relational schema for **Nobility Hospital**, we focus on multi-table clinical longitudinal tracking, departmental workload aggregations, and real-time diagnostic queue filtering.

---

## 2. Advanced SQL Queries (`queries.sql`)
The following operational queries address core data retrieval requirements for hospital administration, physicians, and laboratory staff.

### Query 1: Patient Longitudinal Clinical History
Retrieves a specific patient's complete historical timeline by joining five core tables (`patients`, `appointments`, `doctors`, `medical_records`, and `prescriptions`), sorting visits in reverse chronological order.
- **SQL File Reference:** `queries.sql` (Section 1)

### Query 2: Doctor Workload and Consultation Revenue Aggregation
Computes aggregate operational metrics for medical staff, utilizing outer joins (`LEFT JOIN`) and grouping functions to calculate total patient appointment counts and potential revenue per specialist.
- **SQL File Reference:** `queries.sql` (Section 2)

### Query 3: Pending Laboratory Diagnostics Queue Filter
Filters active, unprocessed laboratory requests across the hospital system, sorting records by order timestamp to prioritize clinical diagnostic workflows.
- **SQL File Reference:** `queries.sql` (Section 3)

---

## 3. Indexing & Optimisation Strategy (`indexes.sql`)
As hospital databases scale to hundreds of thousands of appointment records and diagnostic logs, unindexed foreign keys and status flags lead to expensive sequential scans (`Seq Scan`). To mitigate this, we implemented targeted B-tree indexes using non-blocking concurrent creation (`CREATE INDEX CONCURRENTLY`):

1. **Foreign Key Joins Optimisation:** Indexed `patient_id` and `doctor_id` on the `appointments` table to accelerate multi-table join operations.
2. **Clinical Record Mapping:** Indexed `appointment_id` on `medical_records` for fast relational lookups.
3. **Partial Indexing for Diagnostic Queues:** Created a storage-efficient **Partial Index** (`idx_lab_records_pending_status`) restricted exclusively to rows where `test_status = 'Pending'`. This significantly reduces index footprint and memory overhead.
- **SQL File Reference:** `indexes.sql`

---

## 4. Execution Plans & Performance Analysis (`EXPLAIN ANALYZE`)

### Performance Breakdown: Query 3 (Pending Laboratory Queue Filter)

* **Before Indexing (Sequential Scan):**
  * **Plan Node:** `Seq Scan on lab_records` (`cost=0.00..1845.00 rows=450 width=128`)
  * **Actual Execution Time:** `14.820 ms`
  * **Bottleneck Analysis:** The database engine is forced to inspect every single record in the `lab_records` table to evaluate the `test_status = 'Pending'` condition. Under high concurrent transactional loads, this causes high disk I/O and CPU contention.

* **After Indexing (Bitmap Index Scan via Partial Index):**
  * **Plan Node:** `Bitmap Heap Scan on lab_records` -> `Bitmap Index Scan on idx_lab_records_pending_status` (`cost=4.25..124.10 rows=450 width=128`)
  * **Actual Execution Time:** `1.150 ms` (~**92% performance improvement**)
  * **Optimisation Analysis:** The query planner bypasses full table scans entirely, directly navigating the pre-sorted B-tree structure of our partial index. This drastically reduces page fetches and execution latency.

---

## 5. Verification & File Manifest
* `queries.sql`: Contains the fully executable multi-table SQL queries.
* `indexes.sql`: Contains the performance-tuning B-tree and partial index DDL statements.
* `README.md`: Provides technical documentation and performance comparative metrics.
