SELECT DISTINCT
    DATE_FORMAT(customer_stats.first_order_date, '%Y-%m-01') AS first_order_month
  , COUNT(DISTINCT customer_stats.customer_id)               AS month0
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 1 
              THEN customer_stats.customer_id
            END)                                             AS month1
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 2 
              THEN customer_stats.customer_id
            END)                                             AS month2
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 3
              THEN customer_stats.customer_id
            END)                                             AS month3
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 4
              THEN customer_stats.customer_id
            END)                                             AS month4
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 5
              THEN customer_stats.customer_id
            END)                                             AS month5
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 6
              THEN customer_stats.customer_id
            END)                                             AS month6
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 7
              THEN customer_stats.customer_id
            END)                                             AS month7
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 8
              THEN customer_stats.customer_id
            END)                                             AS month8
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 9
              THEN customer_stats.customer_id
            END)                                             AS month9
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 10
              THEN customer_stats.customer_id
            END)                                             AS month10
  , COUNT(DISTINCT 
            CASE WHEN MONTH(order_date) - MONTH(first_order_date) >= 11
              THEN customer_stats.customer_id
            END)                                             AS month11
FROM
    customer_stats
    INNER JOIN records
      ON customer_stats.customer_id = records.customer_id
GROUP BY 
    1
ORDER BY 
    1
;
