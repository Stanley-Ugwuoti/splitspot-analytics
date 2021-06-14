WITH
  applications AS (
  SELECT
    *
  FROM
    {{ ref('distinct_applicants') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  fiscal_year,
  year_week,
  lower(est_length_of_stay) as intended_length_of_stay,
  COUNT(*) AS count_of_applicants
FROM
  applications
GROUP BY
  fiscal_year,
  year_week,
  intended_length_of_stay
ORDER BY
  count_of_applicants DESC