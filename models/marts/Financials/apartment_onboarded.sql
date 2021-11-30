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
    SELECT * FROM listings
        LEFT JOIN {{ref('listings_description')}}
        ON
        listings.google_sheets_id = listings_description.id
)
-- To include the total number of rooms for each distinct address

SELECT DISTINCT(address_id),
        date_onboarded,
            DATE_TRUNC(date_onboarded,MONTH) AS month_start,
                city,
                    Landlords,
                        no_of_rooms 
FROM units_onboarded
WHERE NULLIF(STRING(date_onboarded),'')  IS NOT NULL AND date_onboarded IS NOT NULL
ORDER BY 1