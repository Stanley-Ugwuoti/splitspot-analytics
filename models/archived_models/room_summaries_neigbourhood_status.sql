SELECT
  neighborhood,
  status,
  avg(price) as average_price,
  COUNT(*) as number_of_rooms
FROM
  {{ ref('stg_listing') }}
GROUP BY
  neighborhood,
  status
ORDER BY
  number_of_rooms DESC