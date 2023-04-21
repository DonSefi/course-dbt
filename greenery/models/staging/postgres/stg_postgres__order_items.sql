{{
  config(
    materialized='table'
  )
}}

SELECT
  -- OrderId of this order
  order_id as order_guid,
  -- ProductId of a single item in this order
  product_id as product_guid,
  -- Number of units of the product in this order
  quantity
FROM {{ source('postgres', 'order_items') }}
