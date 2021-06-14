SELECT
  neighborhood,
  avg(price) as average_price,
  COUNT(*) as number_of_rooms
FROM
  {{ ref('stg_listing') }}
GROUP BY
  neighborhood