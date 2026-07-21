

CREATE VIEW vw_monthly_business_performance AS

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,

    ROUND(SUM(oi.price),2) AS revenue,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,

    ROUND(
        SUM(oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m');
