WITH
  leases AS (
  SELECT
    *
  FROM
    {{ ref('leases_with_date') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  fiscal_year,
  month,
  address_id,
  COUNT(*) AS count_of_leases_signed
FROM
  leases
GROUP BY
  fiscal_year,
  month,
  address_id
ORDER BY
  count_of_leases_signed DESC