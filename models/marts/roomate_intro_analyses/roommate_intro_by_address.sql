{{ config(materialized='table', sort='timestamp', dist='user_id') }}

WITH
  roommate_intro AS (
  SELECT
    *
  FROM
    {{ ref('roommate_intro_with_date') }}
  WHERE
    full_date IS NOT NULL )
SELECT
  id,
  year_week,
  fiscal_year,
  month,
  address_id,
  COUNT(*) AS roommate_intro
FROM
  roommate_intro
GROUP BY
  id,
  year_week,
  month,
  fiscal_year,
  address_id
ORDER BY
  id DESC