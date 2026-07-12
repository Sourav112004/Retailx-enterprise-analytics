# Sprint 3 Progress Update – Case 05: Repeat Customer Analysis

## Overview

In this sprint, I analyzed customer purchasing behavior to evaluate customer retention and identify repeat buying patterns. The analysis focused on measuring customer loyalty, understanding repeat purchase frequency, and exploring the purchasing behavior of repeat customers.

---

## Business Objective

- Measure the Repeat Customer Rate.
- Identify how frequently repeat customers place orders.
- Analyze product categories purchased by repeat customers.
- Investigate data quality issues affecting category-level analysis.

---

## Key Business Questions

### 1. What percentage of customers are repeat customers?

**Result**

- Total Customers: **96,096**
- Repeat Customers (2+ Orders): **2,997**
- Repeat Customer Rate: **3.12%**

**Insight**

Only **3.12%** of customers made more than one purchase, indicating low customer retention and highlighting an opportunity to improve customer loyalty through retention strategies.

---

### 2. How many orders do repeat customers typically place?

| Orders | Customers |
|-------:|----------:|
| 2 | 2,745 |
| 3 | 203 |
| 4 | 30 |
| 5 | 8 |
| 6 | 6 |
| 7 | 3 |
| 9 | 1 |
| 17 | 1 |

**Insight**

The majority of repeat customers placed exactly **two orders**, while only a small number continued making additional purchases. This suggests customers are willing to return once but long-term retention remains limited.

---

### 3. Which product categories are purchased by repeat customers?

Performed a drill-down analysis by:

- Identifying repeat customers using a Common Table Expression (CTE).
- Joining customer, order, order item, and product tables.
- Analyzing product categories purchased by repeat customers.

This analysis helps identify categories associated with returning customers and provides insights for targeted marketing campaigns.

---

### 4. Data Quality Investigation

During category analysis, an empty product category appeared.

Further investigation revealed:

- **NULL categories:** 0
- **Empty string categories:** 610 products

**Recommendation**

Replace empty category values with **"Unknown"** in the cleaned dataset or during reporting to improve dashboard readability and reporting accuracy.

---

## SQL Concepts Applied

- Common Table Expressions (CTEs)
- Conditional Aggregation (`COUNT(CASE WHEN...)`)
- Multi-stage Aggregation
- Table Grain Analysis
- Multi-table Joins
- Business KPI Calculation
- Drill-down Analysis
- Data Quality Validation

---

## Business Recommendations

- Implement customer loyalty and rewards programs to increase repeat purchases.
- Target one-time customers with personalized promotions after their first purchase.
- Investigate barriers preventing customers from making a third or subsequent purchase.
- Focus marketing efforts on product categories frequently purchased by repeat customers.
- Improve data quality by standardizing missing product category values.

---

## Sprint Outcome

This sprint strengthened my understanding of customer retention analytics by moving beyond KPI calculation to performing drill-down analysis, validating data quality, and translating SQL outputs into actionable business insights.
