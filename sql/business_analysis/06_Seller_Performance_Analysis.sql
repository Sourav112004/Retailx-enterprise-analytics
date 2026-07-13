/*
====================================================================
RetailX Enterprise Analytics
Case 06 - Seller Performance Analysis

Author : Sourav Prakash

Objective:
Evaluate seller performance by analyzing revenue, sales volume,
average selling price, and revenue contribution to identify
high-performing and low-performing sellers.

====================================================================
*/

USE retailx;

-- ================================================================
-- Business Question 1
-- Which sellers generate the highest revenue?
-- ================================================================

SELECT
    seller_id,
    ROUND(SUM(price),2) AS revenue,
    COUNT(DISTINCT order_id) AS order_count
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 10;


-- ================================================================
-- Business Question 2
-- Which sellers generate the lowest revenue?
-- ================================================================

SELECT
    seller_id,
    ROUND(SUM(price),2) AS revenue,
    COUNT(DISTINCT order_id) AS order_count
FROM order_items
GROUP BY seller_id
ORDER BY revenue
LIMIT 10;


-- ================================================================
-- Business Question 3
-- Which product categories are sold by the lowest-performing sellers?
-- ================================================================

WITH low_performing_sellers AS
(
SELECT
    seller_id,
    SUM(price) AS revenue,
    COUNT(DISTINCT order_id) AS order_count
FROM order_items
GROUP BY seller_id
ORDER BY revenue
LIMIT 10
)

SELECT
    lps.seller_id,
    ROUND(lps.revenue,2) AS revenue,
    lps.order_count,
    COALESCE(NULLIF(p.product_category_name,''),'Unknown') AS product_category
FROM low_performing_sellers lps
JOIN order_items oi
    ON lps.seller_id = oi.seller_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    lps.seller_id,
    lps.revenue,
    lps.order_count,
    product_category
ORDER BY revenue;


-- ================================================================
-- Business Question 4
-- Average Selling Price (ASP) by Seller
-- ================================================================

SELECT
    seller_id,
    ROUND(SUM(price),2) AS revenue,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(price)/COUNT(DISTINCT order_id),2) AS average_selling_price
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC;


-- ================================================================
-- Business Question 5
-- Revenue Contribution Analysis (Top 10 Sellers)
-- ================================================================

WITH seller_revenue AS
(
SELECT
    seller_id,
    ROUND(SUM(price),2) AS revenue,
    COUNT(DISTINCT order_id) AS order_count
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 10
)

SELECT
    seller_id,
    revenue,
    order_count,

    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS revenue_rank,

    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS revenue_contribution,

    ROUND(
        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ),
        2
    ) AS cumulative_revenue

FROM seller_revenue;


-- ================================================================
-- Business Insights
-- ================================================================

/*

1. Identify the marketplace's highest revenue-generating sellers.

2. Compare seller revenue with order volume to determine whether
   performance is driven by pricing or sales volume.

3. Analyze product categories associated with low-performing sellers.

4. Calculate Average Selling Price (ASP) to distinguish premium
   sellers from high-volume sellers.

5. Measure revenue contribution among the Top 10 sellers using
   window functions.

6. Calculate cumulative revenue to support Pareto (80/20) analysis
   and understand revenue concentration.

Key SQL Concepts Used

• Aggregate Functions
• Common Table Expressions (CTEs)
• Window Functions
• DENSE_RANK()
• SUM() OVER()
• Running Totals
• Revenue Contribution Analysis
• Drill-down Analysis
• Data Quality Handling using COALESCE() and NULLIF()

*/
