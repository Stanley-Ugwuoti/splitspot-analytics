-- detailed profile about all leads

{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  COALESCE(lead_timeline.applications_date,
    lead_timeline.rsvps_date) AS full_date,

  COALESCE(lead_timeline.customer_id,
    buildium_data.customer_id, stg_feedback.customer_id ) AS customer_id,

  buildium_data.full_name,

  lead_timeline.duration_till_optimal_move_in,
  lead_timeline.age,

  CASE WHEN age > 30 THEN 'Above 30'
    WHEN age > 25 THEN '26-30'
    WHEN age > 22 THEN '22-25'
    WHEN age > 17 THEN '18-22'
 END
  AS age_category,

  lead_timeline.occupation,
  lead_timeline.apartment_of_interest,
  lead_timeline.applications_date,
  lead_timeline.application_source,
  lead_timeline.application_length_of_stay as applications_intended_length_of_stay,

  CASE WHEN lead_timeline.application_length_of_stay = '3 Months (summer only)'  THEN '3'
    WHEN lead_timeline.application_length_of_stay = '4 Months'  THEN '4'
    WHEN lead_timeline.application_length_of_stay = '5 Months'  THEN '5'
    WHEN lead_timeline.application_length_of_stay = '6 Months'  THEN '6'
    WHEN lead_timeline.application_length_of_stay = '7 Months'  THEN '7'
    WHEN lead_timeline.application_length_of_stay = '8 Months'  THEN '8'
    WHEN lead_timeline.application_length_of_stay = '9 Months'  THEN '9'
    WHEN lead_timeline.application_length_of_stay = '10 Months'  THEN '10'
    WHEN lead_timeline.application_length_of_stay = '11 Months'  THEN '11'
    WHEN lead_timeline.application_length_of_stay = '12+ Months'  THEN '12'
       
    ELSE 'Not Specified' END
  AS estimated_rent_period,

  CASE WHEN lead_timeline.application_length_of_stay = '3 Months (summer only)'  THEN '3-5 months'
    WHEN lead_timeline.application_length_of_stay = '4 Months'  THEN '3-5 months'
    WHEN lead_timeline.application_length_of_stay = '5 Months'  THEN '3-5 months'
    WHEN lead_timeline.application_length_of_stay = '6 Months'  THEN '6-9 months'
    WHEN lead_timeline.application_length_of_stay = '7 Months'  THEN '6-9 months'
    WHEN lead_timeline.application_length_of_stay = '8 Months'  THEN '6-9 months'
    WHEN lead_timeline.application_length_of_stay = '9 Months'  THEN '6-9 months'
    WHEN lead_timeline.application_length_of_stay = '10 Months'  THEN '10 months and above'
    WHEN lead_timeline.application_length_of_stay = '11 Months'  THEN '10 months and above'
    WHEN lead_timeline.application_length_of_stay = '12+ Months'  THEN '10 months and above'
       
    ELSE 'Not Specified' END
  AS estimated_rent_period_category,

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

  CASE WHEN wait_period > 90 THEN 'over 3 months'
    WHEN wait_period > 60 THEN '2-3 months'
    WHEN wait_period > 30 THEN '1-2 months'
    WHEN wait_period > 10 THEN '11-29 days'
    WHEN wait_period < 10 THEN '0-10'
    ELSE 'Not Specified' END
  AS wait_period_category,

  lead_timeline.lease_source,
  lead_timeline.conversion_duration,

  CASE WHEN conversion_duration > 30 THEN '30+ days'
    WHEN conversion_duration > 20 THEN '21-30'
    WHEN conversion_duration > 15 THEN '16-20'
    WHEN conversion_duration > 10 THEN '11-15'
    WHEN conversion_duration > 5 THEN '5-10'
    WHEN conversion_duration > 0 THEN '1-5'
    ELSE 'Not Specified' END
  AS conversion_duration_category,

  lead_timeline.lease_length_of_stay as lease_intended_rent_duration,

  buildium_data.leaseid,
  buildium_data.address_id as buildium_address,
  buildium_data.rent_fee,
  buildium_data.room_id,
  buildium_data.status,
  buildium_data.start_date,
  buildium_data.end_date as buildium_end_date,
  buildium_data.projected_end_date as actual_end_date,
  buildium_data.rent_duration as buildium_rent_duration,

  CASE WHEN buildium_data.rent_duration > 10 THEN '10 months and above'
    WHEN buildium_data.rent_duration > 5 THEN '6-9 months'
    WHEN buildium_data.rent_duration < 6 THEN '3-5 months'

    ELSE 'Not Specified' END

      AS buildium_rent_duration_category,

buildium_data.rent_type,

stg_feedback.full_date as notice_date,		
stg_feedback.address_id as notice_address,		
stg_feedback.intended_move_out_date,		
stg_feedback.four_month_notice,		
stg_feedback.reason_for_termination,		
stg_feedback.interested_in_other_splitspot_rooms,
stg_feedback.moving_out_agreement,		
stg_feedback.positive_feedback,		
stg_feedback.rating,
stg_feedback.critical_feedback

FROM
{{ ref('lead_timeline') }} as lead_timeline
FULL JOIN {{ ref('buildium_tenancy') }} AS buildium_data
ON
  lead_timeline.customer_id = buildium_data.customer_id

FULL JOIN {{ ref('stg_feedback') }} AS stg_feedback
ON
  lead_timeline.customer_id = stg_feedback.customer_id
