SELECT
  ROUND(
    1.0 * COUNT(CASE WHEN texts.signup_action = 'Confirmed' THEN 1 END)
    / COUNT(emails.user_id)
    , 2
  ) AS confirm_rate
FROM emails
INNER JOIN texts ON emails.email_id = texts.email_id
;
