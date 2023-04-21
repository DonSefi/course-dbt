{{
  config(
    materialized='table'
  )
}}

with
user_data as (
    SELECT *from {{ref("int_user_data")}}
),
user_orders as (
    Select * from {{ref("int_user_orders")}}
)

SELECT
    user_data.user_guid,
    user_data.first_name,
    user_data.last_name,
    user_data.email,
    user_data.address,
    user_data.zipcode,
    user_data.country,
    IFNULL(user_orders.number_of_orders,0) as number_of_orders,
    IFNULL(user_orders.smallest_order,0) as smallest_order,
    IFNULL(user_orders.largest_order,0) as largest_order,
    IFNULL(user_orders.average_ordered_value,0) as average_ordered_value,
    IFNULL(user_orders.total_ordered_value,0) as total_ordered_value
FROM
user_data
LEFT join
user_orders
on
user_data.user_guid=user_orders.user_guid