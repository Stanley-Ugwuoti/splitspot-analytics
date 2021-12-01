SELECT
EXTRACT(MONTH FROM date) AS month,
type,
category,
ROUND(SUM(Costs),2) AS total_cost
FROM {{ ref ('stg_customer_acquisition_cost')}}
GROUP BY month,type,category
ORDER BY month,type