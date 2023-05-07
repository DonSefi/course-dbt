{{
  config(
    materialized='table'
  )
}}

with product_funnel as (
    select * from {{ref('fct_product_funnel')}}
)

SELECT
    sum(page_view_sessions) as sum_page_view_sessions,
    sum(add_to_carts_sessions) as sum_add_to_carts_sessions,
    sum(checkout_sessions) as sum_checkout_sessions,
    div0(sum_add_to_carts_sessions,sum_page_view_sessions) as conv_rate_pageview_to_cart,
    div0(sum_checkout_sessions,sum_add_to_carts_sessions) as conv_rate_cart_to_checkout

FROM
    product_funnel