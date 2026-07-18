# Case Study 10: Delivery Performance Analysis

## Business Problem
Evaluate delivery performance across customer states by analyzing delivery efficiency, late delivery rates, and seller network coverage. Identify regions with poor delivery performance and investigate whether seller availability contributes to longer delivery times.

---

## Objectives
- Analyze delivery performance by customer state.
- Calculate delivered order count.
- Calculate late order count.
- Measure late delivery rate (%).
- Calculate average delivery time (days).
- Measure seller network coverage by customer state.
- Investigate the relationship between seller count and delivery performance.

---

## Business Questions
1. Which customer states have the highest average delivery time?
2. Which states experience the highest late delivery rate?
3. Which states are served by the fewest sellers?
4. Is there a relationship between seller network size and delivery performance?
5. Which regions should be prioritized for logistics improvements?

---

## KPIs
- Delivered Order Count
- Late Order Count
- Late Delivery Rate (%)
- Average Delivery Time (Days)
- Unique Seller Count

---

## SQL Concepts Used
- SQL Views
- Common Table Expressions (CTEs)
- CASE Statements
- Aggregate Functions
- DATEDIFF()
- COUNT(DISTINCT)
- INNER JOINs
- Business KPI Design

---

## Views Created
### vw_delivery_performance
Provides state-level delivery performance metrics:
- Delivered Order Count
- Late Order Count
- Late Delivery Rate
- Average Delivery Time

### vw_seller_network
Provides seller coverage metrics:
- Customer State
- Unique Seller Count

---

## Key Insights
- Built reusable SQL Views to separate KPI computation from business investigations.
- Replaced one-time CTE analysis with reusable reporting objects.
- Combined multiple KPI views to investigate delivery performance.
- Applied a modular analytics approach similar to production BI reporting.
- Generated actionable business insights by connecting delivery metrics with seller network coverage.

create view dv_delivery_perfomance as
with late_orders as(select c.customer_state,
CASE WHEN order_delivered_customer_date>order_estimated_delivery_date THEN 1
ELSE 0
end as 
late_orders,
DATEDIFF(order_delivered_customer_date,
         order_purchase_timestamp) as delivery_time
from
orders o
JOIN customers c on o.customer_id=c.customer_id
WHERE o.order_status='delivered'
)
select customer_state,
SUM(late_orders) as late_order_count,
COUNT(*) as delivered_order_count,
ROUND(SUM(late_orders)/COUNT(*) *100 ,2)as late_delivery_rate,
AVG(delivery_time) as avg_delivery_time
from late_orders
group by customer_state
order by avg_delivery_time desc 
;
select*from dv_delivery_perfomance ddp
 JOIN dv_seller_network dvc on ddp.customer_state=dvc.customer_state

;

-- Checking Sellers that serve RR
create view dv_seller_network as
select c.customer_state,COUNT(DISTINCT s.seller_id) as seller_count from customers c 
JOIN orders o on c.customer_id=o.customer_id
JOIN order_items oi on o.order_id=oi.order_id
JOIN sellers s on oi.seller_id=s.seller_id
group by c.customer_state
;
