WITH
  customers AS (
  SELECT
    *
  FROM
    {{ ref('applicant_unpivot_neighbourhood') }}),
  date_dim AS (
  SELECT
    *
  FROM
    {{ ref('time_dim') }}),
  table_date AS (
  SELECT
    *
  FROM
    date_dim ),

final as (

    select
        *
    from customers

    left join date_dim using (full_date)

)

select * from final

ORDER BY
  full_date DESC