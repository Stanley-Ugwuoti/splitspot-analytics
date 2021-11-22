{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  id,
  year_week,
  month,
  fiscal_year,
  address_id,
  SUM(users) AS users,
  SUM(entrances) AS entrances,
  SUM(unique_pageviews) AS unique_pageviews
FROM
  {{ ref('webstats_with_date') }}
--WHERE
  --year_week = 14
GROUP BY
  id,
  month,
  year_week,
  fiscal_year,
  address_id
ORDER BY
  unique_pageviews DESC