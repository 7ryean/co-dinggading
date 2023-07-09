WITH num_measurements AS(
SELECT 
  *
  , ROW_NUMBER() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time) AS num
FROM
  measurements
)

SELECT
  DATE(measurement_time)
  , SUM(CASE WHEN num % 2 = 1 THEN measurement_value END) AS odd_sum
  , SUM(CASE WHEN num % 2 = 0 THEN measurement_value END) AS even_sum
FROM num_measurements
GROUP BY 1
ORDER BY 1
;
