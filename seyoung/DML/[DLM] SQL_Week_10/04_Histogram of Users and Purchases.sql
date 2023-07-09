WITH users_currentdate AS (
SELECT 
  DISTINCT user_id
  ,  MAX(transaction_date) OVER(PARTITION BY user_id) max_transaction_date
FROM 
  user_transactions
)

SELECT 
  user_transactions.transaction_date
  , user_transactions.user_id
  , COUNT(user_transactions.user_id)
FROM 
  user_transactions
  INNER JOIN users_currentdate
  ON user_transactions.user_id = users_currentdate.user_id
  AND user_transactions.transaction_date = users_currentdate.max_transaction_date
GROUP BY 
  1, 2
ORDER BY 
  1
;
