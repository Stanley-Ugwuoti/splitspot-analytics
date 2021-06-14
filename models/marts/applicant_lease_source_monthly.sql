{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(applications.fiscal_year,
    leases_signed.fiscal_year) AS fiscal_year,
  COALESCE(applications.month,
    leases_signed.month) AS month,
  COALESCE(applications.source,
    leases_signed.source) AS contact_source,
  IFNULL(leases_signed.no_of_leases,
    0) AS no_of_leases,
  IFNULL(applications.count_of_applications,
    0) AS applications,
FROM
  {{ ref('applicant_source_monthly') }} AS applications
FULL JOIN
  {{ ref('leases_signed_source_monthly') }} AS leases_signed
ON
  applications.month = leases_signed.month
  AND applications.fiscal_year = leases_signed.fiscal_year
  AND applications.source = leases_signed.source