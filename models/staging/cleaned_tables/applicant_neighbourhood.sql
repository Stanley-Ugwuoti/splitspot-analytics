-- apartments applied to by applicants
-- address_id granularity
WITH
  applicant_apartment AS (
  SELECT
    full_date,
    applicant_full_name,
    REPLACE(value,' ','-') AS neighbourhood,
    customer_id,
  FROM
    {{ ref('applicant_unpivot_neighbourhood_with_date') }}
  WHERE
    full_date IS NOT NULL)
SELECT
  *
FROM
  applicant_apartment
ORDER BY full_date DESC