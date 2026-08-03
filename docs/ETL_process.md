# 🔄 ETL Process

## Overview

The RetailX project follows a structured ETL (Extract, Transform, Load) pipeline to convert raw e-commerce data into business-ready analytics used for SQL analysis and Power BI dashboards.

```
Raw CSV Files
        │
        ▼
Extract (Python)
        │
        ▼
Data Cleaning & Validation
        │
        ▼
Load into MySQL Database
        │
        ▼
SQL Transformations
(CTEs, Views, Window Functions)
        │
        ▼
Business Analytics Views
        │
        ▼
Power BI Dashboard
```

---

# 1️⃣ Extract

### Data Source

- Olist Brazilian E-Commerce Dataset
- Format: CSV
- Records: ~100,000+ Orders
- Multiple relational tables

### Extracted Files

- customers.csv
- orders.csv
- order_items.csv
- products.csv
- sellers.csv
- order_payments.csv
- order_reviews.csv
- geolocation.csv
- product_category_translation.csv

Python (Pandas) was used to read and inspect the raw datasets before loading them into MySQL.

---

# 2️⃣ Transform

The transformation phase focused on improving data quality and preparing the data for business analysis.

## Data Quality Checks

- Removed duplicate records
- Standardized column names
- Converted date columns to proper datetime format
- Validated primary and foreign keys
- Checked for missing values
- Corrected inconsistent data types

---

## Business Transformations (SQL)

Business logic was implemented using SQL Views instead of Power BI calculations.

Key SQL techniques used:

- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- CASE Statements
- Ranking Functions
- Date Calculations

---

## Analytics Views Created

### Executive Overview

- Monthly Business Performance
- Revenue KPIs
- State-wise Revenue

---

### Sales & Product Analytics

- Product Performance
- Revenue Contribution
- Seller Performance
- Repeat Purchase Analysis

---

### Customer Insights

- Customer Lifetime Value (CLV)
- Customer Retention
- Monthly Retention Rate

---

### Logistics & Delivery

- Delivery Performance
- Late Delivery Analysis
- State-wise Delivery Metrics

---

# 3️⃣ Load

After transformation, cleaned and modeled data was loaded into:

**MySQL**

The database became the single source of truth for all reporting.

Power BI connects directly to SQL Views, ensuring that business logic remains centralized inside the database.

---

# Data Flow

```
CSV Files
    │
    ▼
Python (Pandas)
    │
    ▼
Data Cleaning
    │
    ▼
MySQL Tables
    │
    ▼
SQL Views
    │
    ▼
Power BI
```

---

# Tools Used

| Stage | Tool |
|--------|------|
| Extract | Python (Pandas) |
| Transform | MySQL |
| Load | MySQL |
| Visualization | Power BI |

---

# Key Design Decisions

- Business logic was implemented in SQL Views instead of DAX.
- Power BI was used primarily for visualization.
- SQL Views were designed to answer specific business questions.
- A star schema was used to improve reporting performance.
- Transformations were reusable and modular through separate SQL views.

---

# Outcome

The ETL pipeline transformed raw transactional data into an analytics-ready data model capable of supporting:

- Executive Reporting
- Sales Analytics
- Customer Insights
- Logistics Performance Analysis

The result is a scalable, maintainable, and business-focused analytics solution that separates data engineering, business logic, and visualization into independent layers.
