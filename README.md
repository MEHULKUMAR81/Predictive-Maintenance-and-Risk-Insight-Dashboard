# Machine Failure & Maintenance Risk Analysis

## Overview

Analysis of industrial machine sensor data to identify failure drivers and support maintenance decision-making. The workflow integrates SQL-based data preparation with a Tableau dashboard to evaluate operational risk across wear and load conditions.

---

## Dataset

Source: UCI Machine Learning Repository
AI4I 2020 Predictive Maintenance Dataset
https://archive.ics.uci.edu/ml/datasets/AI4I+2020+Predictive+Maintenance+Dataset

~10,000 records capturing machine-level observations including tool wear, torque, temperature, rotational speed, failure type, and machine status.

---

## Objective

* Quantify failure behavior under varying operating conditions
* Segment machines into risk zones using wear and torque
* Evaluate failure rate distribution across segments
* Translate patterns into maintenance action categories

---

## Data Preparation (SQL)

Structured data pipeline implemented for cleaning, transformation, and feature creation.

**Key steps:**

* Duplicate removal and null handling
* Standardization of categorical fields
* Feature engineering:

  * Torque Bucket (Low / Medium / High)
  * Wear Zone (Low / Medium / High)
* Aggregation of failure rates by segment
* Creation of analysis-ready views

**Core SQL functions:**
`COUNT()`, `SUM()`, `AVG()`, `CASE WHEN`, `GROUP BY`, `HAVING`,
`ROW_NUMBER()`, `DENSE_RANK()`, `TRIM()`, `COALESCE()`, `CAST()`

---

## Dashboard (Tableau)

https://public.tableau.com/views/PredictiveMaintenanceandRiskInsight/PredictiveMaintenanceDashboard

Interactive dashboard designed for operational analysis and decision support.

**Components:**

* KPI summary: failure rate, total failures, total records, average torque, average wear
* Risk matrix: failure rate across wear zone × torque bucket
* Operating map: tool wear vs torque with failure classification and trend analysis
* Maintenance action view: mapping risk segments to recommended actions

---

## Key Findings

* Failure rate is highest in **high wear + high torque** conditions (~13%)
* Failures are concentrated at elevated tool wear levels (>180)
* Risk is driven by combined operating conditions rather than single variables
* Majority of operations fall within low-risk regions, with failures clustered in specific segments
* High-risk zones require immediate inspection to prevent escalation

---

## Functional Capabilities

* Segment-based risk evaluation
* Drill-down analysis to machine (UID) level
* Interactive filtering between risk matrix and operating map
* Direct linkage between failure patterns and maintenance actions

---

## Tools

SQL, Tableau Public, Data Analysis

---

## Repository Contents

* SQL scripts for data preparation
* Dashboard documentation
