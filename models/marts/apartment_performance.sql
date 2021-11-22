{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(applications.fiscal_year,leases_signed.fiscal_year,leases_sent.fiscal_year,roommate.fiscal_year,webstats.fiscal_year) as fiscal_year,
  COALESCE(applications.year_week, leases_signed.year_week,leases_sent.year_week,roommate.year_week,webstats.year_week) as year_week,
  COALESCE(applications.month, leases_signed.month,leases_sent.month, roommate.month, webstats.month) as month,
  COALESCE(applications.id, leases_signed.id,leases_sent.id,roommate.id,webstats.id) as full_date,
  COALESCE(applications.address_id,leases_signed.address_id,leases_sent.address_id,roommate.address_id,webstats.address_id) as address_id,
  IFNULL(webstats.unique_pageviews,0) as unique_pageviews,
  IFNULL(webstats.entrances,0) as entrances,
  IFNULL(webstats.users,0) as users,
  IFNULL(applications.count_of_applications,0) as applications,
  IFNULL(roommate.roommate_intro,0) as roommate_introductions,
  IFNULL(leases_sent.leases_sent,0) as leases_sent,
  IFNULL(leases_signed.count_of_leases_signed,0) as leases_signed,
FROM
  {{ ref('applications_address') }} AS applications
FULL JOIN  {{ ref('leases_sent_by_address') }} AS leases_sent
ON
  applications.address_id = leases_sent.address_id
  AND
  applications.id = leases_sent.id

FULL JOIN  {{ ref('leases_signed_by_address') }} AS leases_signed
ON
  applications.address_id = leases_signed.address_id
  AND
  applications.id = leases_signed.id

FULL JOIN  {{ ref('roommate_intro_by_address') }} AS roommate
ON
  applications.address_id = roommate.address_id
  AND
  applications.id = roommate.id

FULL JOIN  {{ ref('webstats') }} AS webstats
ON
  applications.address_id = webstats.address_id
  AND
  applications.id = webstats.id


