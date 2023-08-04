with t1 as (
SELECT   page_location
      , SUBSTRING(page_location , LOCATE('content=', page_location)) content
FROM ga
WHERE event_name = 'page_view'
AND source = 'brunch'
AND page_title IN ('백문이불여일타 SQL 캠프 실전반' , '백문이불여일타 SQL 캠프 심화반')
AND LOCATE('content=', page_location) > 0 
)


SELECT DISTINCT 
       REPLACE(content , 'content=','') content
       , page_location
FROM t1
