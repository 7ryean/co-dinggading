SELECT 
    records_for_day.order_date AS dt 
  , COUNT(DISTINCT records_for_day.customer_id)          AS dau
  , COUNT(DISTINCT records_for_week.customer_id)         AS wau
  , ROUND(COUNT(DISTINCT records_for_day.customer_id) 
      / COUNT(DISTINCT records_for_week.customer_id), 2) AS stickiness
FROM records AS records_for_day
  LEFT JOIN records AS records_for_week
    ON records_for_week.order_date 
        BETWEEN DATE_ADD(records_for_day.order_date, INTERVAL -6 DAY) 
          AND records_for_day.order_date
WHERE 
    records_for_day.order_date BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY
    1
ORDER BY 
    1
;