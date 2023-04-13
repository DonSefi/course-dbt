### Q1: How many users do we have?

Query: 
```sql
select count(*) 
from dbt_nicosteffenneuefischede.stg_users
```
*Res:*
- 130

### Q2: On average, how many orders do we receive per hour?

Query:
```sql
 select avg(cnt) 
 from (
     select  count(*) as cnt, HOUR(created_at) as order_our 
     from dbt_nicosteffenneuefischede.stg_orders 
     group by order_our 
     order by order_our
     )
````
*Res:*
- 15.04

### Q3: On average, how long does an order take from being placed to being delivered?

Query:
```sql
select avg(TIMESTAMPDIFF(HOUR,created_at,delivered_at))
from dbt_nicosteffenneuefischede.stg_orders
where delivered_at is not null  
````
*Res:*
- 93.4 (hours)

### Q4: How many users have only made one purchase? Two purchases? Three+ purchases?

Query:
```sql
select count(*)
from (
    select user_ID,count(*) as number 
    from dbt_nicosteffenneuefischede.stg_orders 
    group by user_ID
    )
where number =1/=2/>2;
````
*Res:*
- 1 &rarr; 25
- 2 &rarr;28
- \>2&rarr;71


### Q5: On average, how many unique sessions do we have per hour?

Query:
```sql
with cte as (
    select session_id,hour(created_at) as hour_created 
    from dbt_nicosteffenneuefischede.stg_events 
    order by hour_created
    )
select avg(distinct_sessions)
from (
    select count(distinct(session_id)) as distinct_sessions, hour_created
    from cte
    group by
    hour_created
    );
````
*Res:*
- 39.45
