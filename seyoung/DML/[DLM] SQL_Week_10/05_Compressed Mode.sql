SELECT 
  max_order.item_count AS mode
FROM
  ( SELECT 
      item_count
      , dense_rank() over(order by order_occurrences DESC) as num
    FROM items_per_order
  ) AS max_order
WHERE max_order.num = 1
;
