WITH station_info as (
  SELECT station_id 
        , name
        , RADIANS(lat)  as lat
        , RADIANS(lng)  as lng
        , updated_at
  FROM station
)


SELECT st1_station_id
      , st1_name
FROM 
( 
    SELECT * 
        ,( x1 + y1 ) * 2 * 6356
    FROM (
        SELECT st1.station_id          as st1_station_id
            , st1.name                 as st1_name
            , st2.station_id           as st2_station_id
            , st2.name                 as st2_name
            , ( sin(( st1.lat - st2.lat) /2 )  *  sin(( st1.lat - st2.lat) /2 ) )  x1
            , (cos(st1.lat) *cos(st2.lat)  *   ( sin( (st1.lng - st2.lng) /2 ) * sin( (st1.lng - st2.lng) /2 )) )  y1
        FROM station_info st1
        CROSS JOIN station_info st2
        WHERE st1.station_id <> st2.station_id
        AND  st1.updated_at < st2.updated_at
    ) a
    WHERE ( x1 + y1 ) * 2 * 6356 <= 0.3 
) b 
GROUP BY 1, 2
HAVING COUNT(st2_name) >= 5
LIMIT 10