WITH beginner_page_view_info AS (
  SELECT 
      user_pseudo_id
    , ga_session_id
  FROM
      ga
  WHERE 
        page_title = '백문이불여일타 SQL 캠프 입문반'
    AND event_name = 'page_view'
)
, beginner_page_scroll_info AS (
  SELECT
      user_pseudo_id
    , ga_session_id
  FROM
      ga
  WHERE
        page_title = '백문이불여일타 SQL 캠프 입문반'
    AND event_name = 'scroll'
)

SELECT
    COUNT(DISTINCT ga.user_pseudo_id, ga.ga_session_id)                       AS total
  , COUNT(DISTINCT ga.user_pseudo_id, ga.ga_session_id)
      - COUNT(DISTINCT view_info.user_pseudo_id, view_info.ga_session_id)     AS pv_no
  , COUNT(DISTINCT view_info.user_pseudo_id, view_info.ga_session_id)
      - COUNT(DISTINCT scroll_info.user_pseudo_id, scroll_info.ga_session_id) AS pv_yes_scroll_no
  , COUNT(DISTINCT scroll_info.user_pseudo_id, scroll_info.ga_session_id)     AS pv_yes_scroll_yes
FROM
    ga 
    LEFT JOIN beginner_page_view_info AS view_info
      ON ga.user_pseudo_id = view_info.user_pseudo_id
        AND ga.ga_session_id = view_info.ga_session_id
    LEFT JOIN beginner_page_scroll_info AS scroll_info
      ON view_info.user_pseudo_id = scroll_info.user_pseudo_id
        AND view_info.ga_session_id = scroll_info.ga_session_id
;