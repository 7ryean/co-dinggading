WITH transactions_spend_rank AS (
    SELECT 
        transaction_date
      , user_id
      , product_id
      -- ROW_NUMBER는 중복없이기 때문에 해당 문제에는 적합하지 않음
      , RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS transaction_rank
    FROM
        user_transactions
)

SELECT
    transaction_date
  , user_id
  , COUNT(DISTINCT product_id) AS purchase_count
FROM
    transactions_spend_rank
WHERE
    transaction_rank = 1
GROUP BY 
    1
  , 2
ORDER BY
    1
;