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
  month,
  lower(contact_source) as source,
  COUNT(*) AS count_of_applications
FROM
  applicants
GROUP BY
  fiscal_year,
  month,
  source
ORDER BY
  count_of_applications DESC