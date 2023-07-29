WITH total_sales_info AS (
    SELECT DISTINCT
      category
    , sub_category
    , SUM(sales) OVER(PARTITION BY category, sub_category) AS sales_sub_category
    , SUM(sales) OVER(PARTITION BY category)               AS sales_category
    FROM
      records
)

SELECT 
    category
  , sub_category
  , ROUND(sales_sub_category, 2)                                        AS sales_sub_category
  , ROUND(sales_category, 2)                                            AS sales_category
  , ROUND(SUM(sales_sub_category) OVER(), 2)                            AS sales_total
  , ROUND(sales_sub_category / sales_category * 100, 2)                 AS pct_in_category
  , ROUND(sales_sub_category / SUM(sales_sub_category) OVER() * 100, 2) AS pct_in_total
FROM 
    total_sales_info
;