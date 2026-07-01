# Sprint 3 Progress – Data Validation

## Overview

Completed the first phase of SQL Business Analysis by validating the integrity and quality of the RetailX database before performing business analytics.

---

## Completed Tasks

### Record Count Validation
- Verified imported row counts across all tables.
- Confirmed successful data import against the original Olist dataset.

---

### Primary Key Validation
Validated uniqueness of primary keys across all entities.

Tables validated:
- Customers
- Orders
- Order Items (Composite Key)
- Payments (Composite Key)
- Products
- Reviews (Composite Key)
- Sellers

Result:
- No duplicate primary keys found.

---

### NULL Value Analysis

Performed NULL analysis on all nullable columns.

Tables analyzed:
- Orders
- Products
- Reviews

Key Findings:
- Missing values exist only in expected nullable columns.
- Product metadata contains missing descriptive attributes.
- Review comments are optional and contain legitimate NULL values.
- Delivery-related timestamps are NULL for orders that were not delivered.

---

### Referential Integrity Validation

Validated all foreign key relationships using LEFT JOIN integrity checks.

Relationships validated:
- Orders → Customers
- Order Items → Orders
- Order Items → Products
- Order Items → Sellers
- Payments → Orders
- Reviews → Orders

Result:
- No orphan records detected.
- All foreign key relationships are valid.

---

## SQL Concepts Practiced

- Aggregate Functions
- COUNT()
- SUM()
- CASE WHEN
- NULL Handling
- LEFT JOIN
- Foreign Key Validation
- Composite Primary Keys
- Business Data Validation

---

## Business KPIs Introduced

Implemented SQL logic for calculating business metrics using conditional aggregation.

Examples:
- 5-Star Review Percentage
- Delivered Order Percentage

Concepts learned:
- Conditional Aggregation using SUM(CASE WHEN ...)
- Percentage KPI Calculation
- Business Metric Validation

---

## Key Learning Outcomes

- Difference between COUNT(*) and COUNT(column)
- Counting NULL values efficiently
- Conditional aggregation with CASE statements
- Understanding parent-child relationships in relational databases
- Referential integrity validation
- Business-first approach to SQL problem solving
- Translating business questions into SQL queries

---

## Current Project Status

| Module | Status |
|---------|--------|
| Database Schema Design | Completed |
| Relational Modeling | Completed |
| Data Profiling | Completed |
| Data Import | Completed |
| Data Validation | Completed |
| Data Cleaning | In Progress |
| SQL Business Analysis | In Progress |
| Power BI Dashboard | Pending |

---

## Next Sprint

Module 2 – Sales Analysis

Upcoming topics:
- Total Revenue
- Average Order Value (AOV)
- Monthly Sales Trends
- Product Category Analysis
- Seller Performance
- Customer Analytics
