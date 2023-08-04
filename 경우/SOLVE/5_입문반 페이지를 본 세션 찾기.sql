
with total_table as (
SELECT user_pseudo_id
      , COUNT(DISTINCT ga_session_id) as total_cnt
FROM ga
GROUP BY user_pseudo_id  
),  pv_yes_table as (
SELECT user_pseudo_id
      , COUNT(DISTINCT ga_session_id) as cnt
FROM ga
WHERE page_title = '백문이불여일타 SQL 캠프 입문반'
AND event_name ='page_view'
GROUP BY user_pseudo_id)

SELECT SUM(total_cnt) total
      , SUM(total_cnt) - SUM(cnt) pv_no 
      , SUM(cnt) pv_yes
FROM total_table
  LEFT JOIN  pv_yes_table ON total_table.user_pseudo_id = pv_yes_table.user_pseudo_id
