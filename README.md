
# Machine Failure & Maintenance Risk Analysis

## Overview

This project analyzes industrial machine sensor data to identify failure patterns and enable **risk-based maintenance decisions**.
The workflow integrates **SQL-driven data preparation** with a **Tableau dashboard** to detect high-risk operating conditions and prioritize machine inspection.

---

## Dataset

| Attribute | Description                                                                                                                                                          |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Source    | UCI Machine Learning Repository                                                                                                                                      |
| Dataset   | AI4I 2020 Predictive Maintenance                                                                                                                                     |
| Records   | ~10,000                                                                                                                                                              |
| Link      | [https://archive.ics.uci.edu/ml/datasets/AI4I+2020+Predictive+Maintenance+Dataset](https://archive.ics.uci.edu/ml/datasets/AI4I+2020+Predictive+Maintenance+Dataset) |

### Key Variables

| Category    | Fields                                                |
| ----------- | ----------------------------------------------------- |
| Operational | Tool Wear, Torque, Rotational Speed                   |
| Thermal     | Air Temperature, Process Temperature, Temp Difference |
| Status      | Machine Status (Normal / Failed), Failure Types       |
| Identifier  | UID (unique machine ID)                               |

---

## Objective

* Identify conditions leading to machine failure
* Segment operational risk using key parameters
* Quantify failure probability across operating zones
* Rank machines based on risk for targeted maintenance

---

## Data Preparation (SQL)

Data was transformed into an analytics-ready layer using structured SQL pipelines.

### Key Transformations

* Duplicate removal and null handling
* Standardization of categorical fields
* Feature engineering:

  * **Wear Zones** (Low / Medium / High)
  * **Torque Buckets** (Low / Medium / High)
  * **Temperature Difference & Zones**
* Risk modeling:

  * **Risk Score (0–100 scale)**
  * **Risk Level (Low / Medium / High)**

### SQL Techniques Used

| Category         | Functions                  |
| ---------------- | -------------------------- |
| Aggregation      | COUNT(), AVG(), SUM()      |
| Logic            | CASE WHEN                  |
| Window Functions | ROW_NUMBER(), DENSE_RANK() |
| Cleaning         | TRIM(), COALESCE(), CAST() |
| Grouping         | GROUP BY, HAVING           |

---

## Tableau Dashboard

🔗 **Live Dashboard**
[https://public.tableau.com/views/PredictiveMaintenanceandRiskInsight/PredictiveMaintenanceDashboard](https://public.tableau.com/views/PredictiveMaintenanceandRiskInsight/PredictiveMaintenanceDashboard)

---

### KPI Summary

| Metric         | Value    |
| -------------- | -------- |
| Failure Rate   | 3.4%     |
| Total Failures | 339      |
| Total Records  | 10,000   |
| Avg Torque     | 39.99 Nm |
| Avg Tool Wear  | 108.0    |

---

### Dashboard Components

| Component                   | Purpose                                 |
| --------------------------- | --------------------------------------- |
| **KPI Panel**               | High-level system health overview       |
| **Risk Matrix (Heatmap)**   | Failure rate across Wear × Torque zones |
| **Operating Map (Scatter)** | Distribution of machine behavior        |
| **Maintenance Actions**     | Risk-based action mapping               |
| **Top Risk Machines**       | Ranked list of highest-risk machines    |

---

## Key Insights

* Failure rate peaks in **High Wear + High Torque** zone (~13%+)
* Failures cluster strongly when **Tool Wear > 180**
* Risk is **multi-factor driven**, not dependent on a single variable
* Temperature difference contributes to **risk escalation patterns**
* Majority of machines operate in low-risk zones, but failures are **highly concentrated**

---

## Industrial Use Case (Quality / Maintenance Engineering)

This dashboard directly supports real shop-floor decision making:

* **Prioritization**
  Instead of monitoring all machines equally, engineers can focus on **high-risk zones and machines**

* **Targeted Inspection**
  The **Top Risk Machines panel** identifies specific machines needing immediate attention

* **Early Failure Detection**
  Combined analysis of wear, torque, and temperature enables detection of **pre-failure conditions**

* **Maintenance Optimization**
  Supports shift from reactive maintenance to **predictive, condition-based intervention**

* **Resource Efficiency**
  Helps allocate inspection and maintenance resources to **maximum-risk areas**

---

## Outcome

* Translates raw sensor data into actionable maintenance insights
* Enables **risk-based decision making** in industrial environments
* Improves maintenance efficiency and reduces unexpected downtime

---

## Tools & Technologies

| Tool          | Usage                                              |
| ------------- | -------------------------------------------------- |
| SQL           | Data cleaning, transformation, feature engineering |
| Tableau       | Dashboard visualization and interaction            |
| Data Analysis | Risk modeling and segmentation                     |



