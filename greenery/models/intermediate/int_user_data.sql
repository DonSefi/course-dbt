{{
  config(
    materialized='table'
  )
}}


with
users as (
    SELECT *from {{ref("stg_postgres__users")}}
),
user_addresses as(
    Select * from {{ref("stg_postgres__addresses")}}
)

SELECT
    users.user_guid,
    users.first_name,
    users.last_name,
    users.email,
    user_addresses.address,
    user_addresses.zipcode,
    user_addresses.country
from users
left join user_addresses
    on users.address_guid = user_addresses.address_guid


