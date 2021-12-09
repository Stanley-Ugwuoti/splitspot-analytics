SELECT
  tenant_id AS buildium_tenant_id,
  LOWER(REPLACE(REPLACE(REPLACE(property_name, ',', ''), '#', 'unit '), ' ', '-')) AS address_id,
  CAST(start_date AS DATE) AS start_date,
  CAST(end_date AS DATE) AS end_date,
  ROUND(rent_charge, 2) AS rent_charge,
  ROUND(rent_charge*0.1, 2) AS estimated_revenue
FROM
  `natural-rider-307113.Financials.tenant_rent_charge_by_month`