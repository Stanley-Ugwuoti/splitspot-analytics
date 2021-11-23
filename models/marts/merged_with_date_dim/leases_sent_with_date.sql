WITH
  leases_sent AS (
  SELECT
    *
  FROM
    {{ ref('leases_sent_dim') }}),
  date_dim AS (
  SELECT
    *
  FROM
    {{ ref('time_dim') }} ),
  table_date AS (
  SELECT
    *
  FROM
    date_dim ),
  final AS (
  SELECT
    *
  FROM
    leases_sent 
  LEFT JOIN
    date_dim
  USING
    (full_date) )
SELECT
  *
FROM
  final
ORDER BY
  full_date DESC