-- Full Listing details of all rooms in splitspot inventory
-- room granularity
WITH
  listings AS (
  SELECT
    LOWER(REPLACE(address_unit,' ','-')) AS address_id,
    Date(date_on_boarded) as date_onboarded,
    google_sheets_id,
    LOWER(city) AS city,
    LOWER(neighborhood) AS neighborhood,
    room,
    SAFE_CAST(price AS NUMERIC) AS price,
    LOWER(showing_territory) as showing_territory,
    LOWER(furnished) AS furnished,
    LOWER(status) AS status,
    LOWER(date) AS date_availaible,
    date(move_out_date) AS move_out_date,
    date(move_in_date) as move_in_date,
    lower(building_pet_rule) as building_pet_rule,
    lower(personal_pet_situation) as personal_pet_situation,
    web_site,
    couples_allowed,
    lower(split(current_roommate_email_address, '; ')[SAFE_OFFSET(0)]) as current_tenant,
    lower(split(current_roommate_email_address, '; ')[SAFE_OFFSET(1)]) as roommate
  FROM
    `natural-rider-307113.apartment.listings`
  WHERE
    address_unit IS NOT NULL)
SELECT
  *
FROM
  listings