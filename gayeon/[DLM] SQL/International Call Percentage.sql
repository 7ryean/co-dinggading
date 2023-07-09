-- SUM 사용
-- COUNT에 비해 성능이 더 좋은가?
SELECT 
    ROUND(
        SUM(
            CASE WHEN caller_phone_info.country_id != reciever_phone_info.country_id
            THEN 1 END
        )::DECIMAL / SUM(1) * 100, 1
    ) AS international_calls_pct
FROM 
    phone_calls
    INNER JOIN phone_info AS caller_phone_info
      ON phone_calls.caller_id = caller_phone_info.caller_id
    INNER JOIN phone_info AS reciever_phone_info
      ON phone_calls.receiver_id = reciever_phone_info.caller_id
;

-- COUNT 사용
-- SUM과 성능 차이가 있는가? 성능 차이가 없다면 COUNT를 사용하는게 쿼리 로직 자체를 이해하기에는 더 간편한 느낌..? SUM()은 뭔가 정제되어 있는 느낌
SELECT 
    ROUND(
        COUNT(
            CASE WHEN caller_phone_info.country_id != reciever_phone_info.country_id
            THEN phone_calls.caller_id END
        )::DECIMAL / COUNT(phone_calls.caller_id) * 100, 1
    ) AS international_calls_pct
FROM 
    phone_calls
    INNER JOIN phone_info AS caller_phone_info
      ON phone_calls.caller_id = caller_phone_info.caller_id
    INNER JOIN phone_info AS reciever_phone_info
      ON phone_calls.receiver_id = reciever_phone_info.caller_id
;
