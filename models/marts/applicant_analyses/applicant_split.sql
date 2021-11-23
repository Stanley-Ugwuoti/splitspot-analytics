WITH
  customers AS (
  SELECT
    full_date,
    applicant_full_name,
    customer_id,
    SPLIT(apartment_of_interest_boston, ', ')[SAFE_OFFSET(0)] apartment_boston_1,
    SPLIT(apartment_of_interest_boston, ', ')[SAFE_OFFSET(1)] apartment_boston_2,
    SPLIT(apartment_of_interest_boston, ', ')[SAFE_OFFSET(2)] apartment_boston_3,
    SPLIT(apartment_of_interest_boston, ', ')[SAFE_OFFSET(3)] apartment_boston_4,
    SPLIT(apartment_of_interest_boston, ', ')[SAFE_OFFSET(4)] apartment_boston_5,

    SPLIT(apartment_of_interest_nyc, ', ')[SAFE_OFFSET(0)] apartment_nyc_1,
    SPLIT(apartment_of_interest_nyc, ', ')[SAFE_OFFSET(1)] apartment_nyc_2,
    SPLIT(apartment_of_interest_nyc, ', ')[SAFE_OFFSET(2)] apartment_nyc_3,
    SPLIT(apartment_of_interest_nyc, ', ')[SAFE_OFFSET(3)] apartment_nyc_4,
    SPLIT(apartment_of_interest_nyc, ', ')[SAFE_OFFSET(4)] apartment_nyc_5,

    SPLIT(apartment_of_interest_dc, ', ')[SAFE_OFFSET(0)] apartment_dc_1,
    SPLIT(apartment_of_interest_dc, ', ')[SAFE_OFFSET(1)] apartment_dc_2,
    SPLIT(apartment_of_interest_dc, ', ')[SAFE_OFFSET(2)] apartment_dc_3,
    SPLIT(apartment_of_interest_dc, ', ')[SAFE_OFFSET(3)] apartment_dc_4,
    SPLIT(apartment_of_interest_dc, ', ')[SAFE_OFFSET(4)] apartment_dc_5,

    SPLIT(apartment_of_interest_seattle, ', ')[SAFE_OFFSET(0)] apartment_seattle_1,
    SPLIT(apartment_of_interest_seattle, ', ')[SAFE_OFFSET(1)] apartment_seattle_2,
    SPLIT(apartment_of_interest_seattle, ', ')[SAFE_OFFSET(2)] apartment_seattle_3,
    SPLIT(apartment_of_interest_seattle, ', ')[SAFE_OFFSET(3)] apartment_seattle_4,
    SPLIT(apartment_of_interest_seattle, ', ')[SAFE_OFFSET(4)] apartment_seattle_5,

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