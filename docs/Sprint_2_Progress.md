
# Sprint 2 Progress Report

## Overview

Sprint 2 focused on improving data quality and ensuring the RetailX database was reliable for business analysis. The objective was to validate relationships between tables, enforce referential integrity, and perform comprehensive data quality checks before beginning advanced analytical case studies.

---

# Completed Tasks

## Referential Integrity Validation

### Objective

Verify that all relationships between RetailX tables were valid and identify any missing or orphan records.

### SQL Concepts Used

- LEFT JOIN
- INNER JOIN
- IS NULL
- COUNT()
- Aggregate Functions

### Validation Performed

- Customers ↔ Orders
- Orders ↔ Order Items
- Products ↔ Order Items
- Sellers ↔ Order Items
- Orders ↔ Payments
- Orders ↔ Reviews

### Key Findings

- Verified referential integrity across all major tables.
- Confirmed there were no orphan records affecting analysis.
- Ensured all foreign key relationships were consistent.

---

## Data Quality Assessment

### Objective

Assess the completeness and consistency of the RetailX dataset.

### SQL Concepts Used

- COUNT()
- DISTINCT
- GROUP BY
- Aggregate Functions

### Validation Performed

- Checked for NULL values
- Verified duplicate records
- Validated primary keys
- Validated foreign keys
- Checked row counts across tables
- Confirmed successful data imports

### Key Findings

- Dataset passed all major quality checks.
- Tables were suitable for business analysis.
- Database integrity was successfully validated.

---

## Database Documentation

### Completed

- Documented database schema
- Created relationship diagrams
- Documented table purposes
- Recorded import process
- Added SQL setup scripts to GitHub

---

# Skills Strengthened

- Data Quality Assessment
- Referential Integrity Validation
- SQL JOINs
- Data Validation
- Database Documentation
- Relational Database Concepts
- MySQL

---

# Sprint Outcome

Sprint 2 established confidence in the RetailX database by validating relationships, checking data quality, and confirming referential integrity. This created a reliable foundation for the advanced business analyses completed in later sprints.
