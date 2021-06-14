
WITH
  applications AS (
  SELECT
    *
  FROM
    {{ ref('distinct_applicants') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  month,
  fiscal_year,
  lower(est_length_of_stay) as intended_length_of_stay,
  COUNT(*) AS count_of_applicants
FROM
  applications
GROUP BY
  id,
  month,
  fiscal_year,
  intended_length_of_stay
ORDER BY
  id DESC