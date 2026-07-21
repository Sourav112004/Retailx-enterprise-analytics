
CREATE VIEW vw_customer_retention AS

WITH customer_month AS
(
    SELECT
        c.customer_unique_id AS customer,
        DATE_FORMAT(
            o.order_purchase_timestamp,
            '%Y-%m-01'
        ) AS order_month

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    GROUP BY
        c.customer_unique_id,
        order_month
),

customer_retention AS
(
    SELECT

        customer,

        order_month,

        LAG(order_month)
        OVER(
            PARTITION BY customer
            ORDER BY order_month
        ) AS previous_order_month

    FROM customer_month
),

retention_flag AS
(
    SELECT
        *,

        CASE

            WHEN previous_order_month =
            DATE_FORMAT(
                DATE_SUB(
                    STR_TO_DATE(order_month,'%Y-%m-%d'),
                    INTERVAL 1 MONTH
                ),
                '%Y-%m-01'
            )

            THEN 1

            ELSE 0

        END AS retention

    FROM customer_retention
),

monthly_retention AS
(
    SELECT

        order_month,

        COUNT(DISTINCT customer) AS active_customers,

        SUM(retention) AS retained_customers

    FROM retention_flag

    GROUP BY
        order_month
),

retention_rate_cte AS
(
    SELECT

        *,

        LAG(active_customers)
        OVER(
            ORDER BY order_month
        ) AS previous_month_active_customers

    FROM monthly_retention
)

SELECT

    order_month,

    active_customers,

    retained_customers,

    previous_month_active_customers,

    ROUND(
        retained_customers * 100.0 /
        previous_month_active_customers,
        2
    ) AS retention_rate

FROM retention_rate_cte;
