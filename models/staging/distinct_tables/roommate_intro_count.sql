{{ config(materialized='table', sort='timestamp', dist='user_id') }}

  WITH
  leases_sent AS (
  SELECT
    *
  FROM
    {{ ref('distinct_roommate_intro') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  month,
  fiscal_year,
  customer_id,
  COUNT(*) AS roommate_intro
FROM
  leases_sent
GROUP BY
  id,
  month,
  fiscal_year,
  customer_id
ORDER BY
  id DESC