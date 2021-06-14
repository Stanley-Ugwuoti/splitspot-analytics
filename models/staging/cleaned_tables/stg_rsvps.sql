-- rsvp stats still in development
SELECT
  lower(name) AS name,
  lower(email) AS customer_id,
  date(created_at) AS full_date,
  lower(event_type_name) AS event_type_name,
  cancellation,
  status,
  
IF
  ( ARRAY_LENGTH(SPLIT(event_type_name, '-'))>1,
  IF
    ( REGEXP_CONTAINS(SPLIT(event_type_name, '-')[
      OFFSET
        (1)], r"(?i) chat"),
      "One-on-one Chat",
    IF
      ( REGEXP_CONTAINS(SPLIT(event_type_name, '-')[
        OFFSET
          (1)], r"(?i) 3d"),
        "3D Showings",
        "Live Showings (E)" ) ),
    "Live Showings" ) AS event_type
FROM
  `natural-rider-307113.calendly.calendly_stats`
   ORDER BY full_date DESC