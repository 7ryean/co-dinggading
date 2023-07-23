WITH beginner_page_view_info AS (
  SELECT DISTINCT 
      ga_session_id
    , user_pseudo_id
  FROM
      ga
  WHERE 
        page_title = '백문이불여일타 SQL 캠프 입문반'
    AND event_name = 'page_view'
)

SELECT
    COUNT(DISTINCT ga.ga_session_id, ga.user_pseudo_id)                                               AS total
  , COUNT(DISTINCT beginner_page_view_info.ga_session_id, beginner_page_view_info.user_pseudo_id)     AS pv_yes
  , COUNT(DISTINCT ga.ga_session_id, ga.user_pseudo_id)
      - COUNT(DISTINCT beginner_page_view_info.ga_session_id, beginner_page_view_info.user_pseudo_id) AS pv_no
FROM
    ga
    LEFT JOIN beginner_page_view_info
      ON ga.ga_session_id = beginner_page_view_info.ga_session_id
      AND ga.user_pseudo_id = beginner_page_view_info.user_pseudo_id
;