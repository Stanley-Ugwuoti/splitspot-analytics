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
  month,
  lower(source) as source,
  COUNT(*) AS no_of_leases
FROM
  leases
GROUP BY
  fiscal_year,
  month,
  source
ORDER BY
  no_of_leases DESC