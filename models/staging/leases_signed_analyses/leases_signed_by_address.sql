  {{ config(materialized='table', sort='timestamp', dist='user_id') }}

  WITH
  leases AS (
  SELECT
    *
  FROM
    {{ ref('leases_with_date') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  year_week,
  fiscal_year,
  address_id,
  COUNT(*) AS count_of_leases_signed
FROM
  leases
GROUP BY
  id,
  year_week,
  fiscal_year,
  address_id
ORDER BY
  id DESC