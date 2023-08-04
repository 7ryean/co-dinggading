
WITH t1 as ( 
  SELECT DISTINCT 
        user_pseudo_id
        , event_timestamp_kst 
        , LAG(event_timestamp_kst) OVER(ORDER BY event_timestamp_kst) lt_time

  FROM ga
  WHERE user_pseudo_id = 'S3WDQCqLpK'
  ORDER BY event_timestamp_kst
) , t2 as (
SELECT  DISTINCT
       user_pseudo_id
      , event_timestamp_kst as  start_time 
FROM t1
WHERE event_timestamp_kst > date_add(lt_time , INTERVAL 1 HOUR )
or event_timestamp_kst = (SELECT MIN(event_timestamp_kst) FROM t1)
)

SELECT user_pseudo_id
        , start_time as session_start
       ,DATE_ADD( CASE WHEN ISNULL(fn) THEN  last ELSE fn END , INTERVAL 1 HOUR) as session_end
FROM (
  SELECT *
      , LEAD(finish_time) OVER(ORDER BY start_time) fn
  FROM ( 
    SELECT t2.start_time
          , t2.user_pseudo_id
          , MAX(t1.event_timestamp_kst) finish_time
          , (SELECT MAX(event_timestamp_kst) FROM t1) last
    FROM  t2
      LEFT JOIN t1 ON t2.start_time > t1.event_timestamp_kst
    GROUP BY start_time ,t2.user_pseudo_id
  )a
)b
ORDER BY session_start

