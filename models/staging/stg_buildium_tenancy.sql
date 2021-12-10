-- all splitspot tenancy information
-- customer granularity
{{ config(materialized='table', sort='timestamp', dist='user_id') }}


WITH
  tenant AS (
  SELECT
    concat(first_name, " ",last_name) AS full_name,
    LOWER(login_email) AS customer_id,
    id AS buildium_tenant_id,
    leaseid,
    rent_fee,
    unit_number as room_id,
    LOWER(status) AS status,
    LOWER(REPLACE(REPLACE(REPLACE(REPLACE(property_name,' ','-'),'#','unit-'),',','-'),'--','-')) AS address_id,
    DATE(start_date) AS start_date,
    DATE_ADD(DATE(end_date), INTERVAL 1 DAY) as end_date,
    current_date() as date_today,

  FROM
    `natural-rider-307113.customer.buildium_tenancy_data`
  WHERE
    login_email IS NOT NULL)

SELECT
full_name,
customer_id,
buildium_tenant_id,
leaseid,
address_id,
rent_fee,
room_id,
status,
start_date,
end_date,
date_today,

CASE WHEN end_date = '2060-01-02'  THEN DATE_ADD(DATE(date_today), INTERVAL 4 month)
  ELSE end_date END
  AS projected_end_date,

FROM tenant
ORDER BY start_date DESC 