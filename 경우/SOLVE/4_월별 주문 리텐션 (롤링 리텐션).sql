WITH retention as (
SELECT date_format(cs.first_order_date  , '%Y-%m-01')  first_order_month
      ,date_format(cs.last_order_date, '%Y-%m-01') last_order_date
      , re.customer_id
FROM records re
  INNER JOIN customer_stats  cs ON re.customer_id = cs.customer_id
)


SELECT first_order_month
      , COUNT(DISTINCT CASE WHEN first_order_month <= last_order_date THEN customer_id END )  month0 
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 1 month) <= last_order_date THEN customer_id END ) month1
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 2 month) <= last_order_date THEN customer_id END ) month2
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 3 month) <= last_order_date THEN customer_id END ) month3
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 4 month) <= last_order_date THEN customer_id END ) month4
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 5 month) <= last_order_date THEN customer_id END ) month5
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 6 month) <= last_order_date THEN customer_id END ) month6
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 7 month) <= last_order_date THEN customer_id END ) month7
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 8 month) <= last_order_date THEN customer_id END ) month8
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 9 month) <= last_order_date THEN customer_id END ) month9
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 10 month) <= last_order_date THEN customer_id END ) month10
      , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month,INTERVAL 11 month) <= last_order_date THEN customer_id END ) month11
FROM retention
GROUP BY first_order_month


