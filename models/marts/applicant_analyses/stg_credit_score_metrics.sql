SELECT 
    CAST(date_completed AS DATE) AS date_completed,
    LOWER(email) AS email,
    name AS applicant_name,
    approval_mode,
    applicant_credit_score,
    applicant_no_of_missing_payment,
    cosigner_credit_score,
    cosigner_no_of_missing_payment,
    lease_sent,
    lease_signed

FROM {{source('customer', 'credit_score_metrics')}}

WHERE date_completed IS NOT NULL AND lease_sent IS NOT NULL AND lease_signed IS NOT NULL