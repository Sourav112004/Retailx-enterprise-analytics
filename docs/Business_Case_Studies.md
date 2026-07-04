# Business Case Studies

---

# Business Case 1 – Monthly Revenue Trend

## Business Question

How has monthly revenue changed over time?

## Business Objective

Analyze monthly sales performance to identify trends and seasonality.

## SQL Techniques Used

- INNER JOIN
- SUM()
- GROUP BY
- DATE_FORMAT()
- ORDER BY

## Key Finding

Revenue in December 2016 was only ₹10.90.

## Root Cause Investigation

### Investigation 1

Question:
How many orders were placed?

Finding:
Only one order existed in December 2016.

### Investigation 2

Question:
What was the Average Order Value?

Finding:
AOV = ₹10.90.

### Investigation 3

Question:
Which product category was purchased?

Finding:
fashion_bolsas_e_acessorios was the category

## Business Insight

The unusually low revenue was caused by only one recorded order rather than a widespread decline in customer demand.

## Recommendation

Treat December 2016 as a partial month when analyzing revenue trends.

---

# Business Case 2 – Monthly Order Trend

## Business Question

How has the number of customer orders changed month-over-month?

---

## Business Objective

Analyze monthly order volume to understand customer demand, identify seasonal trends, and detect unusual changes in purchasing activity over time.

---

## SQL Techniques Used

- COUNT()
- DATE_FORMAT()
- GROUP BY
- ORDER BY
- INNER JOIN
- CASE WHEN
- HAVING
- Aggregate Functions

---

## Key Finding

September 2016 recorded only **4 customer orders**, making it the month with the lowest order volume in the dataset.

---

# Root Cause Investigation

## Investigation 1

### Question

How many orders were placed during September 2016?

### Finding

Only **4 customer orders** were recorded during the month.

---

## Investigation 2

### Question

What were the statuses of those orders?

### SQL Investigation

Analyzed the `order_status` column for all September 2016 orders.

### Finding

| Order Status | Count |
|--------------|------:|
| Delivered | 1 |
| Shipped | 1 |
| Cancelled | 2 |

50% of all recorded orders were cancelled.

---

## Investigation 3

### Question

Can the shipped order provide additional business insight?

### SQL Investigation

Joined the following tables:

- Orders
- Customers
- Order Items
- Sellers
- Payments

Collected:

- Seller ID
- Customer ID
- Customer State
- Customer City
- Payment Method
- Estimated Delivery Date
- Delivered Customer Date

### Finding

The order was successfully paid using a **credit card**, confirming that payment processing had already been completed before shipment.

The order remained in the **Shipped** status and no delivery record was available in the dataset.

---

## Investigation 4

### Question

Can the exact reason for the undelivered shipment be determined?

### Finding

No.

The available dataset confirms that:

- Payment was completed.
- The order reached the shipping stage.
- No delivery record exists.

However, the dataset does not contain carrier tracking information or operational logistics data required to determine why the shipment was never recorded as delivered.

---

# Business Insight

The unusually low order volume during September 2016 appears to be influenced by:

- Very low overall order volume (4 orders)
- High cancellation rate (50%)
- One order remaining in the shipping stage

Although the shipment was successfully paid and dispatched, the available data is insufficient to determine why it was not delivered.

---

# Additional Operational Analysis

To move beyond investigating a single order, a seller performance report was created.

The report included:

- Total Orders
- Cancelled Orders
- Cancellation Rate (%)

Only sellers with a sufficiently large order volume should be evaluated to avoid misleading conclusions caused by very small sample sizes.

This analysis provides a more reliable way to identify sellers who consistently experience operational issues.

---

# Business Recommendation

- Investigate sellers with consistently high cancellation rates rather than isolated incidents.
- Review logistics records for shipped orders that remain undelivered.
- Compare seller performance only after applying a minimum order threshold to ensure statistically meaningful comparisons.
- Exclude incomplete or partial months when presenting monthly order trends to stakeholders.

---

# Questions Raised

This analysis generated several additional business questions for future investigation:

- Which sellers have the highest long-term cancellation rates?
- Which product categories experience the most cancellations?
- Are cancellations concentrated in specific states or cities?
- Do certain payment methods have higher cancellation rates?
- Are undelivered shipped orders concentrated among specific sellers?
- Does seller performance change over time?

---

# SQL Skills Demonstrated

- Business KPI Analysis
- Time-Series Analysis
- Root Cause Investigation
- Multi-Table Joins
- Conditional Aggregation using CASE WHEN
- Aggregate Functions
- HAVING Clause
- Business Performance Analysis
- Seller Performance KPI Development
- Analytical Problem Solving

---

## Business Impact

This analysis demonstrates that answering a business question extends beyond writing SQL queries.

Rather than stopping after identifying the month with the lowest number of orders, additional investigations were performed to understand the underlying factors contributing to the result.

By progressively exploring order status, payment information, customer details, seller information, and operational metrics, the analysis evolved from descriptive reporting into business-driven investigation, producing actionable recommendations for stakeholders.
