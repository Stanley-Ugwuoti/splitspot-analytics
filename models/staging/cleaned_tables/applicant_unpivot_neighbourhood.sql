-- not currently utilized

{{ dbt_utils.unpivot(ref('stg_applicant_split'), cast_to='string', exclude=['full_date','applicant_full_name','customer_id','attended_showing','apartment1','apartment2','apartment3','apartment4','apartment5','contact_source','optimal_move_in_date','date_of_birth','est_length_of_stay','have_pets','pet1','pet2','monthly_gross_salary']) }}