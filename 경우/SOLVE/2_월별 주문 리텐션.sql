
with retention as (
SELECT date_format(cs.first_order_date  , '%Y-%m-01')  first_order_month
      , TIMESTAMPDIFF(MONTH, date_format(cs.first_order_date, '%Y-%m-01'), date_format(re.order_date, '%Y-%m-01')) month_diff
      , re.customer_id
FROM records re
  INNER JOIN customer_stats  cs ON re.customer_id = cs.customer_id
)
SELECT first_order_month
      ,COUNT( DISTINCT  CASE WHEN month_diff = 0 THEN customer_id END ) month0 
      ,COUNT( DISTINCT  CASE WHEN month_diff = 1 THEN customer_id END ) month1
      ,COUNT( DISTINCT  CASE WHEN month_diff = 2 THEN customer_id END ) month2
      ,COUNT( DISTINCT  CASE WHEN month_diff = 3 THEN customer_id END ) month3
      ,COUNT( DISTINCT  CASE WHEN month_diff = 4 THEN customer_id END ) month4
      ,COUNT( DISTINCT  CASE WHEN month_diff = 5 THEN customer_id END ) month5
      ,COUNT( DISTINCT  CASE WHEN month_diff = 6 THEN customer_id END ) month6
      ,COUNT( DISTINCT  CASE WHEN month_diff = 7 THEN customer_id END ) month7
      ,COUNT( DISTINCT  CASE WHEN month_diff = 8 THEN customer_id END ) month8
      ,COUNT( DISTINCT  CASE WHEN month_diff = 9 THEN customer_id END ) month9
      ,COUNT( DISTINCT  CASE WHEN month_diff = 10 THEN customer_id END) month10
      ,COUNT( DISTINCT  CASE WHEN month_diff = 11 THEN customer_id END ) month11
FROM retention
GROUP BY first_order_month
