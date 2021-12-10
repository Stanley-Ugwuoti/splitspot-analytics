-- buildium tenancy
{{ config(materialized='table', sort='timestamp', dist='user_id') }}

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
projected_end_date,
DATE_DIFF(DATE (projected_end_date), DATE (start_date), month) as rent_duration,

CASE WHEN CAST(end_date AS string) = '2060-01-02'  THEN 'at-will'
  ELSE 'fixed' END
  AS rent_type,


FROM
{{ ref('stg_buildium_tenancy') }}
