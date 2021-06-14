-- time on market of apartment for the last x days.
-- room granularity.

{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  listings.*,
  description.no_of_rooms,
  description.no_of_baths,
  time_market.availaibility_30 as availability_30,
  time_market.availability_60 as availability_60,
  time_market.availaibility_90 as availability_90,
  time_market.availaibility_365 as availability_365,

  CASE WHEN listings.status = 'vacant'  THEN 'on-market'
    WHEN listings.status = 'on-boarding'  THEN 'on-market'
    WHEN listings.status = 'roommate introduction'  THEN 'on-market'
    WHEN listings.status = 'lease sent'  THEN 'on-market'
    WHEN listings.status = 'upcoming vacancy'  THEN 'on-market'
    ELSE 'off-market' END
  AS market_status,

  CASE WHEN price > 1200 THEN 'high'
    WHEN price > 900 THEN 'medium'
    ELSE 'low' END
  AS price_category

FROM
  {{ ref('stg_listing') }} AS listings
LEFT JOIN
  {{ ref('stg_time_on_market') }} AS time_market
ON
  listings.google_sheets_id = time_market.google_id
LEFT JOIN
  {{ ref('listings_description') }} AS description
ON
  listings.google_sheets_id = description.id

