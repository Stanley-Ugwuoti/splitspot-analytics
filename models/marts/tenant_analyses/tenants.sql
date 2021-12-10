WITH
buildium_data AS (
  SELECT
    *
  FROM
    {{ ref('buildium_tenancy') }} 
  )
  SELECT 
    full_name,
    customer_id AS email,
    buildium_tenant_id,
    COUNT(leaseid) AS number_of_leases,
    MIN(start_date) AS earliest_lease_start,
    DATE_TRUNC(MIN(start_date), MONTH) AS earliest_month_start,
    MAX(end_date) AS end_date,
    MAX(projected_end_date) as projected_end_date, 
  FROM buildium_data
  -- To exclude leases that never started
  WHERE start_date > '2018-01-01' 
  GROUP BY 3, 2, 1
  ORDER BY number_of_leases DESC