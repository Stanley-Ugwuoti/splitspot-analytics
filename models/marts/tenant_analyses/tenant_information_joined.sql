WITH
  cohort AS (
  SELECT
    buildium_tenant_id,
    MIN(start_date) AS start_date,
    MAX(end_date) AS estimated_end_date,
    MIN(DATE_TRUNC(start_date, MONTH)) AS cohort_month
  FROM
    {{ ref('stg_tenant_rent_charge_by_month') }}
  GROUP BY 1
  ORDER BY
    cohort_month 
),
  buildium_data AS (
  SELECT
    *
  FROM
    {{ ref('stg_buildium_tenancy') }}
)
SELECT
  cohort.buildium_tenant_id,
  cohort_month,
  full_name,
  customer_id AS customer_email,
  address_id,
  buildium_data.start_date,
  end_date,
  estimated_end_date,
  date_today
FROM
  cohort
LEFT JOIN buildium_data ON cohort.buildium_tenant_id = buildium_data.buildium_tenant_id