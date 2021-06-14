{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(applications.customer_id,leases_signed.customer_id,leases_sent.customer_id,roommate.customer_id,rsvps.customer_id) as customer_id,
  applications.id as applications,
  rsvps.id as rsvps,
  roommate.id as roommate_introductions,
  leases_sent.id as leases_sent,
  leases_signed.id as leases_signed,
FROM
  {{ ref('distinct_applicants') }} AS applications
FULL JOIN  {{ ref('distinct_leases_sent') }} AS leases_sent
ON
  applications.customer_id = leases_sent.customer_id

FULL JOIN  {{ ref('distinct_leases_signed') }} AS leases_signed
ON
  applications.customer_id = leases_signed.customer_id

FULL JOIN  {{ ref('distinct_roommate_intro') }} AS roommate
ON
  applications.customer_id = roommate.customer_id

FULL JOIN  {{ ref('distinct_rsvps') }} AS rsvps
ON
  applications.customer_id = rsvps.customer_id


