{{
  config(
    materialized='table'
  )
}}

SELECT
    address_id as address_guid,
    address,
    lpad(zipcode,5,0) as zipcode,
    state,
    country
FROM {{ source('postgres', 'addresses') }}
