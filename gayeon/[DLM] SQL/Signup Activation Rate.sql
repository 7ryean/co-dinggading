SELECT
    ROUND(COUNT(texts.email_id)::DECIMAL 
          / COUNT(DISTINCT emails.email_id), 2) AS confirm_rate
FROM emails
    LEFT JOIN texts
      ON emails.email_id = texts.email_id
      AND texts.signup_action = 'Confirmed'
;