{{ config(materialized='table', sort='timestamp', dist='user_id') }}

  WITH
  leases_sent AS (
  SELECT
    *
  FROM
    {{ ref('distinct_applicants') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  year_week,
  month,
  fiscal_year,
  customer_id,
  COUNT(*) AS count_of_applications
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