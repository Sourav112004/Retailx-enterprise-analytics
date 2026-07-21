
CREATE VIEW vw_customer_ltv AS

SELECT

    c.customer_unique_id,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(SUM(oi.price),2) AS total_revenue,

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

GROUP BY
    c.customer_unique_id;
