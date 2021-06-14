WITH
  applications AS (
  SELECT
    *
  FROM
    {{ ref('applicant_unpivot_apartment_with_date') }}
  WHERE
    address_id IS NOT NULL )
SELECT
  fiscal_year,
  month,
  address_id,
  COUNT(*) AS count_of_applications
FROM
  applications
GROUP BY
  fiscal_year,
  month,
  address_id
ORDER BY
  count_of_applications DESC