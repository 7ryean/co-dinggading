-- 처음에는 저번주와 같이 집계해서 푸는 방식으로 했는데 아무리해도 정답이 안나오더라규요,, (2명차이)
-- 포기하고 방법을 바꿔서 저번주에 가연님이 푸신 방식으로 조인하여 풀었는데 답이나오네요 전 아직도 어디서 답이 갈린지 이해는 못했습니다ㅜㅜ

WITH pv_view_table as (
    SELECT DISTINCT   ga_session_id
                    , user_pseudo_id
    FROM ga
    WHERE page_title = '백문이불여일타 SQL 캠프 입문반'
    AND event_name = 'page_view'
) , pv_scroll_table  as (
    SELECT DISTINCT ga_session_id
                , user_pseudo_id
    FROM ga
    WHERE page_title = '백문이불여일타 SQL 캠프 입문반'
    AND event_name ='scroll'
    AND user_pseudo_id IN (SELECT user_pseudo_id FROM pv_view_table )
)

SELECT COUNT(DISTINCT ga.ga_session_id, ga.user_pseudo_id)   total
        , COUNT(DISTINCT ga.ga_session_id, ga.user_pseudo_id) 
            - COUNT(DISTINCT pv_view_table.ga_session_id ,pv_view_table.user_pseudo_id)  pv_no
        , COUNT(DISTINCT pv_view_table.ga_session_id, pv_view_table.user_pseudo_id)  
            - COUNT(DISTINCT pv_scroll_table.ga_session_id, pv_scroll_table.user_pseudo_id)  pv_yes_scroll_no
        , COUNT(DISTINCT pv_scroll_table.ga_session_id, pv_scroll_table.user_pseudo_id)   pv_yes_scroll_yes
FROM ga 
    LEFT JOIN pv_view_table 
        ON ga.ga_session_id  = pv_view_table.ga_session_id AND ga.user_pseudo_id =pv_view_table.user_pseudo_id
    LEFT JOIN pv_scroll_table
         ON pv_view_table.ga_session_id  = pv_scroll_table.ga_session_id AND pv_view_table.user_pseudo_id =pv_scroll_table.user_pseudo_id


-- 집계하여 조인하는 방식  (어디선가 고려안된 놓친부분이 존재하는거 같음  pv_yes_scroll_no 부분 )
with total_table as (
        SELECT user_pseudo_id
            , COUNT(DISTINCT ga_session_id) as total_cnt
        FROM ga
        GROUP BY user_pseudo_id  
) , pv_view_table as (
        SELECT user_pseudo_id
            , COUNT(DISTINCT  ga_session_id ) pv_yes
        FROM ga
        WHERE page_title = '백문이불여일타 SQL 캠프 입문반'
        AND event_name = 'page_view'
        GROUP BY user_pseudo_id 
) , pv_scroll_table as(
        SELECT user_pseudo_id
            , COUNT(DISTINCT  ga_session_id) sc_cnt
        FROM ga
        WHERE page_title = '백문이불여일타 SQL 캠프 입문반'
        AND event_name ='scroll'
        AND user_pseudo_id IN (SELECT user_pseudo_id FROM pv_view_table )
        GROUP BY user_pseudo_id 
)


SELECT SUM(total_cnt) total
      , SUM(total_cnt) - SUM(pv_yes) pv_no 
      , SUM(pv_yes) - SUM(sc_cnt) pv_yes_scroll_no 
      , SUM(sc_cnt) pv_yes_scroll_yes
FROM total_table
  LEFT JOIN  pv_view_table ON total_table.user_pseudo_id = pv_view_table.user_pseudo_id 
  LEFT JOIN  pv_scroll_table ON pv_view_table.user_pseudo_id = pv_scroll_table.user_pseudo_id2

