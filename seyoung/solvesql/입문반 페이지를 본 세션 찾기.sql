WITH pv_y AS (
SELECT 
  user_pseudo_id
  , ga_session_id
FROM ga
WHERE page_title = '백문이불여일타 SQL 캠프 입문반' AND event_name = 'page_view'
)

SELECT 
  COUNT(DISTINCT ga.user_pseudo_id, ga.ga_session_id) AS total
  , COUNT(DISTINCT ga.user_pseudo_id, ga.ga_session_id) - COUNT(DISTINCT pv_y.user_pseudo_id, pv_y.ga_session_id) AS pv_no
  , COUNT(DISTINCT pv_y.user_pseudo_id, pv_y.ga_session_id) AS pv_yes
FROM ga
  LEFT JOIN pv_y
  ON ga.user_pseudo_id = pv_y.user_pseudo_id 
  AND ga.ga_session_id = pv_y.ga_session_id
;
