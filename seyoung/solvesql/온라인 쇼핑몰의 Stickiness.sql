SELECT 
  re1.order_date AS dt
  , COUNT(DISTINCT re1.customer_id) AS dau
  , COUNT(DISTINCT re2.customer_id) AS wau
  , ROUND(COUNT(DISTINCT re1.customer_id) / COUNT(DISTINCT re2.customer_id), 2) AS stickiness
FROM records AS re1
  LEFT JOIN records as re2
  ON re2.order_date BETWEEN DATE_SUB(re1.order_date, INTERVAL 6 day) and re1.order_date
WHERE 
  DATE_FORMAT(re1.order_date, '%Y%m') = 202011 
GROUP BY 1
;
