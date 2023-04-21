{{
  config(
    materialized='table'
  )
}}

with orders as(
    SELECT
    *
    FROM 
    {{ ref('stg_postgres__orders') }}
),
order_count as (
    SELECT
    user_guid as customer,
    count(order_guid) as no_orders
    FROM
    orders
    GROUP BY
    user_guid
),
multi_orders as (
    SELECT
    *
    FROM
    order_count 
    WHERE 
    no_orders>1
)

SELECT 
    (SELECT 
    count(customer)
    from multi_orders)    /
    (SELECT count(*) from order_count) as repeat_rate,
    '{{ run_started_at }}' as updated_at, 
    {{ dbt_utils.generate_surrogate_key(['repeat_rate', 'updated_at']) }} as id_repeat_rate 





