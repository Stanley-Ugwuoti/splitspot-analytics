SELECT
  fiscal_year,
  month,
  address_id,
  SUM(users) AS users,
  SUM(entrances) AS entrances,
  SUM(unique_pageviews) AS unique_pageviews
FROM
  {{ ref('webstats_with_date') }}
--WHERE
  --year_week = 14
GROUP BY
  fiscal_year,
  month,
  address_id
ORDER BY
  unique_pageviews DESC