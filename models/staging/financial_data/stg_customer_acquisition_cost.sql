SELECT 
DATE(date_) AS date,
category,
type,
classification,
item,
costs AS cost
FROM {{source('model','customer_acquisition_cost')}}