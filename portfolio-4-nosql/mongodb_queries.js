// =========================================================================
// MIT 8103 Advanced Database Systems - Portfolio 4: NoSQL & Advanced Models
// Case Study: Nobility Hospital System
// Paradigm: Document Store (MongoDB)
// Use Case: High-Velocity Patient Wearable Telemetry & Unstructured Vitals
// =========================================================================

// 1. Database and Collection Initialization
use nobility_hospital_telemetry;
db.createCollection("patient_vitals_log");

// 2. Data Ingestion (Implementation Evidence)
// Inserting semi-structured, hierarchical JSON documents representing continuous 
// telemetry data from patient wearables (e.g., smartwatches, remote ECG monitors).
db.patient_vitals_log.insertMany([
  {
    "patient_id": 1042, // Maps back to the relational PostgreSQL database
    "device_type": "Cardiac_Monitor_Pro_V2",
    "timestamp": ISODate("2026-11-15T10:45:00Z"),
    "readings": {
      "heart_rate_bpm": 115,
      "blood_pressure": { "systolic": 135, "diastolic": 85 },
      "oxygen_saturation_spO2": 97,
      "temperature_celsius": 37.2
    },
    "flags": ["ELEVATED_HR", "POST_EXERTION"],
    "raw_ecg_payload_s3_ref": "s3://nobility-telemetry/ecg/1042/1151045.dat"
  },
  {
    "patient_id": 1042,
    "device_type": "Cardiac_Monitor_Pro_V2",
    "timestamp": ISODate("2026-11-15T11:00:00Z"),
    "readings": {
      "heart_rate_bpm": 88,
      "blood_pressure": { "systolic": 120, "diastolic": 80 },
      "oxygen_saturation_spO2": 99,
      "temperature_celsius": 36.8
    },
    "flags": ["NORMAL_RESTING"],
    "raw_ecg_payload_s3_ref": "s3://nobility-telemetry/ecg/1042/1151100.dat"
  },
  {
    "patient_id": 2088,
    "device_type": "Smart_Pulse_Oximeter",
    "timestamp": ISODate("2026-11-15T11:05:00Z"),
    "readings": {
      "heart_rate_bpm": 72,
      "oxygen_saturation_spO2": 89 // Critical low
    },
    "flags": ["CRITICAL_SPO2_DROP"],
    "clinical_context": {
      "notified_nurse_station": true,
      "automated_alert_time": ISODate("2026-11-15T11:05:02Z")
    }
  }
]);

// 3. Performance Indexing
// Creating a compound index to support rapid time-series queries per patient
db.patient_vitals_log.createIndex({ "patient_id": 1, "timestamp": -1 });

// 4. Query Example A: Critical Alert Filtering
// Retrieve all telemetry records in the last 24 hours where SpO2 dropped below 92%
db.patient_vitals_log.find({
  "readings.oxygen_saturation_spO2": { $lt: 92 },
  "timestamp": { $gte: ISODate("2026-11-14T00:00:00Z") }
}).sort({ "timestamp": -1 });

// 5. Query Example B: Aggregation Pipeline for Daily Clinical Averages
// Calculate the average, min, and max heart rate for a specific patient over a timeframe
db.patient_vitals_log.aggregate([
  { $match: { "patient_id": 1042 } },
  { 
    $group: {
      _id: { 
        year: { $year: "$timestamp" }, 
        month: { $month: "$timestamp" }, 
        day: { $dayOfMonth: "$timestamp" } 
      },
      avg_heart_rate: { $avg: "$readings.heart_rate_bpm" },
      max_heart_rate: { $max: "$readings.heart_rate_bpm" },
      min_heart_rate: { $min: "$readings.heart_rate_bpm" },
      reading_count: { $sum: 1 }
    }
  },
  { $sort: { "_id.year": -1, "_id.month": -1, "_id.day": -1 } }
]);