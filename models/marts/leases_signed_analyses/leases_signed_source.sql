WITH
  leases AS (
  SELECT
    *
  FROM
    {{ ref('distinct_leases_signed') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  year_week,
  month,
  fiscal_year,
  month_start,
  lower(source) as source,
  COUNT(*) AS no_of_leases
FROM
  leases
GROUP BY
  id,
  year_week,
  month,
  fiscal_year,
  month_start,
  source
ORDER BY
  no_of_leases DESC