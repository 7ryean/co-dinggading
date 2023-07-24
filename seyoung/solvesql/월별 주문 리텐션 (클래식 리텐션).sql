WITH records_customer AS (
SELECT 
  DATE_FORMAT(cs.first_order_date, '%Y-%m-01') AS first_order_date
  , cs.last_order_date
  , records.order_date
  , records.order_id
  , records.customer_id
  , TIMESTAMPDIFF(MONTH,DATE_FORMAT(cs.first_order_date, '%Y-%m-01'), order_date) AS month_diff
FROM records
  INNER JOIN customer_stats AS cs
  ON records.customer_id = cs.customer_id
)

SELECT 
  first_order_date AS first_order_month
  , COUNT(DISTINCT CASE WHEN month_diff = 0 THEN customer_id END) AS month0
  , COUNT(DISTINCT CASE WHEN month_diff = 1 THEN customer_id END) AS month1
  , COUNT(DISTINCT CASE WHEN month_diff = 2 THEN customer_id END) AS month2
  , COUNT(DISTINCT CASE WHEN month_diff = 3 THEN customer_id END) AS month3
  , COUNT(DISTINCT CASE WHEN month_diff = 4 THEN customer_id END) AS month4
  , COUNT(DISTINCT CASE WHEN month_diff = 5 THEN customer_id END) AS month5
  , COUNT(DISTINCT CASE WHEN month_diff = 6 THEN customer_id END) AS month6
  , COUNT(DISTINCT CASE WHEN month_diff = 7 THEN customer_id END) AS month7
  , COUNT(DISTINCT CASE WHEN month_diff = 8 THEN customer_id END) AS month8
  , COUNT(DISTINCT CASE WHEN month_diff = 9 THEN customer_id END) AS month9
  , COUNT(DISTINCT CASE WHEN month_diff = 10 THEN customer_id END) AS month10
  , COUNT(DISTINCT CASE WHEN month_diff = 11 THEN customer_id END) AS month11

FROM 
  records_customer
GROUP BY 1
;
