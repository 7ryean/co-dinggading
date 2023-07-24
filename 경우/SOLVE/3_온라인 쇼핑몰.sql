
SELECT re.order_date as dt
     , COUNT(DISTINCT re.customer_id) AS dau
     , COUNT(DISTINCT re_2.customer_id) AS wau
     , ROUND(COUNT(DISTINCT re.customer_id) / COUNT(DISTINCT re_2.customer_id), 2) AS stickiness
FROM records as re
      INNER join records as re_2 on re_2.order_date BETWEEN 
      DATE_ADD(re.order_date, INTERVAL -6 DAY) and re.order_date    
WHERE date_format(re.order_date, '%y.%m') = '20.11'
group by re.order_date
