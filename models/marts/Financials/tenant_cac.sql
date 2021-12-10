-- Tenant Customer Acqusition cost aggregated by months

WITH tenant_cost AS (
    SELECT
        DATE_TRUNC(date, MONTH) AS month_start,
        ROUND(SUM(cost), 2) AS total_cost
    FROM {{ ref ('stg_customer_acquisition_cost')}}
    WHERE type = 'Tenant'
    GROUP BY 1
),
leases AS(
    SELECT
        month_start,
        SUM(no_of_leases) AS lease_count,
    FROM {{ ref ('leases_signed_source')}}
    GROUP BY 1
)
SELECT 
    leases.month_start,
    total_cost,
    lease_count
FROM leases 
LEFT JOIN tenant_cost AS tenant_cac ON leases.month_start = tenant_cac.month_start

