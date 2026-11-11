# Portfolio 5: Distributed and Cloud Database Exercise
**Case Study:** Nobility Hospital System  
**Course:** MIT 8103 Advanced Database Systems  

---

## 1. Overview
As Nobility Hospital scales to multiple regional branches, a single-node database architecture becomes a single point of failure and a geographic bottleneck. This portfolio outlines the distributed and cloud database architecture for the hospital, detailing replication, sharding, high availability (HA), and consistency trade-offs to ensure continuous medical operations[cite: 13].

## 2. Replication and High Availability (HA)
To guarantee high availability for critical relational data (patient records, appointments, and billing), Nobility Hospital utilizes a **Primary-Replica (Master-Slave) Replication** strategy[cite: 13].
* **Write Operations:** All `INSERT`, `UPDATE`, and `DELETE` queries (e.g., booking a new appointment or generating a lab result) are routed exclusively to the Primary Node.
* **Read Operations:** Read-heavy queries (e.g., aggregating doctor workloads or querying longitudinal patient histories) are offloaded to asynchronous Read Replicas. 
* **Failover Mechanism:** If the Primary Node experiences hardware failure, a Read Replica is automatically promoted to Primary to prevent downtime in emergency wards. 

## 3. Sharding Strategy for High-Velocity Data
While the PostgreSQL relational schema handles transactional integrity, the high-velocity telemetry data stored in our MongoDB NoSQL architecture requires horizontal scaling[cite: 13].
* **Architecture:** We implement a **Sharded Cluster** for the `patient_vitals_log` collection.
* **Shard Key:** We utilize a Hashed Shard Key on the `patient_id` field (`{ patient_id: "hashed" }`). 
* **Justification:** A hashed shard key ensures an even distribution of incoming telemetry streams across multiple cloud storage nodes, preventing "hot shards" that could occur if data were partitioned purely by timestamp or ward location.

## 4. CAP Theorem and Consistency Trade-offs
In distributed systems, the CAP Theorem dictates that a database can only strongly guarantee two out of three traits: Consistency (C), Availability (A), and Partition Tolerance (P)[cite: 13]. Nobility Hospital handles distinct workloads that require different trade-offs:

1. **Relational Billing and Pharmacy Inventory (CP - Consistency & Partition Tolerance):** 
   For financial transactions and medication dispensing, strict consistency is mandatory. We prioritize Consistency over Availability; if a network partition occurs between hospital branches, the system will block transactions rather than risk double-billing a patient or over-dispensing restricted narcotics.
   
2. **NoSQL Telemetry Ingestion (AP - Availability & Partition Tolerance):** 
   For continuous patient wearable data (heart rate, SpO2), Availability is prioritized over strict consistency. If a network partition occurs, local nodes will continue accepting telemetry data to ensure critical alerts are triggered locally, syncing with the central database once the partition resolves (Eventual Consistency).

## 5. Deployment Evidence
The included `docker-compose.yml` file provides practical deployment evidence of our distributed relational setup[cite: 13, 14]. It configures a virtualized cloud-native environment featuring:
* A containerized PostgreSQL Primary Node acting as the source of truth.
* A connected PostgreSQL Read Replica Node configured with streaming replication credentials.
* Isolated virtual networking (`nobility_network`) to simulate secure VPC (Virtual Private Cloud) communications between database instances.

## 6. Verification & File Manifest
* `docker-compose.yml`: Executable deployment script establishing a local distributed primary-replica cluster[cite: 13].
* `README.md`: Architectural documentation detailing sharding, replication, and CAP theorem alignment[cite: 13, 14].
