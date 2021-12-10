 SELECT
    tenant_charges.buildium_tenant_id,
    earliest_month_start,
    ROUND(SUM(rent_charge),2) AS rent_charge,
    ROUND(SUM(estimated_revenue),2) AS estimated_revenue,
    ROUND(SUM(DATE_DIFF(tenant_charges.end_date,start_date,DAY)/30),2) AS length_of_stay,
    MAX(tenant_charges.end_date) AS estimated_end_date
  FROM
    {{ ref ('stg_tenant_rent_charge_by_month') }} AS tenant_charges
  LEFT JOIN
    {{ ref ('tenants') }} AS tenants
  ON tenant_charges.buildium_tenant_id = tenants.buildium_tenant_id
    GROUP BY 1,2
    ORDER BY length_of_stay DESC