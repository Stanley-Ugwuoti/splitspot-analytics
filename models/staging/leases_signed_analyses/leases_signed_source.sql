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
  month,
  fiscal_year,
  lower(source) as source,
  COUNT(*) AS no_of_leases
FROM
  leases
GROUP BY
  id,
  month,
  fiscal_year,
  source
ORDER BY
  no_of_leases DESC