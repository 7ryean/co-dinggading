WITH  rent_info as (
    SELECT  bike_id,
      rent_station_id,
      return_station_id
    FROM  rental_history
    WHERE date_format(rent_at, '%y.%m') = '21.01'
  )

SELECT r1.local       as local 
      , COUNT(*)      as all_rent
      , COUNT( CASE WHEN  r1.local = r2.local THEN bike_id END )      as same_local
      , COUNT( CASE WHEN  r1.local <> r2.local THEN bike_id END )     as diff_local
FROM rent_info 
  INNER join station r1  ON rent_info.rent_station_id = r1.station_id 
  INNER join station r2  ON rent_info.return_station_id = r2.station_id 
GROUP BY 1
ORDER BY 2
 