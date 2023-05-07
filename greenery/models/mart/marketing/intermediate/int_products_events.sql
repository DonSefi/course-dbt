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
        product_guid,
        sum(case when event_type= 'add_to_cart' then 1 else 0 end) as add_to_carts,
        sum(case when event_type= 'page_view' then 1 else 0 end) as page_views
    FROM 
        EVENTS
    GROUP by
        1
    HAVING
        product_guid is not null
)
select * from final