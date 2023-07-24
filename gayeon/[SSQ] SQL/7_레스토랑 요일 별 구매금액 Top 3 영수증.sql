WITH dense_rank_top_3 AS (
  SELECT 
      day
    , total_bill
    , DENSE_RANK() OVER(PARTITION BY day ORDER BY total_bill DESC) AS total_bill_rank
  FROM
      tips
)

SELECT 
    tips.day
  , time
  , sex
  , tips.total_bill
FROM
    tips
    INNER JOIN dense_rank_top_3
      ON tips.day = dense_rank_top_3.day
        AND tips.total_bill = dense_rank_top_3.total_bill
        AND dense_rank_top_3.total_bill_rank <= 3
ORDER BY 
    1
  , 2
  , 4 DESC
;