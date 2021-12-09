-- Ramp up end dates by apartments

SELECT 
UPPER(term) = 'RS' AS Revenue_share,
apartment_id,
CASE 
    WHEN ramp_up_end_date IN ('','N/A') THEN NULL 
    ELSE CAST(CAST(ramp_up_end_date AS TIMESTAMP) AS DATE)
END AS ramp_up_end_date,
FROM{{source('financials','ramp_up_details')}}