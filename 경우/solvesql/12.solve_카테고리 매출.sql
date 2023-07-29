SELECT category
      , sub_category
      , ROUND( SUM(sales) OVER(PARTITION BY category , sub_category) ,2)  as sales_sub_category
      , ROUND( SUM(sales) OVER(PARTITION BY category) ,2)                 as sales_category
      , ROUND( SUM(sales) OVER(),2)                                       as sales_total
      , ROUND ( SUM(sales) OVER(PARTITION BY category , sub_category) 
        / SUM(sales) OVER(PARTITION BY category) *100 ,2)                 as pct_in_category
      , ROUND(SUM(sales) OVER(PARTITION BY category,sub_category) 
        / SUM(sales) OVER()*100 ,2)                                       as pct_in_total
FROM (
  SELECT category
      , sub_category
      , SUM(sales)   sales
  FROM records
  GROUP BY 1, 2
) a
