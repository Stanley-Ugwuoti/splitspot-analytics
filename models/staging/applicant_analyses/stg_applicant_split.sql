WITH
  customers AS (
  SELECT
    full_date,
    applicant_full_name,
    customer_id,
    SPLIT(apartment_of_interest, ', ')[SAFE_OFFSET(0)] apartment1,
    SPLIT(apartment_of_interest, ', ')[safe_offset(1)] apartment2,
    SPLIT(apartment_of_interest, ', ')[safe_offset(2)] apartment3,
    SPLIT(apartment_of_interest, ', ')[safe_offset(3)] apartment4,
    SPLIT(apartment_of_interest, ', ')[safe_offset(4)] apartment5,
    attended_showing,
    SPLIT(interested_neigbourhoods, ', ')[SAFE_OFFSET(0)] neigbourhoods1,
    SPLIT(interested_neigbourhoods, ', ')[SAFE_OFFSET(1)] neigbourhoods2,
    SPLIT(interested_neigbourhoods, ', ')[SAFE_OFFSET(2)] neigbourhoods3,
    SPLIT(interested_neigbourhoods, ', ')[SAFE_OFFSET(3)] neigbourhoods4,
    SPLIT(interested_neigbourhoods, ', ')[SAFE_OFFSET(4)] neigbourhoods5,
    contact_source,
    optimal_move_in_date,
    date_of_birth,
    est_length_of_stay,
    have_pets,
    SPLIT(ok_living_with_pets_, ', ')[SAFE_OFFSET(0)] pet1,
    SPLIT(ok_living_with_pets_, ', ')[SAFE_OFFSET(1)] pet2,
    monthly_gross_salary
  FROM
    {{ ref('applicant_with_date') }}
)
SELECT
*
FROM
  customers