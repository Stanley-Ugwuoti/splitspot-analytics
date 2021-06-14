-- leases sent to leads
-- room granularity and customer_id (too many customer_id missing) 
WITH
  leases_sent AS (
  SELECT
    DATE(timestamp) AS full_date,
    lower(email) AS customer_id,
    lower(REPLACE(address_id,' ','-')) AS address_id,
    room_letter,
    DATE(lease_start_date) AS lease_start_date,
    rent_per_month,
    up_front_payment_required,
    tenant_name,
    co_signer_,
    lower(pets) as pets,
    pet_fee_per_month,
    off_street_parking,
    parking_fee_per_month
  FROM
    `natural-rider-307113.customer.leases_sent_import`
  WHERE
    timestamp IS NOT NULL)
SELECT * FROM leases_sent
Order by full_date DESC
