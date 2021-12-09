-- time on market
-- room granularity

WITH
  time_on_market AS (
  SELECT
    *
  FROM
    {{source('model','time_on_market')}}
SELECT
  *
FROM
  time_on_market