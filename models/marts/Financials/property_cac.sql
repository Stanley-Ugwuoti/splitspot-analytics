-- Property Customer Acqusition cost aggregated by months

WITH property_cost AS(
    SELECT
        DATE_TRUNC(date,MONTH) AS month_start,
        ROUND(SUM(costs),2) AS total_cost
    FROM {{ ref ('stg_customer_acquisition_cost')}}
    WHERE type = 'Property'
    GROUP BY 1
),
apt_onboarded_grouped AS (
   SELECT
        DATE_TRUNC(date_onboarded,MONTH) AS start_month,
        SUM(no_of_rooms) AS rooms_onboarded  
   FROM {{ ref ('apartment_onboarded')}}
   GROUP BY 1

-- To group on-boarded apartments by month start for easy joining
)
    SELECT 
        month_start,
        total_cost,
        rooms_onboarded  
    FROM property_cost
    LEFT JOIN  apt_onboarded_grouped AS apartment_onboarded ON property_cost.month_start = apartment_onboarded.start_month
