-- web statistics from google analytics and data transformation of the data
-- date and apartment granularity
{{ config(materialized='table', sort='timestamp', dist='user_id') }}

SELECT
  page,
  users,
  entrances,
  unique_pageviews,
  address_id AS former_address_id,
  DATE(date) AS full_date,
  LOWER( REPLACE(REPLACE(REPLACE(REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REPLACE(REGEXP_REPLACE(REPLACE(address_id, "-st-","-street-"),r"[\.\*\+\?\^\$\{\}\(\)\|\[\]\/\!\",#']", ""),' ','-'),r"(?i)-+Rd","-Road"),"(?i)-+(Str)+(.?)(e?)(e?)(t?)","-Street"),"(?i)-+(Ave)+(nue)?(.?)-+","-Avenue-"),"(?i)-+(Terr)+(ace)?-+","-Terrace-"), "-+Par(k?)-+","-Park-"),r"(?i)-+Mt(.?)-+","-Mount-"),r"(?i)-+(Mass)+(achusetts)?","-Massachusetts"),"(?i)Street(-?)Unit","Street-Unit"),"(?i)6-12-7th-street-unit-6","6-7th-street"),"(?i)6-12-7th-street-unit-8","8-7th-street"),"(?i)6-12-7th-street-unit-10","10-7th-street"),"(?i)6-12-7th-street-unit-12","12-7th-street") ) AS address_id,
FROM
  {{source('web_data','web_stats')}}
WHERE
  address_id != ""
  AND NOT ENDS_WITH(address_id, "-")
  AND NOT ENDS_WITH(address_id, ".")
  AND NOT ENDS_WITH(address_id, "st")
  AND NOT REGEXP_CONTAINS(address_id, '(?i)splitspot')
  AND NOT REGEXP_CONTAINS(address_id, '(?i)See')
  AND NOT REGEXP_CONTAINS(address_id, r'(?i)splitspot')
  AND NOT REGEXP_CONTAINS(address_id, '(?i)wix')
  AND NOT REGEXP_CONTAINS(address_id, r'\$')
  AND NOT REGEXP_CONTAINS(address_id, '(?i)Room')
  AND NOT REGEXP_CONTAINS(address_id, '(?i)server')
  AND NOT REGEXP_CONTAINS(address_id, '(?i)com')
  AND NOT REGEXP_CONTAINS(address_id, '^-?[0-9]+$')

ORDER BY
  full_date DESC
