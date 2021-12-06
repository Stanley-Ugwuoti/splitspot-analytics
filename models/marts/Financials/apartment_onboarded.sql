-- Total number of on-boarded units 
{{ config(materialized='table', sort='date_onboarded', dist='address_id') }}

WITH listings AS (
    SELECT 
        google_sheets_id,
        address_id,
        date_onboarded,
        city,
        Landlords,
    FROM {{ref('stg_listing')}}
),
units_onboarded AS (
    SELECT 
        * 
     FROM listings
     LEFT JOIN {{ref('apartment_listings_description')}} AS apartment_listing ON listings.google_sheets_id = apartment_listing.id
)
-- To include the total number of rooms for each distinct address

SELECT 
    DISTINCT(address_id),
    date_onboarded,
    DATE_TRUNC(date_onboarded,MONTH) AS month_start,
    city,
    Landlords AS landlord_name,
    no_of_rooms 
FROM units_onboarded
WHERE NULLIF(STRING(date_onboarded),'')  != ''
ORDER BY 1