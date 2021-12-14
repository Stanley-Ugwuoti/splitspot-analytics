SELECT 
DATE(date_) AS date,
category,
type,
classification,
item,
costs AS cost
FROM {{ source('financials','customer_acquisition_cost') }}