-- time on market
-- room granularity

WITH
  time_on_market AS (
  SELECT
    *
  FROM
    `natural-rider-307113.apartment.time_on_market`)
SELECT
  *
FROM
  time_on_market