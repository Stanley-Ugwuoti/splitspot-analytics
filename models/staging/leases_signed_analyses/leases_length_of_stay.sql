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
  intended_length_of_stay,
  COUNT(*) AS no_of_leases
FROM
  leases
GROUP BY
  id,
  month,
  fiscal_year,
  intended_length_of_stay
ORDER BY
  no_of_leases DESC