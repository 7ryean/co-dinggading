WITH measurement_rank_info AS (
    SELECT
        DATE_TRUNC('day', measurement_time)                                                           AS measurement_day
      , measurement_value
      , ROW_NUMBER() OVER(PARTITION BY DATE_TRUNC('day', measurement_time) ORDER BY measurement_time) AS measurement_rank
    FROM 
        measurements
)

SELECT 
    measurement_day
  , SUM(CASE WHEN measurement_rank % 2 = 1 THEN measurement_value END) AS odd_sum
  , SUM(CASE WHEN measurement_rank % 2 = 0 THEN measurement_value END) AS even_sum
FROM
    measurement_rank_info
GROUP BY
    1
;