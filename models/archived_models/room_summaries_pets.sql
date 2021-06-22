SELECT
  building_pet_rule,
  avg(price) as average_price,
  COUNT(*) as number_of_rooms
FROM
  {{ ref('stg_listing') }}
GROUP BY
  building_pet_rule
ORDER BY
  number_of_rooms DESC