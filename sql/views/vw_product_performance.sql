

CREATE VIEW vw_product_performance AS

WITH category_metrics AS
(
    SELECT
        p.product_category_name,
        ROUND(SUM(oi.price),2) AS revenue,
        COUNT(DISTINCT oi.order_id) AS orders,
        ROUND(
            SUM(oi.price) /
            COUNT(DISTINCT oi.order_id),
            2
        ) AS average_selling_price

    FROM products p

    JOIN order_items oi
        ON p.product_id = oi.product_id

    GROUP BY
        p.product_category_name
),

customer_category_orders AS
(
    SELECT
        c.customer_unique_id,
        p.product_category_name,
        COUNT(DISTINCT o.order_id) AS order_count

    FROM orders o

    JOIN customers c
        ON o.customer_id = c.customer_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    JOIN products p
        ON oi.product_id = p.product_id

    GROUP BY
        c.customer_unique_id,
        p.product_category_name
),

category_repeat_metrics AS
(
    SELECT

        product_category_name,

        COUNT(*) AS total_customers,

        SUM(
            CASE
                WHEN order_count >= 2 THEN 1
                ELSE 0
            END
        ) AS repeat_customers,

        ROUND(
            SUM(
                CASE
                    WHEN order_count >= 2 THEN 1
                    ELSE 0
                END
            ) * 100.0 /
            COUNT(*),
            2
        ) AS repeat_purchase_rate

    FROM customer_category_orders

    GROUP BY
        product_category_name
)

SELECT

    cm.product_category_name,

    cm.revenue,

    cm.orders,

    cm.average_selling_price,

    ROUND(
        cm.revenue * 100.0 /
        SUM(cm.revenue) OVER(),
        2
    ) AS revenue_contribution,

    DENSE_RANK() OVER(
        ORDER BY cm.revenue DESC
    ) AS revenue_rank,

    crm.total_customers,

    crm.repeat_customers,

    crm.repeat_purchase_rate

FROM category_metrics cm

JOIN category_repeat_metrics crm
    ON cm.product_category_name = crm.product_category_name;
