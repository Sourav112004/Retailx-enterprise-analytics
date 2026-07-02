
# Data Quality Report

## RetailX Enterprise Analytics

### Objective

Before performing business analysis, a comprehensive data quality assessment was conducted to evaluate the integrity, completeness, and consistency of the Olist Brazilian E-Commerce dataset.

---

# Dataset Overview

| Table | Records |
|---------|---------:|
| customers | 99,441 |
| orders | 99,441 |
| order_items | 112,650 |
| products | 32,951 |
| sellers | 3,095 |
| payments | 103,886 |
| reviews | 99,224 |

---

# Data Quality Checks Performed

## 1. Record Count Validation

Objective

- Verify that all CSV files were imported successfully.

Status

- Completed

Result

- All record counts matched the source dataset.

---

## 2. Primary Key Validation

Validated uniqueness of primary keys.

Tables Checked

- Customers
- Orders
- Products
- Sellers
- Order Items (Composite Key)
- Payments (Composite Key)
- Reviews (Composite Key)

Result

- No duplicate primary keys found.

---

## 3. NULL Value Analysis

Analyzed nullable columns across the database.

Tables

### Orders

- order_approved_at
- order_delivered_carrier_date
- order_delivered_customer_date

### Products

- product_category_name
- product_name_length
- product_description_length
- product_photos_qty
- product_weight_g
- product_length_cm
- product_height_cm
- product_width_cm

### Reviews

- review_comment_title
- review_comment_message

Result

- NULL values exist only in expected nullable columns.
- Missing values were retained because they represent valid business scenarios.

---

## 4. Referential Integrity Validation

Validated all foreign key relationships.

Relationships Checked

- Customers → Orders
- Orders → Order Items
- Orders → Payments
- Orders → Reviews
- Products → Order Items
- Sellers → Order Items

Result

- No orphan records detected.

---

## 5. Revenue Validation

Validated revenue-related columns.

Metrics

- Total Product Revenue
- Total Freight Revenue
- Gross Revenue

Purpose

- Confirm revenue fields before business analysis.

Status

- Completed

---

# Data Quality Summary

| Validation | Status |
|------------|--------|
| Record Count Validation | Completed |
| Duplicate Check | Completed |
| NULL Analysis | Completed |
| Referential Integrity | Completed |
| Revenue Validation | Completed |

---

# Conclusion

The dataset successfully passed all major data quality validation checks.

The database is suitable for:

- Business Analysis
- KPI Development
- Power BI Dashboards
- Advanced SQL Analytics
