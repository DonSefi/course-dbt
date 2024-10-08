{{
  config(
    materialized='table'
  )
}}

with session_agg as(
    SELECT
    *
    FROM 
    {{ ref('int_session_events_agg_products') }}
),

{%- set product_guids = dbt_utils.get_column_values(
    table=ref('int_session_events_agg_products') ,
    column = 'product_guid'
    )
%}


distinct_sessions_per_product as(
    {%- for product_guid in product_guids %}
    SELECT
        '{{product_guid}}' as product_guid,
        count(distinct event_session_guid) as count_distinct_sessions
        FROM (
            SELECT * from session_agg where product_guid = '{{product_guid}}')
    {%- if loop.last  %}  
    {%- else %} UNION {%- endif %}
    {%- endfor %}
    
),

checked_out_event_session as (
    select * FROM {{ref('int_session_events_ordered_products')}}
    where event_type='checkout'
)

SELECT
    checked_out_event_session.product_guid as product_guid,
    products.product_name as product_name,
    products_events.page_views as page_view_sessions,
    products_events.add_to_carts as add_to_carts_sessions,
    checked_out_event_session.checkout_sessions as checkout_sessions
    
FROM
    checked_out_event_session
left join 
    distinct_sessions_per_product
on 
    distinct_sessions_per_product.product_guid=checked_out_event_session.product_guid
left join 
    {{ref('stg_postgres__products')}} products
on
    products.product_guid=checked_out_event_session.product_guid
left join
    {{ref('int_products_events')}} products_events
on
    products_events.product_guid=checked_out_event_session.product_guid