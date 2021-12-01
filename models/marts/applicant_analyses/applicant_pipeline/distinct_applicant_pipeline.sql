{{ config(materialized='table', sort='timestamp', dist='user_id') }}

WITH
  customers AS (
  SELECT
    *
  FROM
  {{ ref('applicant_pipeline') }}
)

SELECT
  * EXCEPT(row_num)
FROM (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY full_date DESC ) row_num
  FROM
    customers) t
WHERE
  row_num=1

ORDER BY
  full_date DESC