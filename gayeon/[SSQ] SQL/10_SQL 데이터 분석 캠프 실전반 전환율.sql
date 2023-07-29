WITH advanced_view_info AS (
    SELECT
        user_pseudo_id
      , ga_session_id
      , event_timestamp_kst
    FROM 
        ga 
    WHERE 
          page_title = "백문이불여일타 SQL 캠프 실전반"
      AND event_name = "page_view"
)
, advanced_scroll_info AS (
    SELECT
        user_pseudo_id
      , ga_session_id
      , event_timestamp_kst
    FROM 
        ga 
    WHERE 
          page_title = "백문이불여일타 SQL 캠프 실전반"
      AND event_name = "scroll"
)
, advanced_click_info AS (
    SELECT
        user_pseudo_id
      , ga_session_id
      , event_timestamp_kst
    FROM 
        ga 
    WHERE 
        event_name = "SQL_advanced_form_click"
)
, advanced_info AS (
    SELECT 
        COUNT(DISTINCT view.user_pseudo_id, view.ga_session_id)     AS pv
      , COUNT(DISTINCT scroll.user_pseudo_id, scroll.ga_session_id) AS scroll_after_pv
      , COUNT(DISTINCT click.user_pseudo_id, click.ga_session_id)   AS click_after_scroll
    FROM 
        advanced_view_info AS view
        LEFT JOIN advanced_scroll_info AS scroll
          ON view.user_pseudo_id = scroll.user_pseudo_id
            AND view.ga_session_id = scroll.ga_session_id
            AND view.event_timestamp_kst <= scroll.event_timestamp_kst
        LEFT JOIN advanced_click_info AS click 
          ON scroll.user_pseudo_id = click.user_pseudo_id
            AND scroll.ga_session_id = click.ga_session_id
            AND scroll.event_timestamp_kst <= click.event_timestamp_kst
)

SELECT 
    pv
  , scroll_after_pv
  , click_after_scroll
  , ROUND(scroll_after_pv / pv, 3)                 AS pv_scroll_rate
  , ROUND(click_after_scroll / pv, 3)              AS pv_click_rate
  , ROUND(click_after_scroll / scroll_after_pv, 3) AS scroll_click_rate
FROM 
    advanced_info
;