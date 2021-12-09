-- rsvp stats from calendly
SELECT
  lower(name) AS name,
  lower(email) AS customer_id,
  date(created_at) AS full_date,
  lower(event_type_name) AS event_type_name,
  cancellation,

IF
  ( REGEXP_CONTAINS(event_type_name, r"(?i)Chat" ), "One-on-one calls",
  IF
  ( ARRAY_LENGTH(SPLIT(event_type_name, '-'))>1,
  IF
    ( REGEXP_CONTAINS(event_type_name, r"(?i)Tour"),
      "In-Person Showings",
    IF
      ( REGEXP_CONTAINS(SPLIT(event_type_name, '-')[
        OFFSET
          (1)], r"(?i)3d"),
        "3D Showings",
        "Live Showings (E)" ) ),
    "Live Showings")
   ) AS event_type
FROM
 {{source('calendly','rsvps')}}

WHERE email is not NULL
ORDER BY full_date DESC
