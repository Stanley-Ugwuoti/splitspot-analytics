-- Full Listing details of all rooms in splitspot inventory
-- room granularity
WITH
  listings AS (
  SELECT
    LOWER(REPLACE(address_unit,' ','-')) AS address_id,
    Date(date_on_boarded) as date_onboarded,
    google_sheets_id,
    LOWER(metro_area) AS city,
    LOWER(neighborhood) AS neighborhood,
    room,
    SAFE_CAST(price AS NUMERIC) AS price,
    LOWER(furnished) AS furnished,
    LOWER(status) AS status,
    LOWER(date) AS date_availaible,
    date(move_out_date) AS move_out_date,
    date(move_in_date) as move_in_date,
    lower(Landlord) as Landlords,
    lower(split(current_roommate_email_address, '; ')[SAFE_OFFSET(0)]) as current_tenant,
    lower(REPLACE(current_occupancy, 'N/A', 'onboarding')) as occupancy
  FROM
    `natural-rider-307113.apartment.listings`
  WHERE
    address_unit IS NOT NULL)
SELECT
  *
FROM
  listings