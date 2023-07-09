SELECT c.customer_id
FROM customer_contracts c
  INNER JOIN products p
  ON c.product_id = p.product_id
GROUP BY 1
HAVING COUNT(DISTINCT p.product_category) = (
    SELECT COUNT(DISTINCT product_category)
    FROM products)
;
