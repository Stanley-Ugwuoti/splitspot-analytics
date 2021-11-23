WITH
  webstats AS (
  SELECT
    *
  FROM
    {{ ref('stg_webstats') }}),
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

final as (

    select
        *
    from webstats

    left join date_dim using (full_date)

)

select * from final

ORDER BY
  --full_date DESC
  unique_pageviews DESC
