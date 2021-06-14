{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(applications.id, leases_signed.id,leases_sent.id,roommate.id,rsvps.id) as full_date,
  COALESCE(applications.customer_id,leases_signed.customer_id,leases_sent.customer_id,roommate.customer_id,rsvps.customer_id) as customer_id,
  IFNULL(applications.count_of_applications,0) as applications,
  IFNULL(rsvps.count_of_rsvps,0) as rsvps,
  IFNULL(roommate.roommate_intro,0) as roommate_introductions,
  IFNULL(leases_sent.leases_sent,0) as leases_sent,
  IFNULL(leases_signed.count_of_leases_signed,0) as leases_signed,
FROM
  {{ ref('applicants_count') }} AS applications
FULL JOIN  {{ ref('leases_sent_count') }} AS leases_sent
ON
  applications.customer_id = leases_sent.customer_id
  AND
  applications.id = leases_sent.id

FULL JOIN  {{ ref('leases_signed_count') }} AS leases_signed
ON
  applications.customer_id = leases_signed.customer_id
  AND
  applications.id = leases_signed.id

FULL JOIN  {{ ref('roommate_intro_count') }} AS roommate
ON
  applications.customer_id = roommate.customer_id
  AND
  applications.id = roommate.id

FULL JOIN  {{ ref('rsvps_count') }} AS rsvps
ON
  applications.customer_id = rsvps.customer_id
  AND
  applications.id = rsvps.id


