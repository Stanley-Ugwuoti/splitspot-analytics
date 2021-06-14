WITH
  applicants AS (
  SELECT
    *
  FROM
    {{ ref('distinct_applicants') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  fiscal_year,
  year_week,
  lower(contact_source) as source,
  COUNT(*) AS count_of_applications
FROM
  applicants
GROUP BY
  year_week,
  fiscal_year,
  source
ORDER BY
  count_of_applications DESC