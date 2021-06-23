{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(applications.id,
    leases_signed.id) AS full_date,
  COALESCE(applications.year_week,
    leases_signed.year_week) AS year_week,
  COALESCE(applications.month,
    leases_signed.month) AS month, 
  COALESCE(applications.neighbourhood,
    leases_signed.neighbourhood) AS neighbourhood,
  IFNULL(applications.count_of_applications,
    0) AS no_of_applicants,
  IFNULL(leases_signed.no_of_leases,
    0) AS no_of_leases,

FROM
  {{ ref('neighbourhood_aggregation') }} AS applications
FULL JOIN
  {{ ref('leases_neighbourhood') }} AS leases_signed
ON
  applications.id = leases_signed.id
  AND applications.neighbourhood = leases_signed.neighbourhood
