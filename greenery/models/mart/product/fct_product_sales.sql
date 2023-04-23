{{
  config(
    materialized='table'
  )
}}

with
products as (
    select * from {{ref('stg_postgres__products')}}
),

order_items as(
    select * from {{ref('stg_postgres__order_items')}}
),

all_items as (
    select distinct(product_guid) 
    FROM
        (select product_guid FROM products
        UNION 
        select product_guid FROM order_items)
),

all_items_ordered as (
    SELECT
    product_guid,
    sum(quantity) as quantity
    FROM
    order_items
    GROUP BY
    product_guid
)

SELECT 
    all_items.product_guid,
    COALESCE(products.product_name,'Missing Item') as product_name,
    COALESCE(products.product_price,0) as product_price,
    COALESCE(all_items_ordered.quantity,0) as total_quantity,
    ROUND(product_price * total_quantity,0) as total_sum
FROM 
    all_items
LEFT JOIN
    products
ON
    products.product_guid = all_items.product_guid
LEFT JOIN
    all_items_ordered
ON 
    all_items_ordered.product_guid = all_items.product_guid
