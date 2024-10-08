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

Product grained funnel:
|PRODUCT_GUID                        |PRODUCT_NAME    |PAGE_VIEW_SESSIONS|ADD_TO_CARTS_SESSIONS  |CHECKOUT_SESSIONS|
|------------------------------------|----------------|------------------|-----------------------|-----------------|
|bb19d194-e1bd-4358-819e-cd1f1b401c0c|Birds Nest Fern |80                |40                     |33               |
|c7050c3b-a898-424d-8d98-ab0aaad7bef4|Orchid          |75                |37                     |34               |
|80eda933-749d-4fc6-91d5-613d29eb126f|Pink Anthurium  |74                |37                     |31               |
|e18f33a6-b89a-4fbc-82ad-ccba5bb261cc|Ponytail Palm   |71                |30                     |28               |
|843b6553-dc6a-4fc4-bceb-02cd39af0168|Ficus           |68                |35                     |29               |
|5ceddd13-cf00-481f-9285-8340ab95d06d|Majesty Palm    |69                |38                     |33               |
|689fb64e-a4a2-45c5-b9f2-480c2155624d|Bamboo          |69                |42                     |36               |
|e5ee99b6-519f-4218-8b41-62f48f59f700|Peace Lily      |67                |35                     |27               |
|615695d3-8ffd-4850-bcf7-944cf6d3685b|Aloe Vera       |65                |36                     |32               |
|74aeb414-e3dd-4e8a-beef-0fa45225214d|Arrow Head      |64                |39                     |35               |
|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|ZZ Plant        |65                |35                     |34               |
|e2e78dfc-f25c-4fec-a002-8e280d61a2f2|Boston Fern     |63                |34                     |26               |
|37e0062f-bd15-4c3e-b272-558a86d90598|Dragon Tree     |62                |34                     |29               |
|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|Philodendron    |63                |32                     |30               |
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos          |64                |24                     |21               |
|05df0866-1a66-41d8-9ed7-e2bbcddd6a3d|Bird of Paradise|60                |33                     |27               |
|64d39754-03e4-4fa0-b1ea-5f4293315f67|Spider Plant    |59                |30                     |28               |
|5b50b820-1d0a-4231-9422-75e7f6b0cecf|Pilea Peperomioides|60                |32                     |28               |
|e706ab70-b396-4d30-a6b2-a1ccf3625b52|Fiddle Leaf Fig |59                |30                     |28               |
|579f4cd0-1f45-49d2-af55-9ab2b72c3b35|Rubber Plant    |56                |32                     |28               |
|b86ae24b-6f59-47e8-8adc-b17d88cbd367|Calathea Makoyana|53                |32                     |27               |
|6f3a3072-a24d-4d11-9cef-25b0b5f8a4af|Alocasia Polly  |54                |27                     |21               |
|35550082-a52d-4301-8f06-05b30f6f3616|Devil's Ivy     |45                |24                     |22               |
|c17e63f7-0d28-4a95-8248-b01ea354840e|Cactus          |55                |32                     |30               |
|e8b6528e-a830-4d03-a027-473b411c7f02|Snake Plant     |73                |34                     |29               |
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|65                |44                     |39               |
|58b575f2-2192-4a53-9d21-df9a0c14fc25|Angel Wings Begonia|62                |32                     |24               |
|d3e228db-8ca5-42ad-bb0a-2148e876cc59|Money Tree      |56                |26                     |26               |
|be49171b-9f72-4fc9-bf7a-9a52e259836b|Monstera        |49                |26                     |25               |
|a88a23ef-679c-4743-b151-dc7722040d8c|Jade Plant      |46                |24                     |22               |


Values for KPI Report

|SUM_PAGE_VIEW_SESSIONS              |SUM_ADD_TO_CARTS_SESSIONS|SUM_CHECKOUT_SESSIONS|CONV_RATE_PAGEVIEW_TO_CART|CONV_RATE_CART_TO_CHECKOUT|
|------------------------------------|-------------------------|---------------------|--------------------------|--------------------------|
|1,871                               |986                      |862                  |0.52699                   |0.874239                  |

Fewer people convert from 'pageview' to 'add_to_cart' (53%) compared to 87% conversionrate 'add_to_cart' to checked out.
Hence, the biggest -off point is adding to cart.
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