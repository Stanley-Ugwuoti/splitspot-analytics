{{ config(materialized='table', sort='timestamp', dist='user_id') }}


WITH
  applications AS (
  SELECT
    *
  FROM
    {{ ref('applicant_unpivot_apartment_with_date') }}
  WHERE
    address_id IS NOT NULL )
SELECT
  id,
  year_week,
  month,
  fiscal_year,
  address_id,
  COUNT(*) AS count_of_applications
FROM
  applications
GROUP BY
  id,
  year_week,
  month,
  fiscal_year,
  address_id
ORDER BY
  count_of_applications DESC