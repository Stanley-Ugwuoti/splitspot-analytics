SELECT
  status,
  avg(price) as average_price,
  COUNT(*) as number_of_rooms
FROM
  {{ ref('stg_listing') }}
GROUP BY
  status
ORDER BY
  average_price DESC