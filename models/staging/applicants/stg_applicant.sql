-- applications submitted by leads through google forms
-- customer_id granularity
WITH
  customers AS (
  SELECT
    DATE(application_date) AS full_date,
    applicant_full_name,
    lower(applicant_email) as customer_id,
    lower(apartment_of_interest) as apartment_of_interest,
    lower(apartment_of_interest) as apartment_of_interest_boston,
    lower(apartment_of_interest_nyc) as apartment_of_interest_nyc,
    lower(apartment_of_interest_dc) as apartment_of_interest_dc,
    lower(apartment_of_interest_seattle) as apartment_of_interest_seattle,
    attended_showing,
    LOWER(COALESCE(NULLIF(interested_neigbourhoods,""),NULLIF(metro_area_of_interest_,""))) as metro_area_of_interest,
    LOWER(interested_neigbourhoods) as interested_neigbourhoods,
    LOWER(metro_area_of_interest_) as metro_area_of_interest_,
    lower(contact_source) as contact_source,
    DATE(optimal_move_in_date) as optimal_move_in_date,
    ABS(DATE_DIFF(DATE (optimal_move_in_date), DATE (application_date), DAY)) as duration_till_optimal_move_in,
    ABS(DATE_DIFF(CURRENT_DATE(), DATE (applicant_birth_date), YEAR)) as age,
    DATE(applicant_birth_date) as date_of_birth,
    est_length_of_stay,
    pets_ as have_pets,
    lower(ok_living_with_pets_) as ok_living_with_pets_,
    SAFE_CAST(monthly_gross_salary AS NUMERIC) as monthly_gross_salary,
    lower(occupation) as occupation,
  FROM
    {{source('customer','applications_response_import')}}
  WHERE
    application_date IS NOT NULL)
select * from customers