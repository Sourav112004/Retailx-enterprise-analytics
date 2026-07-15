/*
=========================================================
Case 08: Customer Retention Analysis
=========================================================

Business Problem:
The marketing team wants to measure how effectively RetailX retains customers
by identifying customers who make purchases in consecutive calendar months.

Business Questions:
1. How many active customers are there each month?
2. How many customers returned from the previous month?
3. What is the monthly customer retention rate?

SQL Concepts Used:
• Common Table Expressions (CTEs)
• Window Functions (LAG)
• CASE Statements
• Aggregate Functions (COUNT, SUM)
• Date Functions (DATE_FORMAT, STR_TO_DATE, DATE_SUB)
• GROUP BY
• Conditional Logic

Approach:

1. Created a Customer × Month dataset by extracting distinct monthly purchases
   for every customer.

2. Used the LAG() window function to retrieve each customer's previous
   purchase month.

3. Compared the previous purchase month with the current month minus one month
   to identify customers who purchased in consecutive calendar months.

4. Assigned a Retention flag:
      • 1 = Customer retained
      • 0 = Customer not retained

5. Aggregated monthly metrics including:
      • Active Customers
      • Retained Customers

6. Used LAG() again to retrieve the previous month's active customer count.

7. Calculated Monthly Retention Rate using:

        Retained Customers
      -------------------------- × 100
      Previous Month Active Customers

Business Insights:
• Calculated monthly customer retention across the marketplace.
• Identified customers returning in consecutive months.
• Measured monthly retention trends to evaluate customer loyalty.
• The analysis can help marketing teams improve retention through
  loyalty programs, personalized campaigns, and customer engagement strategies.

=========================================================
*/

with customer_month as (select c.customer_unique_id as customers,DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m-01') AS order_month
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id,order_month
),
customer_retention as (select customers,order_month,
LAG(order_month) OVER(PARTITION BY customers ORDER BY order_month) as previous_order_month
from customer_month
),
 retention_flag as ( select*,
CASE WHEN previous_order_month=
date_format(
DATE_SUB(
str_to_date(order_month,'%Y-%m-%d'),INTERVAL 1 MONTH),'%Y-%m-01' 
)THEN 1 
else 0
end as Retention
from customer_retention
),
monthly_retention as(
select 
order_month,COUNT(DISTINCT customers) active_customers,SUM(Retention) as retained_customers
from retention_flag
group by order_month
),
retention_rate_cte as(select*,
LAG(active_customers)
OVER(ORDER BY order_month)
AS previous_month_active_customers
from monthly_retention)

select*,ROUND(
    retained_customers * 100.0 /
    previous_month_active_customers,
    2
) AS retention_rate


from retention_rate_cte
