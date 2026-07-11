/*
===============================================================================
Business Case 4: Customer Lifetime Value Analysis
===============================================================================

Business Question:
Which customers generate the highest lifetime value for the business,
and what purchasing patterns distinguish them?

Business Objective:
Identify high-value customers by analyzing their lifetime revenue,
purchase frequency and Average Order Value (AOV) to support customer
retention and marketing strategies.

Analytical Thinking Process

Business Question
        ↓
Understand Business Objective
        ↓
Identify Grain
        ↓
Identify Metrics
        ↓
Select Required Tables
        ↓
Write SQL
        ↓
Interpret Results
        ↓
Ask "Why?"
        ↓
Investigate Purchasing Patterns
        ↓
Business Recommendation

===============================================================================
*/


/*
===============================================================================
Step 1
Calculate Customer Lifetime Revenue
===============================================================================
*/

SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.price),2) AS revenue,
    ROUND(
        SUM(oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY revenue DESC
LIMIT 10;


/*
===============================================================================
Root Cause Investigation

Observation:
Identify customers with the lowest lifetime revenue.
===============================================================================
*/

SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.price),2) AS revenue,
    ROUND(
        SUM(oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value,
    p.product_category_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_unique_id,
    p.product_category_name
ORDER BY revenue ASC
LIMIT 5;


/*
===============================================================================
Business Insight

High-value customers typically exhibit:

• Higher lifetime revenue
• Multiple completed orders
• Strong purchasing consistency

Low-value customers were primarily one-time purchasers with
minimal spending across relatively inexpensive product categories.

This indicates that customer retention and increasing repeat
purchases may generate greater long-term business value than
focusing solely on acquiring new customers.

===============================================================================
*/


/*
===============================================================================
Business Recommendation

1. Identify and reward high-value customers through loyalty programs.

2. Create personalized campaigns for customers with high AOV
   but low purchase frequency.

3. Encourage repeat purchases through retention campaigns.

4. Segment customers by Lifetime Revenue, Orders and AOV
   instead of using revenue alone.

5. Monitor customer lifetime value regularly to identify
   customers at risk of churning.

===============================================================================
*/
