
CREATE VIEW vw_seller_performance AS

WITH seller_metrics AS
(
    SELECT
        s.seller_id,

        ROUND(SUM(oi.price),2) AS revenue,

        COUNT(DISTINCT oi.order_id) AS total_orders,

        COUNT(*) AS products_sold,

        ROUND(
            SUM(oi.price) /
            COUNT(DISTINCT oi.order_id),
            2
        ) AS average_selling_price

    FROM sellers s

    JOIN order_items oi
        ON s.seller_id = oi.seller_id

    GROUP BY
        s.seller_id
),

seller_cancellation AS
(
    SELECT

        oi.seller_id,

        ROUND(
            SUM(
                CASE
                    WHEN o.order_status='canceled'
                    THEN 1
                    ELSE 0
                END
            ) *100.0 /
            COUNT(o.order_id),
            2
        ) AS cancellation_rate

    FROM order_items oi

    JOIN orders o
        ON oi.order_id=o.order_id

    GROUP BY
        oi.seller_id
)

SELECT

    sm.seller_id,

    sm.revenue,

    sm.total_orders,

    sm.products_sold,

    sm.average_selling_price,

    sc.cancellation_rate,

    DENSE_RANK() OVER(
        ORDER BY sm.revenue DESC
    ) AS revenue_rank,

    ROUND(
        sm.revenue *100.0/
        SUM(sm.revenue) OVER(),
        2
    ) AS revenue_contribution

FROM seller_metrics sm

JOIN seller_cancellation sc
ON sm.seller_id=sc.seller_id;
