{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT

  COALESCE(applications.id,
    leases_signed.id) AS full_date,
  COALESCE(applications.source,
    leases_signed.source) AS contact_source,
  IFNULL(leases_signed.no_of_leases,
    0) AS no_of_leases,
  IFNULL(applications.count_of_applications,
    0) AS applications,
FROM
  {{ ref('applicant_source') }} AS applications
FULL JOIN
  {{ ref('leases_signed_source') }} AS leases_signed
ON
  applications.id = leases_signed.id
  AND applications.source = leases_signed.source