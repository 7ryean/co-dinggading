WITH rnk_date AS(
SELECT 
  *
  , DENSE_RANK() OVER(PARTITION BY card_name ORDER BY issue_year,issue_month) AS rnk
FROM 
  monthly_cards_issued
)

SELECT
  card_name
  , issued_amount
FROM 
  rnk_date
WHERE 
  rnk = 1
ORDER BY 2 DESC
;
