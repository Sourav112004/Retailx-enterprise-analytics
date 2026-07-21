

CREATE VIEW vw_product_reviews AS

WITH review_metrics AS
(
    SELECT

        p.product_category_name,

        ROUND(AVG(r.review_score),2) AS average_review,

        COUNT(r.review_score) AS total_reviews,

        COUNT(DISTINCT o.order_id) AS order_count,

        SUM(
            CASE
                WHEN r.review_score = 5 THEN 1
                ELSE 0
            END
        ) AS five_star_review,

        SUM(
            CASE
                WHEN r.review_score = 1 THEN 1
                ELSE 0
            END
        ) AS one_star_review

    FROM products p

    JOIN order_items oi
        ON p.product_id = oi.product_id

    JOIN orders o
        ON oi.order_id = o.order_id

    JOIN reviews r
        ON o.order_id = r.order_id

    GROUP BY
        p.product_category_name
)

SELECT

    product_category_name,

    average_review,

    total_reviews,

    order_count,

    five_star_review,

    one_star_review,

    ROUND(
        one_star_review * 100.0 /
        total_reviews,
        2
    ) AS negative_review_rate

FROM review_metrics;
