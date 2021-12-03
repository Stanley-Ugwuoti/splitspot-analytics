WITH
  roommate_intro AS (
  SELECT
    *
  FROM
    {{ ref('roommate_intro_with_date') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  fiscal_year,
  month,
  address_id,
  COUNT(*) AS roommate_intro
FROM
  roommate_intro
GROUP BY
  fiscal_year,
  month,
  address_id
ORDER BY
  roommate_intro DESC