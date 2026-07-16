/*
=========================================================
Case 09: Product Category Review Analysis
=========================================================

Business Problem:
The Product and Customer Experience teams want to understand
how different product categories perform from a customer
satisfaction perspective. By analyzing customer reviews,
the company can identify high-performing categories,
categories requiring quality improvements, and opportunities
to improve customer experience.

Business Questions:
1. Which product categories have the highest average review score?
2. Which categories receive the highest number of reviews?
3. Which categories receive the most 5-star reviews?
4. Which categories receive the most 1-star reviews?
5. Which categories should be prioritized for quality improvement?

SQL Concepts Used:
• Common Table Expressions (CTEs)
• Multiple Table Joins
• Aggregate Functions (AVG, COUNT, SUM)
• CASE Statements
• GROUP BY
• ORDER BY
• Business KPI Development

Approach:

1. Joined Products, Order Items, Orders, and Reviews tables.
2. Aggregated customer reviews at the Product Category level.
3. Calculated Average Review Score for each category.
4. Counted Total Reviews for every category.
5. Counted Total Orders for business context.
6. Calculated Five-Star Review Count using CASE statements.
7. Calculated One-Star Review Count using CASE statements.
8. Ranked categories based on customer satisfaction metrics.

Business KPIs:
• Average Review Score
• Total Reviews
• Total Orders
• Five-Star Review Count
• One-Star Review Count

Business Insights:
• Identified product categories receiving the highest number of positive reviews.
• Measured customer satisfaction across all product categories.
• Highlighted categories generating the highest number of negative reviews.
• Compared review volume with order volume to understand customer feedback patterns.
• Generated actionable insights that can support product quality improvements and customer experience initiatives.

=========================================================
*/

with review_cte as(select  p.product_category_name,AVG(r.review_score) as average_review,COUNT(r.review_score) total_reviews,COUNT(DISTINCT o.order_id) order_count ,
SUM(
CASE WHEN r.review_score =5 then 1
else 0
end)  
as five_star_review,
SUM(
CASE WHEN r.review_score =1 then 1
else 0
end)as one_star_review

from products p
JOIN order_items oi on p.product_id=oi.product_id
JOIN orders o on oi.order_id=o.order_id
JOIN reviews r on o.order_id=r.order_id
group by  p.product_category_name
)
select*,ROUND(
    one_star_review * 100.0 /
    total_reviews,
    2
) AS negative_review_rate 
from review_cte
order by one_star_review desc
