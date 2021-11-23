{{ config(materialized='table', sort='timestamp', dist='user_id') }}

WITH
  leases_sent AS (
  SELECT
    *
  FROM
    {{ ref('leases_sent_with_date') }} )
SELECT
  * EXCEPT(row_num)
FROM (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY full_date DESC ) row_num
  FROM
    leases_sent) t
WHERE
  row_num=1

ORDER BY
  full_date DESC