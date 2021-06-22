SELECT
  couples_allowed,
  avg(price) as average_price,
  COUNT(*) as number_of_rooms
FROM
  {{ ref('stg_listing') }}
GROUP BY
  couples_allowed
ORDER BY
  number_of_rooms DESC