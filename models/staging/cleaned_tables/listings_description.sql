-- listings descriptions including number of rooms, baths and google sheet ID
-- room granularity
WITH
  listings AS (
  SELECT
    *
  FROM
    `natural-rider-307113.apartment.listing_description`
  WHERE
    no_of_rooms IS NOT NULL)
SELECT
  id,
  no_of_rooms,
  no_of_baths,
  address,
FROM
  listings