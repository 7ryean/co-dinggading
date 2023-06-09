SELECT UnitsSold.product_id
    , ROUND(SUM(Prices.price * UnitsSold.units) / SUM(units), 2) AS average_price
FROM UnitsSold
    INNER JOIN Prices ON UnitsSold.product_id = Prices.product_id 
        AND UnitsSold.purchase_date BETWEEN (Prices.start_date) AND (Prices.end_date)
GROUP BY 1
;