

# Business Case Studies

| Case | Business Question | Status |
|------|-------------------|--------|
| 1 | Monthly Revenue Trend | ✅ |
| 2 | Monthly Order Trend | ✅ |
| 3 | Monthly Average Order Value | ✅ |
| 4 | Customer Lifetime Value | ✅ |
| 5 | Repeat Customer Analysis | ✅ |
| 6 | Seller Performance | ✅ |
| 7 | Product Category Performance | ⏳ |
| 8 | Customer Retention | ⏳ |
| 9 | Regional Sales Analysis | ⏳ |
| 10 | Executive Business Dashboard | ⏳ |

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

---

# Business Case 3 – Monthly Average Order Value (AOV)

## Business Question

How has the Average Order Value (AOV) changed month-over-month?

---

## Business Objective

Analyze monthly Average Order Value to understand customer purchasing behavior and identify factors influencing changes in order value over time.

---

## Analytical Thinking Process

```text
Business Question
        ↓
Understand the Business Objective
        ↓
Identify the Grain
        ↓
Identify the Metric
        ↓
Select the Required Tables
        ↓
Write SQL
        ↓
Interpret Results
        ↓
Ask "Why?"
        ↓
Investigate Root Cause
        ↓
Provide Business Recommendation
```

---

## SQL Techniques Used

- SUM()
- COUNT(DISTINCT)
- DATE_FORMAT()
- GROUP BY
- ORDER BY
- INNER JOIN
- AVG()
- HAVING
- Aggregate Functions

---

## Key Finding

September 2016 recorded the lowest Average Order Value (AOV) of **₹89.12**.

---

# Root Cause Investigation

## Investigation 1

### Question

Were lower-priced products responsible for the decline in AOV?

### SQL Investigation

Calculated the average selling price of products purchased each month.

### Finding

September 2016 contained relatively inexpensive products compared to other months, supporting the hypothesis that lower-priced products contributed to the reduced AOV.

---

## Investigation 2

### Question

Which product categories were purchased during September 2016?

### SQL Investigation

Identified all product categories sold during the month.

### Finding

The month primarily consisted of purchases from the following categories:

- beleza_saude
- moveis_decoracao
- telefonia

These categories exhibited relatively low average selling prices.

---

## Investigation 3

### Question

What was the average selling price for each product category?

### SQL Investigation

Calculated:

- Average Product Price
- Number of Orders

for each product category.

### Finding

| Product Category | Average Price | Orders |
|------------------|--------------:|-------:|
| moveis_decoracao | ₹36.45 | 2 |
| beleza_saude | ₹44.90 | 3 |
| telefonia | ₹59.50 | 1 |

The purchased categories consisted primarily of lower-priced products.

---

## Investigation 4

### Question

Did customers purchase fewer items per order?

### SQL Investigation

Created an order-level summary containing:

- Order ID
- Items per Order
- Order Value

### Finding

| Items in Order | Observation |
|---------------:|------------|
| 2 | Moderate basket size |
| 3 | Highest order value |
| 1 | Single-item purchase |

The analysis did not provide sufficient evidence to conclude that customers consistently purchased fewer items per order.

Instead, the lower AOV appears to be influenced primarily by lower-priced products combined with a very small number of orders.

---

## Investigation 5

### Question

Could the low AOV be explained by sample size?

### Finding

September 2016 contained only **4 recorded orders**, making it the smallest monthly sample in the dataset.

A small sample size can significantly influence KPI values and should be considered before drawing broader business conclusions.

---

# Business Insight

The unusually low Average Order Value during September 2016 appears to be driven by a combination of:

- Very small monthly order volume.
- Relatively inexpensive product categories.
- Low average selling prices.

The available data does not provide sufficient evidence to conclude that customers consistently purchased fewer items per order.

---

# Business Recommendation

1. Validate whether September 2016 represents a complete reporting period before making strategic business decisions, as the month contains a very small number of recorded orders.

2. Promote higher-value product categories through targeted merchandising strategies to improve Average Order Value (AOV).

3. Introduce cross-selling, upselling, or product bundling initiatives to encourage customers to increase the value of each order.

4. Monitor Monthly Revenue, Monthly Orders, and Average Order Value together to determine whether the September decline is an isolated event or part of a recurring seasonal trend.

5. Conduct additional customer and product-level analysis to identify purchasing patterns that contribute to lower order values and develop targeted business strategies based on those findings.

---

# Questions Raised

This investigation generated several additional business questions for future analysis:

- Which customers consistently generate the highest Average Order Value?
- Which product categories contribute most to monthly revenue?
- Which sellers consistently sell higher-value products?
- Do specific customer segments purchase higher-value products?
- Does Average Order Value vary significantly across different regions?
- Are there seasonal purchasing patterns affecting Average Order Value?

---

# SQL Skills Demonstrated

- Business KPI Analysis
- Average Order Value Calculation
- Root Cause Investigation
- Multi-Table Joins
- Aggregate Functions
- Conditional Business Analysis
- Product Category Analysis
- Order-Level Analysis
- Analytical Problem Solving
- Business Recommendation Development

---

# Business Impact

This case study demonstrates that KPI analysis extends beyond calculating a metric.

Rather than stopping after identifying a low Average Order Value, multiple hypotheses were developed and validated through SQL-based investigations. Product pricing, product categories, order composition, and sample size were examined before arriving at an evidence-based conclusion.

# Business Case 4 – Customer Lifetime Value Analysis

## Business Question

Which customers generate the highest lifetime value for the business, and what purchasing patterns distinguish them?

---

## Business Objective

Identify high-value customers by analyzing lifetime revenue, purchase frequency and Average Order Value (AOV) to support customer retention and marketing strategies.

---

## SQL Techniques Used

- INNER JOIN
- SUM()
- COUNT(DISTINCT)
- GROUP BY
- ORDER BY
- Aggregate Functions
- Customer Segmentation

---

## Key Findings

- High-value customers generated significantly higher lifetime revenue.
- Many customers placed only a single order throughout their lifetime.
- Customers with the highest AOV were not necessarily those with the highest lifetime revenue.
- Lifetime Revenue, Purchase Frequency and AOV each provide different business perspectives and should be analyzed together.

---

## Business Insight

Customer value cannot be measured using a single KPI.

Revenue identifies the highest-value customers.

Order Frequency identifies the most loyal customers.

Average Order Value identifies customers who spend the most per purchase.

Analyzing these metrics together provides a more complete understanding of customer behavior.

---

## Business Recommendation

- Reward high-value customers through loyalty programs.
- Increase repeat purchases using personalized retention campaigns.
- Target customers with high AOV but low purchase frequency.
- Monitor Customer Lifetime Value regularly as a key business KPI.

This structured approach transforms descriptive reporting into business-focused analysis, enabling stakeholders to understand not only **what happened**, but also the likely factors behind the observed results and the actions that should be considered.


