-- detailed profile about all leads

{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(lead_timeline.applications_date,
    lead_timeline.rsvps_date) AS full_date,

  COALESCE(lead_timeline.customer_id,
    buildium_data.customer_id) AS customer_id,

  buildium_data.full_name,

  lead_timeline.duration_till_optimal_move_in,
  lead_timeline.age,
  lead_timeline.occupation,
  lead_timeline.apartment_of_interest,
  lead_timeline.applications_date,
  lead_timeline.application_source,
  lead_timeline.application_length_of_stay as applications_intended_length_of_stay,
  lead_timeline.rsvps_date,
  lead_timeline.event_type,
  lead_timeline.roommate_introductions_date,
  lead_timeline.leases_sent_date,
  lead_timeline.lease_sent_address,
  lead_timeline.room_letter,
  lead_timeline.rent_per_month,
  lead_timeline.leases_signed_date,
  lead_timeline.lease_signed_address,

  lead_timeline.wait_period,
  lead_timeline.lease_source,
  lead_timeline.conversion_duration,
  lead_timeline.lease_length_of_stay as lease_intended_rent_duration,

  buildium_data.leaseid,
  buildium_data.address_id as buildium_address,
  buildium_data.rent_fee,
  buildium_data.room_id,
  buildium_data.status,
  buildium_data.start_date,
 -- buildium_data.end_date as buildium_end_date,
  buildium_data.projected_end_date as actual_end_date,
  buildium_data.rent_duration as buildium_rent_duration,
  buildium_data.rent_type,

FROM
  `natural-rider-307113`.`dbt_kamalsplitspot`.`lead_timeline` as lead_timeline
FULL JOIN  `natural-rider-307113`.`dbt_kamalsplitspot`.`buildium_tenancy` AS buildium_data
ON
  lead_timeline.customer_id = buildium_data.customer_id
