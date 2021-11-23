{{ config(materialized='table', sort='timestamp', dist='user_id') }}

  WITH
  leases_sent AS (
  SELECT
    *
  FROM
    {{ ref('distinct_leases_sent') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  year_week,
  month,
  fiscal_year,
  customer_id,
  COUNT(*) AS leases_sent
FROM
  leases_sent
GROUP BY
  id,
  year_week,
  month,
  fiscal_year,
  customer_id
ORDER BY
  id DESC