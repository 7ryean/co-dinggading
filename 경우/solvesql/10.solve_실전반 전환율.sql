-- 실전반 페이지 뷰 > 스크롤 > 실전반 신청

WITH pv_view_table as (
    SELECT DISTINCT   ga_session_id
                    , user_pseudo_id
                    , event_timestamp_kst
    FROM ga
    WHERE page_title = '백문이불여일타 SQL 캠프 실전반'
    AND event_name = 'page_view'
) , pv_scroll_table  as (
    SELECT DISTINCT ga_session_id
                , user_pseudo_id
                , event_timestamp_kst
    FROM ga
    WHERE page_title = '백문이불여일타 SQL 캠프 실전반'
    AND event_name ='scroll'
    AND user_pseudo_id IN (SELECT user_pseudo_id FROM pv_view_table )
    
) , pv_click_table as(
    SELECT DISTINCT ga_session_id
                , user_pseudo_id
                , event_timestamp_kst
    FROM ga
    WHERE page_title = '백문이불여일타 SQL 캠프 실전반'
    AND event_name = 'SQL_advanced_form_click'
    AND user_pseudo_id IN (SELECT user_pseudo_id FROM pv_scroll_table )
)

SELECT COUNT(DISTINCT view.ga_session_id, view.user_pseudo_id)              as pv
      , COUNT(DISTINCT scroll.ga_session_id, scroll.user_pseudo_id)         as scroll_after_pv
      , COUNT(DISTINCT click.ga_session_id, click.user_pseudo_id)           as click_after_scroll 
      , ROUND( COUNT(DISTINCT scroll.ga_session_id, scroll.user_pseudo_id)  / COUNT(DISTINCT view.ga_session_id, view.user_pseudo_id),3)  as pv_scroll_rate
      , ROUND( COUNT(DISTINCT click.ga_session_id, click.user_pseudo_id) / COUNT(DISTINCT view.ga_session_id, view.user_pseudo_id),3)   as pv_click_rate
      , ROUND( COUNT(DISTINCT click.ga_session_id, click.user_pseudo_id) / COUNT(DISTINCT scroll.ga_session_id, scroll.user_pseudo_id),3) as scroll_click_rate
FROM pv_view_table  as view 
  LEFT JOIN pv_scroll_table as scroll ON  view.ga_session_id = scroll.ga_session_id 
        AND view.user_pseudo_id = scroll.user_pseudo_id
        AND view.event_timestamp_kst <= scroll.event_timestamp_kst
  LEFT JOIN pv_click_table as click ON   scroll.ga_session_id = click.ga_session_id  
        AND scroll.user_pseudo_id = click.user_pseudo_id  
        AND scroll.event_timestamp_kst <= click.event_timestamp_kst
