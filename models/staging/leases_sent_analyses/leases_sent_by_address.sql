{{ config(materialized='table', sort='timestamp', dist='user_id') }}

  WITH
  leases_sent AS (
  SELECT
    *
  FROM
    {{ ref('leases_sent_with_date') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  year_week,
  fiscal_year,
  address_id,
  COUNT(*) AS leases_sent
FROM
  leases_sent
GROUP BY
  id,
  year_week,
  fiscal_year,
  address_id
ORDER BY
  id DESC