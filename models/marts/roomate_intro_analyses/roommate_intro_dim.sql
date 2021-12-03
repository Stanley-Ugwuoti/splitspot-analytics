-- roommate introductions
-- room granularity
WITH
  roommate_intro AS (
  SELECT
    DATE(timestamp) AS full_date,
    new_resident_name AS full_name,
    lower(new_resident_email) AS customer_id,
    lower(REPLACE(apartment,' ','-')) AS address_id,
    specific_room AS room,
    DATE(new_resident_move_in_date) AS move_in_date
  FROM
    `natural-rider-307113.customer.Roommate_Introduction`
  WHERE
    timestamp IS NOT NULL)
SELECT
  *
FROM
  roommate_intro