{{
  config(
    materialized='table'
  )
}}

SELECT
 -- UUID for each unique order on platform
  order_id as order_guid,
  -- UserId of the user that placed this order
  user_id as user_guid ,
  -- PromoId if any was used in the order
  promo_id as promo_name,
  -- Delivery address for this order
  address_id as address_guid,
  -- Timestamp when the order was created
  created_at ,
  -- Dollar about of the items in the order
  order_cost,
  -- Cost of shipping for the order
  shipping_cost,
  -- Total cost of the order including shipping
  order_total,
  -- Tracking number for the order/package
  tracking_id as tracking_guid,
  -- Company that was used for shipping
  shipping_service,
  -- Estimated date of delivery
  estimated_delivery_at,
  -- Actual timestamp of delivery
  delivered_at,
  -- Status of the order
  status
FROM {{ source('postgres', 'orders') }}
