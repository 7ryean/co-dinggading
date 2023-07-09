WITH products_category_info AS (
    SELECT
        customer_id
      , COUNT(DISTINCT product_category) AS cnt_product
    FROM 
        customer_contracts
        INNER JOIN products 
          ON customer_contracts.product_id = products.product_id
    GROUP BY 
        1
)

SELECT
    customer_id
FROM 
    products_category_info
WHERE
    cnt_product >= 3
;
