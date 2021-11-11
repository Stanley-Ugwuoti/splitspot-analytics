{{ config(materialized='table', sort='timestamp', dist='user_id') }}
SELECT
  COALESCE(applications.customer_id,leases_signed.customer_id,leases_sent.customer_id,roommate.customer_id,rsvps.customer_id) as customer_id,
  applications.id as applications_date,
  applications.contact_source as application_source, 
  applications.duration_till_optimal_move_in,
  applications.age,
  applications.apartment_of_interest_boston,
  applications.apartment_of_interest_nyc,
  applications.apartment_of_interest_seattle,
  applications.apartment_of_interest_dc,
  applications.est_length_of_stay as application_length_of_stay,
  applications.occupation,

  rsvps.id as rsvps_date,
  rsvps.event_type,
  roommate.id as roommate_introductions_date,
  leases_sent.id as leases_sent_date,
  leases_sent.address_id as lease_sent_address,
  leases_sent.room_letter,
  leases_sent.rent_per_month,
  leases_signed.id as leases_signed_date,
  leases_signed.address_id as lease_signed_address,
  --leases_signed.duration_of_lease_signed_to_movein as wait_period,
  leases_signed.source as lease_source,
  leases_signed.application_to_lease_duration as conversion_duration,
  leases_signed.intended_length_of_stay as lease_length_of_stay,

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


