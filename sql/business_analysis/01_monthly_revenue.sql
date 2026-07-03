select DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS Monthly_sales,SUM(oi.price) AS revenue from orders o
JOIN order_items oi on o.order_id=oi.order_id
group by DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
order by revenue asc
LIMIT 5
;
