WITH
  roommate_intro AS (
  SELECT
    *
  FROM
    {{ ref('roommate_intro_dim') }}),
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
    roommate_intro 
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