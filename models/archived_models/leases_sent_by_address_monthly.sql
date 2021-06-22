WITH
  leases_sent AS (
  SELECT
    *
  FROM
    {{ ref('leases_sent_with_date') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  fiscal_year,
  address_id,
  month,
  COUNT(*) AS leases_sent
FROM
  leases_sent
GROUP BY
  fiscal_year,
  month,
  address_id
ORDER BY
  leases_sent DESC