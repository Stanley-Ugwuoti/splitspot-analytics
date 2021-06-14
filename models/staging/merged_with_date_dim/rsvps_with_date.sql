WITH
  rsvps AS (
  SELECT
    *
  FROM
    {{ ref('stg_rsvps') }}),
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
    rsvps
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