
/*
===============================================================================
Business Case 3: Monthly Average Order Value (AOV)
===============================================================================

Business Question:
How has the Average Order Value (AOV) changed month-over-month?

Business Objective:
Analyze monthly Average Order Value to understand customer purchasing
behavior and investigate the factors contributing to unusually low AOV.

Analytical Process:
Business Question
        ↓
Business Objective
        ↓
Identify Grain
        ↓
Identify Metric
        ↓
Write SQL
        ↓
Interpret Results
        ↓
Ask "Why?"
        ↓
Root Cause Investigation
        ↓
Business Recommendation

===============================================================================
*/


/*
===============================================================================
Step 1: Calculate Monthly Average Order Value (AOV)
Business Question:
How has Average Order Value changed month-over-month?
===============================================================================
*/

SELECT
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id),2) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month;


/*
===============================================================================
Root Cause Investigation
Observation:
September 2016 recorded the lowest AOV.

Hypothesis 1:
Were lower-priced products responsible for the low AOV?
===============================================================================
*/

SELECT
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month,
    ROUND(AVG(oi.price),2) AS average_product_price
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY order_month
HAVING order_month = '2016-09';


/*
===============================================================================
Hypothesis 2:
Which product categories were purchased during September 2016?
===============================================================================
*/

SELECT
    p.product_category_name,
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') = '2016-09';


/*
===============================================================================
Hypothesis 3:
What were the average prices of the product categories purchased
during September 2016?
===============================================================================
*/

SELECT
    p.product_category_name,
    ROUND(AVG(oi.price),2) AS average_price,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE p.product_category_name IN (
    'moveis_decoracao',
    'beleza_saude',
    'telefonia'
)
AND DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') = '2016-09'
GROUP BY p.product_category_name
ORDER BY average_price;


/*
===============================================================================
Hypothesis 4:
Were customers purchasing fewer items per order?
===============================================================================
*/

SELECT
    o.order_id,
    COUNT(oi.order_item_id) AS items_in_order,
    ROUND(SUM(oi.price),2) AS order_value,
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    order_month
HAVING order_month = '2016-09'
ORDER BY order_value DESC;


/*
===============================================================================
Business Insight

Findings:
- September 2016 recorded the lowest Monthly Average Order Value.
- Only four customer orders were recorded during the month.
- Purchased products belonged primarily to relatively low-priced categories.
- Average product prices ranged approximately between ₹36 and ₹60.
- Order-level investigation showed no strong evidence that customers
  consistently purchased fewer items per order.
- The low AOV appears to be primarily influenced by a very small order
  volume together with relatively inexpensive products.

Business Recommendation:
- Validate whether September 2016 represents a complete reporting period.
- Promote higher-value product categories to improve AOV.
- Implement cross-selling and product bundling strategies.
- Continue monitoring Monthly Revenue, Monthly Orders and AOV together.
- Conduct deeper customer-level analysis for future investigations.

===============================================================================
*/
