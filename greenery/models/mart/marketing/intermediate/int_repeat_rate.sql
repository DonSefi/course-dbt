{{
  config(
    materialized='table'
  )
}}

with order_count as (
    select user_id as customer, count(order_id) as no_orders  FROM {{ ref('stg_postgres__orders') }}
    group by user_id
    ),
multi_orders as (
    select * from order_count where no_orders>1
    )
select (select count(customer) from multi_orders )
        / (select count(*) from order_count) as repeat_rate,
        '{{ run_started_at }}' as updated_at, 
        {{ dbt_utils.generate_surrogate_key(['repeat_rate', 'updated_at']) }} as id_repeat_rate 




