{{
  config(
    materialized='table'
  )
}}

with 
source as (
	SELECT *
		FROM {{ source('postgres','addresses') }}
	),
renamed_recast as (

	SELECT
    	address_id as address_guid,
	address,
	lpad(zipcode,5,0) as zipcode,
	state,
    	country
FROM source

select * from renamed_recast
