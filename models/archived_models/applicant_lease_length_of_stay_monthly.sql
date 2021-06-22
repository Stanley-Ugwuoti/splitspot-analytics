{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(applications.fiscal_year,
    leases_signed.fiscal_year) AS fiscal_year,
  COALESCE(applications.month,
    leases_signed.month) AS month,
  COALESCE(applications.intended_length_of_stay,
    leases_signed.intended_length_of_stay) AS intended_length_of_stay,
  IFNULL(applications.count_of_applicants,
    0) AS no_of_applicants,
  IFNULL(leases_signed.no_of_leases,
    0) AS no_of_leases,

FROM
  {{ ref('applications_length_of_stay_monthly') }} AS applications
FULL JOIN
  {{ ref('leases_summary_length_of_stay_monthly') }} AS leases_signed
ON
  applications.month = leases_signed.month
  AND applications.fiscal_year = leases_signed.fiscal_year
  AND applications.intended_length_of_stay = leases_signed.intended_length_of_stay
