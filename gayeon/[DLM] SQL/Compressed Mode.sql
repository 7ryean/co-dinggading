SELECT 
    item_count AS mode
FROM 
    items_per_order
WHERE 
    order_occurrences = (
        SELECT 
            MAX(order_occurrences)
        FROM 
            items_per_order
    )
;

-- 요건 무슨 함수일까
-- SELECT item_count AS mode
-- FROM items_per_order
-- WHERE order_occurrences = (
--   SELECT MODE() WITHIN GROUP (ORDER BY order_occurrences DESC) 
--   FROM items_per_order
-- )
-- ORDER BY item_count;