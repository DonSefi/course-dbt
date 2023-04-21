{{
  config(
    materialized='table'
  )
}}

SELECT

  event_id as event_guid,
  -- UUID of each browsing session on the platform which can contain many events
  session_id as event_session_guid,
  -- UUID of the user that this event is associated with
  user_id as event_user_guid,
  -- URL that the event happened on
  page_url as event_page_url,
  -- Timestamp of the event
  created_at as event_created_at_UTC,
  -- Type of event
  event_type,
  -- If the event is specific to an order (mostly used for checkout)
  order_id as order_guid,
  -- If the event is specific to a product
  product_id as product_guid
FROM {{ source('postgres', 'events') }}
