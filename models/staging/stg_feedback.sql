SELECT
full_date,		
email_address as customer_id,		
full_name,
apartment_name as address_id,		
intended_move_out_date,		
_4_month_notice as four_month_notice,		
reson_for_ending_lease as reason_for_termination,		
interested_in_other_splitspot_rooms,
moving_out_agreement,		
positive_feedback,		
rating,
room_letter,	
critical_feedback

FROM
 {{source('model','feedback_form')}}
WHERE email_address IS NOT NULL
ORDER BY full_date DESC