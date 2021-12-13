WITH 
  tenant_charges AS (
    SELECT * FROM {{ ref ('stg_tenant_rent_charge_by_month') }} 
  ),
  tenants AS (
    SELECT * FROM {{ ref ('tenants') }}
  )
SELECT
  tenant_charges.buildium_tenant_id,
  earliest_month_start,
  ROUND(SUM(rent_charge),2) AS total_rent_charge,
  ROUND(SUM(estimated_revenue),2) AS total_estimated_revenue,
  ROUND(SUM(DATE_DIFF(tenant_charges.end_date,start_date,DAY)/30),2) AS length_of_stay,
  MAX(tenant_charges.end_date) AS estimated_end_date
FROM tenant_charges
LEFT JOIN tenants ON tenant_charges.buildium_tenant_id = tenants.buildium_tenant_id
GROUP BY 1, 2
ORDER BY earliest_month_start, length_of_stay DESC
