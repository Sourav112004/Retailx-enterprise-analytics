- Business Question:
-- How has the number of customer orders changed month-over-month?
--
-- Business Objective:
-- Analyze monthly order trends to understand customer demand,
-- identify growth or decline, and detect seasonal purchasing patterns.

select date_format(o.order_purchase_timestamp,"%Y-%m") AS months,COUNT(o.order_id) AS total_orders,COUNT(DISTINCT c.customer_unique_id) AS unique_customers from orders o
JOIN customers c on o.customer_id=c.customer_id
group by months 
order by months asc
;


select s.seller_id,o.order_status,p.payment_type,c.customer_unique_id,c.customer_state,c.customer_city,o.order_estimated_delivery_date,o.order_delivered_customer_date from orders o
JOIN customers c on o.customer_id=c.customer_id
JOIN order_items oi on o.order_id=oi.order_id
JOIN sellers s on oi.seller_id=s.seller_id
JOIN payments p on o.order_id=p.order_id
where YEAR(order_purchase_timestamp)='2016' AND MONTH(order_purchase_timestamp)='09' 
AND o.order_status='shipped';
-- Identify the seller check their performance over time

select oi.seller_id,
SUM(
	CASE WHEN order_status='shipped'then 1
    else 0
    END
) AS 'shipped',
SUM(
	CASE WHEN order_status='delivered'then 1
    else 0
    END
) AS 'delivered',
SUM(
	CASE WHEN order_status='canceled'then 1
    else 0
    END
) AS 'canceled',
SUM(
	CASE WHEN order_status='unavailable'then 1
    else 0
    END
) AS 'unavailable'
from orders o
JOIN order_items oi on o.order_id=oi.order_id
group by oi.seller_id;

select DISTINCT(order_status) from orders;

select oi.seller_id,COUNT(oi.order_id) AS total_orders,
SUM(
	CASE WHEN o.order_status='canceled' then 1
    else 0
END) AS 'canceled orders',
ROUND(SUM(
CASE WHEN o.order_status='canceled' THEN 1*100
else 0
END),2)/COUNT(o.order_id) AS 'cancelation_rate'

 from order_items oi
JOIN orders o on oi.order_id=o.order_id
group by oi.seller_id
HAVING total_orders>500
order by cancelation_rate desc
limit 10;
