{{
  config(
    materialized='table'
  )
}}

with orders as(
    SELECT
    *
    FROM {{ ref('stg_postgres__orders') }}
)
SELECT
    user_guid as user_guid,
    count(order_guid) as number_of_orders,
    round(min(order_total),2) as smallest_order,
    round(max(order_total),2) as largest_order,
    round(avg(order_total),2) as average_ordered_value,
    round(sum(order_total),2) as total_ordered_value
FROM orders
GROUP BY user_guid
   




