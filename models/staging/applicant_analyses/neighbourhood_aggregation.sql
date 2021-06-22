{{ config(materialized='table', sort='timestamp', dist='user_id') }}


WITH
  applications AS (
  SELECT
    *
  FROM
    {{ ref('applicant_unpivot_neighbourhood_with_date') }}
  WHERE
    neighbourhood IS NOT NULL )
SELECT
  id,
  year_week,
  month,
  fiscal_year,
  neighbourhood,
  COUNT(*) AS count_of_applications
FROM
  applications
GROUP BY
  id,
  year_week,
  month,
  fiscal_year,
  neighbourhood
ORDER BY
  count_of_applications DESC