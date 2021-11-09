{{ config(materialized='table', sort='timestamp', dist='user_id') }}

  WITH
  listings AS (
  SELECT
    *
  FROM
    {{ ref('joined_listings') }}
  WHERE
    address_id IS NOT NULL )
SELECT
  address_id,
  neighborhood,
  city,
  date_onboarded,
  AVG(price) as avg_price,
  COUNT(room) as number_of_rooms,
  COUNT(DISTINCT IF(current_tenant LIKE '%@%', current_tenant, NULL)) AS number_currently_occupied_rooms,
  AVG(availability_30) as avg_time_on_market_30,
  AVG(availability_90) as avg_time_on_market_90,
  AVG(availability_365) as avg_time_on_market_365
FROM
  listings
GROUP BY
  address_id,
  neighborhood,
  city,
  date_onboarded
ORDER BY
  avg_time_on_market_365 DESC

