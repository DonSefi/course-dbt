### Q1: How many users do we have?

query: 
```sql
select count(distinct(name)) from dbt_nicosteffenneuefischede.stg_products
```
res: 30

### Q2: On average, how many orders do we receive per hour?

query: select avg(cnt) from (select  count(*) as cnt, HOUR(created_at) as order_our from dbt_nicosteffenneuefischede.stg_orders group by order_our order by order_our)
res: 15.04

### Q3: On average, how long does an order take from being placed to being delivered?

query: select avg(TIMESTAMPDIFF(HOUR,created_at,delivered_at)) from dbt_nicosteffenneuefischede.stg_orders where delivered_at is not null  
res: 93.4

#### Q4: How many users have only made one purchase? Two purchases? Three+ purchases?

query: select count(*) from (select user_ID,count(*) as number from dbt_nicosteffenneuefischede.stg_orders group by user_ID) where number =1/=2/>2;
res: 1-> 25 2->28 >2->71

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

#### Q5: On average, how many unique sessions do we have per hour?

query:
with cte as (select session_id,hour(created_at) as hour_created from dbt_nicosteffenneuefischede.stg_events order by hour_created)
select avg(distinct_sessions) from (select count(distinct(session_id)) as distinct_sessions,hour_created from cte group by hour_created);
res: 39.45
