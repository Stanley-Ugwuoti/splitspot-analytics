  WITH
  applicants AS (
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
  lower(contact_source) as source,
  COUNT(*) AS count_of_applications
FROM
  applicants
GROUP BY
  id,
  year_week,
  month,
  fiscal_year,
  source
ORDER BY
  id DESC