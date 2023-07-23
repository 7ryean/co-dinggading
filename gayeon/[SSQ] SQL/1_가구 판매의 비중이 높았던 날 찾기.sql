SELECT 
    order_date
  , COUNT(DISTINCT CASE WHEN category = 'Furniture' THEN order_id END) AS furniture
  , ROUND(COUNT(DISTINCT CASE WHEN category = 'Furniture' THEN order_id END) 
      / COUNT(DISTINCT order_id) * 100, 2) AS furniture_pct
FROM 
    records
GROUP BY 
    1
HAVING 
      COUNT(DISTINCT order_id) >= 10 
  AND furniture_pct >= 40
ORDER BY 
    furniture_pct DESC 
  , order_date
;