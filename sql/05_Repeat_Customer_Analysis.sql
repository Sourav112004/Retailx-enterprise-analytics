/*
==========================================================
RetailX Enterprise Analytics
Sprint 3 - Case 05: Repeat Customer Analysis
Author : Sourav Prakash
==========================================================

Business Objective:
Analyze customer purchasing behavior to measure customer
retention, identify repeat customers, and understand
their purchasing patterns.

==========================================================
*/

USE retailx;

/*=========================================================
1. Repeat Customer Rate
=========================================================*/

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN orders >= 2 THEN 1 END) AS repeat_customers,
    ROUND(
        COUNT(CASE WHEN orders >= 2 THEN 1 END) * 100.0
        / COUNT(*),
        2
    ) AS repeat_customer_rate
FROM customer_orders;


/*=========================================================
2. Order Distribution Among Repeat Customers

Business Question:
How many orders do repeat customers typically place?
=========================================================*/

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    orders,
    COUNT(*) AS customer_count
FROM customer_orders
WHERE orders >= 2
GROUP BY orders
ORDER BY orders;


/*=========================================================
3. Product Categories Purchased by Repeat Customers

Business Question:
Which product categories are most frequently purchased
by repeat customers?
=========================================================*/

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    COALESCE(NULLIF(p.product_category_name, ''), 'Unknown') AS product_category,
    COUNT(*) AS total_purchases
FROM customer_orders co
JOIN customers c
    ON co.customer_unique_id = c.customer_unique_id
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE co.orders >= 2
GROUP BY product_category
ORDER BY total_purchases DESC;


/*=========================================================
4. Data Quality Check

Business Question:
Are there missing product categories affecting analysis?
=========================================================*/

-- NULL Product Categories

SELECT
    COUNT(*) AS null_categories
FROM products
WHERE product_category_name IS NULL;


-- Empty Product Categories

SELECT
    COUNT(*) AS empty_categories
FROM products
WHERE product_category_name = '';

/*
==========================================================
Key Findings

• Repeat Customer Rate : 3.12%
• Total Customers : 96,096
• Repeat Customers : 2,997
• Most repeat customers placed exactly two orders.
• 610 products contained empty category names.
• Missing category values should be standardized before
  dashboard development.

Business Recommendations

• Introduce loyalty and rewards programs.
• Target one-time customers with personalized offers.
• Improve retention beyond the second purchase.
• Focus marketing on categories popular among repeat customers.
• Resolve missing product category values for cleaner reporting.

==========================================================
*/
