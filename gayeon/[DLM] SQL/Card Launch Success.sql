WITH issued_rank_info AS (SELECT
    card_name
  , issued_amount
  , issue_year
  , ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS issued_rank
FROM 
    monthly_cards_issued
)

SELECT
    card_name
  , issued_amount
FROM
    issued_rank_info
WHERE 
    issued_rank = 1
ORDER BY
    2 DESC
;