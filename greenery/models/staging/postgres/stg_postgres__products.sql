{{
  config(
    materialized='table'
  )
}}

SELECT
   -- UUID for each unique product on platform
  product_id as product_guid,
  -- Name of the product
  name as product_name,
  -- Price of the product
  price as product_price,
  -- Amount of the inventory we have for this product
  inventory as available_inventory
FROM {{ source('postgres', 'products') }}
