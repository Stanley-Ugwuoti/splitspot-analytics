-- applications submitted by leads through google forms
-- customer_id granularity
WITH
  customers AS (
  SELECT
    DATE(application_date) AS full_date,
    applicant_full_name,
    lower(applicant_email) as customer_id,
    lower(apartment_of_interest) as apartment_of_interest,
    attended_showing,
    lower(interested_neigbourhoods) as interested_neigbourhoods,
    lower(contact_source) as contact_source,
    DATE(optimal_move_in_date) as optimal_move_in_date,
    ABS(DATE_DIFF(DATE (optimal_move_in_date), DATE (application_date), DAY)) as duration_till_optimal_move_in,
    ABS(DATE_DIFF(CURRENT_DATE(), DATE (applicant_birth_date), YEAR)) as age,
    DATE(applicant_birth_date) as date_of_birth,
    est_length_of_stay,
    pets_ as have_pets,
    lower(ok_living_with_pets_) as ok_living_with_pets_,
    SAFE_CAST(monthly_gross_salary AS NUMERIC) as monthly_gross_salary
  FROM
    `natural-rider-307113.customer.applications_response_import`
  WHERE
    application_date IS NOT NULL)
select * from customers