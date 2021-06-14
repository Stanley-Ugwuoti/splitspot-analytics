-- weekly granularity
WITH
  leases AS (
  SELECT
    *
  FROM
    {{ ref('distinct_leases_signed') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  fiscal_year,
  year_week,
  intended_length_of_stay,
  COUNT(*) AS no_of_leases
FROM
  leases
GROUP BY
  fiscal_year,
  year_week,
  intended_length_of_stay
ORDER BY
  no_of_leases DESC