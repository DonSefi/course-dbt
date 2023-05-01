{{
  config(
    materialized='table'
  )
}}

with events as(
    SELECT * FROM {{ref('stg_postgres__events')}}
),
final as (
    SELECT
    oi.product_guid as product_guid,
    count(*) as checkout_sessions
    FROM events e
    join
    {{ref('stg_postgres__order_items')}} oi
    on e.order_guid = oi.order_guid
    where event_type='checkout'
    group by 
    oi.product_guid
)

select * from final