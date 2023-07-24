-- 제출 쿼리
SELECT 
    rent_info.local   AS local
  , COUNT(*) AS all_rent
  , SUM(CASE WHEN rent_info.local = return_info.local THEN 1 END) AS same_local
  , SUM(CASE WHEN rent_info.local != return_info.local THEN 1 END) AS diff_local
FROM rental_history
    INNER JOIN station AS rent_info
      ON rental_history.rent_station_id = rent_info.station_id
        -- 일반적으로 DATE_FORMAT으로 형변환을 해서 처리하는 것보다 RAW로 풀어서 써주는 것이 실행 속도를 개선하는 방법
        AND rental_history.rent_at BETWEEN '2021-01-01 00:00:00' AND '2021-01-31 23:59:59'
    INNER JOIN station AS return_info
      ON rental_history.return_station_id = return_info.station_id
        AND rental_history.return_at BETWEEN '2021-01-01 00:00:00' AND '2021-01-31 23:59:59'
GROUP BY 
    1
ORDER BY
    2 DESC
;

-- 실행 속도 확인을 위해 DATE_FORMAT을 사용해본 쿼리
-- 통과
SELECT 
    rent_info.local   AS local
  , COUNT(*) AS all_rent
  , SUM(CASE WHEN rent_info.local = return_info.local THEN 1 END) AS same_local
  , SUM(CASE WHEN rent_info.local != return_info.local THEN 1 END) AS diff_local
FROM rental_history
      INNER JOIN station AS rent_info
        ON rental_history.rent_station_id = rent_info.station_id
          AND DATE_FORMAT(rental_history.rent_at, '%Y-%m') = '2021-01'
      INNER JOIN station AS return_info
        ON rental_history.return_station_id = return_info.station_id
          AND DATE_FORMAT(rental_history.return_at, '%Y-%m') = '2021-01'
GROUP BY 
    1
ORDER BY
    2 DESC
;


-- 제한시간 초과
SELECT 
    rent_info.local   AS local
  , COUNT(*) AS all_rent
  , SUM(CASE WHEN rent_info.local = rent_info.local THEN 1 END) AS same_local
  , SUM(CASE WHEN rent_info.local != rent_info.local THEN 1 END) AS diff_local
FROM rental_history
    INNER JOIN station AS rent_info
      ON rental_history.rent_station_id = rent_info.station_id
        AND DATE_FORMAT(rental_history.rent_at, '%Y-%m') = '2021-01'
    INNER JOIN station AS return_info
      ON rental_history.return_station_id = return_info.station_id
        AND DATE_FORMAT(rental_history.return_at, '%Y-%m') = '2021-01'
GROUP BY 
    1
;

-- 제한시간 초과
WITH local_info AS (
  SELECT 
      rent_station_id
    , rent_info.local   AS rent_local
    , return_station_id
    , return_info.local AS return_local
  FROM rental_history
      INNER JOIN station AS rent_info
        ON rental_history.rent_station_id = rent_info.station_id
          AND DATE_FORMAT(rental_history.rent_at, '%Y-%m') = '2021-01'
      INNER JOIN station AS return_info
        ON rental_history.return_station_id = return_info.station_id
          AND DATE_FORMAT(rental_history.return_at, '%Y-%m') = '2021-01'
)

SELECT
    rent_local AS local
  , COUNT(DISTINCT rent_station_id) AS all_rent
  , COUNT(DISTINCT 
            CASE WHEN rent_local = return_local 
              THEN rent_station_id 
            END)  AS same_local 
  , COUNT(DISTINCT 
            CASE WHEN rent_local != return_local 
              THEN rent_station_id 
            END) AS diff_local
FROM local_info
GROUP BY 
    1
;
    