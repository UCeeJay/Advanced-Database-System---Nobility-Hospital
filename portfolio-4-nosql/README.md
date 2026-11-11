# Portfolio 4: NoSQL and Advanced Data Models
**Case Study:** Nobility Hospital System  
**Course:** MIT 8103 Advanced Database Systems  

---

## 1. Overview and Model Selection
While our core relational PostgreSQL database handles transactional operations with strict ACID properties (billing, appointments, pharmacy inventory), modern healthcare requires tracking high-velocity, semi-structured data. For this portfolio, we integrated a **Document Store (MongoDB)** to model and manage **Patient Wearable Telemetry and Continuous Vitals Monitoring**.

## 2. Explanation of Architectural Suitability
A Document NoSQL paradigm was selected over Key-Value, Column-Family, or Graph architectures for the following critical reasons[cite: 13]:

1. **Schema Flexibility for Heterogeneous Devices:** Different telemetry devices (ECG monitors, pulse oximeters, smartwatches) transmit varying payloads. A document store allows us to ingest `{ "heart_rate": 80 }` from one device and `{ "blood_pressure": {...}, "temperature": 37 }` from another within the same collection without altering rigid schema definitions or storing widespread `NULL` values.
2. **Hierarchical Data Representation:** Vitals often contain nested attributes (e.g., `blood_pressure` split into `systolic` and `diastolic`). JSON documents map this natively, avoiding complex relational child-table joins.
3. **High-Velocity Ingestion:** NoSQL document databases excel at high-throughput write operations, making them ideal for continuous time-series event logging from hundreds of active ward beds.

## 3. Data Model Implementation
The NoSQL implementation bridges to our relational database using the `patient_id` as a loosely coupled reference key.

**Document Structure Example:**
```json
{
  "_id": "ObjectId('655b3f...')",
  "patient_id": 1042,
  "device_type": "Cardiac_Monitor_Pro_V2",
  "timestamp": "2026-11-15T10:45:00Z",
  "readings": {
    "heart_rate_bpm": 115,
    "blood_pressure": { "systolic": 135, "diastolic": 85 },
    "oxygen_saturation_spO2": 97
  },
  "flags": ["ELEVATED_HR"]
}
