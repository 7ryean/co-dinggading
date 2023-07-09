WITH info_caller_receivers AS (
SELECT 
    c_pi.caller_id AS caller,
    c_pi.country_id as callers_country,
    r_pi.caller_id as receiver,
    r_pi.country_id as receivers_country
FROM 
  phone_calls pc
  JOIN phone_info c_pi on c_pi.caller_id = pc.caller_id
  JOIN phone_info r_pi on r_pi.caller_id = pc.receiver_id
)

SELECT 
  ROUND(1.0 * SUM(CASE WHEN callers_country <> receivers_country 
  THEN 1
  END) / COUNT(*) * 100, 1)
FROM 
  info_caller_receivers
;
