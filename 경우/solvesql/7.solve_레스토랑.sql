SELECT day 
      , time 
      , sex 
      , total_bill  
FROM (
  SELECT day 
      , time 
      , sex 
      , total_bill  
      , DENSE_RANK() OVER(PARTITION BY day ORDER BY total_bill DESC) idx
  FROM tips
)a
WHERE idx <=3