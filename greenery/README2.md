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
WITH cnt_per_hour AS 
   (
   SELECT count(ORDER_ID) AS cnt, concat(date(created_at),'-',HOUR(created_at)) AS day_hour
	  FROM DBT_NICOSTEFFENNEUEFISCHEDE.STG_ORDERS
	  GROUP BY day_hour
   )
SELECT round(avg(cnt),1) AS average_orders_per_hour
FROM cnt_per_hour

````
*Res:*
- 7.5

### Q3: On average, how long does an order take from being placed to being delivered?

Query:
```sql
select round(avg(TIMESTAMPDIFF(DAY,created_at,delivered_at)),1)
from dbt_nicosteffenneuefischede.stg_orders
where delivered_at is not NULL;
````
*Res:*
- 3.9 days

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
WITH sessions_per_day_hour AS 
	(
	select count(distinct(session_id)) as distinct_sessions ,concat(date(created_at),'-',HOUR(created_at)) AS day_hour
	from dbt_nicosteffenneuefischede.stg_events 
	group BY
	day_hour
	)
select avg(distinct_sessions)
FROM
sessions_per_day_hour;
````
*Res:*
- 16.3
