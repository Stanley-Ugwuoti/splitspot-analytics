WITH 
modified_column_names 
AS (SELECT 
    applicant_credit_score AS acs,
    cosigner_credit_score AS ccs,
    *
FROM {{source('customer', 'credit_score_metrics')}})


SELECT 
    CAST(date_completed AS DATE) AS date_completed,
    LOWER(email) AS email,
    name AS applicant_name,
    # Approval mode just tells us whether the applicant either submitted documents or underwent a credit/background check.
    approval_mode,

    CAST(applicant_no_of_missing_payment AS INTEGER) AS applicant_no_of_missing_payments,
    CAST(cosigner_no_of_missing_payment AS INTEGER) AS cosigner_no_of_missing_payments,
    CAST(lease_sent AS BOOLEAN) as lease_sent,
    CAST(lease_signed AS BOOLEAN) as lease_signed,

    CASE
        WHEN acs < 1 THEN NULL
        ELSE acs
    END AS applicant_credit_score,
    
    CASE
        WHEN ccs < 1 THEN NULL
        ELSE ccs
    END AS cosigner_credit_score,

FROM modified_column_names

WHERE date_completed IS NOT NULL AND lease_sent IS NOT NULL AND lease_signed IS NOT NULL