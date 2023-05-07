## Part 1. dbt Snapshots

These were last weeks changes:

|Product ID                          |Name            |Price|Inventory|
|------------------------------------|----------------|-----|---------|
|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|Philodendron    |45   |30       |
|689fb64e-a4a2-45c5-b9f2-480c2155624d|Bamboo          |15.25|23       |
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|80.5 |10       |
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos          |30.5 |20       |
|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|ZZ Plant        |25   |41       |
|be49171b-9f72-4fc9-bf7a-9a52e259836b|Monstera        |50.75|31       |

Q2:
Now that we have 3 weeks of snapshot data, can you use the inventory changes to determine which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks? 

```SQL
SELECT
    Product_ID,
    NAME,
    count(*) as changes
FROM
    DEV_DB.DBT_NICOSTEFFENNEUEFISCHEDE.INVENTORY_SNAPSHOT
GROUP BY
    1,2
HAVING 
    CHANGES>1
ORDER BY
    3 DESC

```
*Res:*
|PRODUCT_ID                          |NAME            |CHANGES|
|------------------------------------|----------------|-------|
|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|Philodendron    |4      |
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|4      |
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos          |4      |
|be49171b-9f72-4fc9-bf7a-9a52e259836b|Monstera        |4      |
|689fb64e-a4a2-45c5-b9f2-480c2155624d|Bamboo          |3      |
|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|ZZ Plant        |3      |

Items that went out of stock:
```SQL
SELECT
    Product_ID,
    NAME,
    DBT_VALID_FROM,
    DBT_VALID_TO,
    min(INVENTORY ) as min_inventory
FROM
    DEV_DB.DBT_NICOSTEFFENNEUEFISCHEDE.INVENTORY_SNAPSHOT
GROUP BY
    1,2,3,4
HAVING
    min_inventory=0
```
*Res:*
|PRODUCT_ID                          |NAME            |DBT_VALID_FROM|DBT_VALID_TO           |MIN_INVENTORY|
|------------------------------------|----------------|--------------|-----------------------|-------------|
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos          |2023-05-01 11:56:58.702|2023-05-07 10:13:20.432|0            |
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|2023-05-01 11:56:58.702|2023-05-07 10:13:20.432|0            |

## Part 2. Modeling challenge


## Part 3: Reflection questions -- please answer 3A or 3B, or both!

### 3A. dbt next steps for you 


Q1: if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?
- We are already using it low-key and are now starting to bring in more devs /like me- so no convincing needed at this point

Q2: if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?
- Can't say yet because i will only really start looking into our companies DBT project after finishing this course ;-) But I think the biggest impact for now will be to improve on our documentation, getting started and structure 

Q3: if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

- I gained a lot of experience and best practices in how to structure SQL queries and how to generalize them via Jinja.

- Learned alot about how great it is to have a automatic generated documentation including a DAG. 

- Without these two learning, my SQL skills always felt a bit wasted, because i had no real ecosystem in which to run them productively, other then just running them manually against a DB