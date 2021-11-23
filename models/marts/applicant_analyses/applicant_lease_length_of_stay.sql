{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(applications.id,
    leases_signed.id) AS full_date,
  COALESCE(applications.year_week,
    leases_signed.year_week) AS year_week,
  COALESCE(applications.month,
    leases_signed.month) AS month, 
  COALESCE(applications.intended_length_of_stay,
    leases_signed.intended_length_of_stay) AS intended_length_of_stay,
  IFNULL(applications.count_of_applicants,
    0) AS no_of_applicants,
  IFNULL(leases_signed.no_of_leases,
    0) AS no_of_leases,

FROM
  {{ ref('applications_length_of_stay') }} AS applications
FULL JOIN
  {{ ref('leases_length_of_stay') }} AS leases_signed
ON
  applications.id = leases_signed.id
  AND applications.intended_length_of_stay = leases_signed.intended_length_of_stay
