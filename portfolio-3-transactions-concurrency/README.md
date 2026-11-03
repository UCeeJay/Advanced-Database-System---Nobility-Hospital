# Portfolio 3: Transactions and Concurrency
**Case Study:** Nobility Hospital System  
**Course:** MIT 8103 Advanced Database Systems  

---

## 1. Overview
This portfolio section examines database transaction management, ACID properties (Atomicity, Consistency, Isolation, Durability), and concurrency control mechanisms applied to **Nobility Hospital**. In a medical database, handling simultaneous patient bookings, inventory updates, and billing records requires rigorous transactional safeguards to prevent data corruption and concurrency anomalies.

---

## 2. ACID Implementation Evidence (`transactions.sql`)
The provided script demonstrates how Nobility Hospital enforces transaction boundaries:
- **Atomicity:** Ensured via `BEGIN` and `COMMIT` blocks. For multi-table workflows (such as scheduling an appointment and generating a lab test request), either all operations succeed or none are applied.
- **Consistency & Referential Integrity:** Demonstrated via explicit `ROLLBACK` handling when an erroneous operation violates foreign key constraints (e.g., inserting a prescription referencing a non-existent `record_id`). The database aborts the transaction and reverts all prior staged changes in that block.

---

## 3. Concurrency Control & Isolation Levels
When multiple clinical administrators and doctors modify records simultaneously, concurrency anomalies can occur:
1. **Dirty Reads:** Reading uncommitted data from another concurrent transaction.
2. **Non-Repeatable Reads:** Fetching different values for the same row when another transaction modifies and commits data during your active read session.
3. **Phantom Reads:** Encountering newly inserted rows matching a search criteria during a transaction.

### Mitigation Strategy
By configuring transactions with strict isolation levels (`REPEATABLE READ` or `SERIALIZABLE`), our database engine places appropriate shared and exclusive locks (`ROW SHARE`, `ROW EXCLUSIVE`) to isolate concurrent sessions, ensuring audit and billing consistency across hospital operations as captured in `concurrency_logs.txt`.

---

## 4. Verification & File Manifest
* `transactions.sql`: Executable scripts demonstrating explicit commits, rollbacks, and isolation levels.
* `concurrency_logs.txt`: Terminal execution logs and output traces verifying concurrency anomaly prevention.
* `README.md`: Technical documentation of ACID compliance and transaction safety.
