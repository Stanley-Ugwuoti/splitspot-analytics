-- not currently utilized

{{ dbt_utils.unpivot(ref('stg_applicant_split'), cast_to='string', exclude=['full_date','applicant_full_name','customer_id','attended_showing',
'apartment_nyc_1','apartment_nyc_2','apartment_nyc_3','apartment_nyc_4','apartment_nyc_5',
'apartment_boston_1','apartment_boston_2','apartment_boston_3','apartment_boston_4','apartment_boston_5', 
'apartment_seattle_1','apartment_seattle_2','apartment_seattle_3','apartment_seattle_4','apartment_seattle_5',
 'apartment_dc_1','apartment_dc_2','apartment_dc_3','apartment_dc_4','apartment_dc_5',
 'contact_source','optimal_move_in_date','date_of_birth','est_length_of_stay','have_pets','pet1','pet2','monthly_gross_salary']) }}