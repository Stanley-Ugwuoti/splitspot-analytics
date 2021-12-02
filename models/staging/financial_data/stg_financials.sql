-- Income Statement trasnformed data from google sheets

  SELECT
    DATE(date) AS full_date,
    UPPER(term) AS term,
    LOWER(REPLACE(apartment_id,' ','-')) AS address_id,
    ROUND(total_rental_income,2) AS rental_income,
    CAST(vacancy_trigger AS BOOL) AS vacancy_trigger,
    CAST(minimum_trigger AS BOOL) AS minimum_trigger,
    revenue_share,
    CAST(ramp_up_period AS BOOL) AS ramp_up_period,
    total_landlord_payments,
    ROUND(gross_profit_loss,2) AS gross_profit_loss,
    occupancy,
    occupied_rooms,
    vacant_rooms,
    splitspot_rooms,
    outstanding_payments_opening AS receivables_opening_balance,
    outstanding_payments_closing AS receivables_closing_balance

  FROM
    `natural-rider-307113.Financials.financial_income_statement`
    WHERE date IS NOT NULL