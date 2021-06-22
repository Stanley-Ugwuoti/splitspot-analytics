-- all splitspot leases signed
-- customer granularity
WITH
  leases AS (
  SELECT
    name AS full_name,
    LOWER(email_address) AS customer_id,
    DATE(date_signed) AS full_date,
    LOWER(REPLACE(apartment_,' ','-')) AS address_id,
    DATE(move_in_date) AS move_in_date,
    DATE_DIFF(DATE (move_in_date), DATE (date_signed), DAY) as duration_of_lease_signed_to_movein,
    LOWER(source) AS source,
    LOWER(showing) AS showing,
    days_since_application AS application_to_lease_duration,
    LOWER(intended_length_of_stay) AS intended_length_of_stay,
    LOWER(neighbourhood) as city_neighbourhood,
    REPLACE(SPLIT(LOWER(neighbourhood), ' - ')[SAFE_OFFSET(1)], ' ', '-') as neighbourhood

  FROM
    `natural-rider-307113.customer.leases_signed_by_source`
  WHERE
    date_signed IS NOT NULL)
SELECT * FROM leases