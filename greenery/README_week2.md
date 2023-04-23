## Part 1
### Q1: How many users do we have?
What is our user repeat rate? 

Query:
See models/mart/marketing/int_repeat_rate.sql


*Res:*
- 0.798

### Q2: What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? 
Indicators whether user will buy again:
    - only bought one in promo 
    - has made several purchases in the past
    - ...
### Q3: Explain the product mart models you added. Why did you organize the models in the way you did?
I built three main marts, 
- *fct_product_sales*: holds what wat sold and for what price in total -> allows to see the most sold items by qty or revenue
- *fct_user_sessions*: holds all the unique sessions -> connected with user data and session length
- *dim_user_order_data*: holds the oder history for each user -> how many, smallest largest average and total orders. Allows to identify key customers
## Part 2 Tests
### Q4: Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
Tests are run whenever dbt runs, i.e. when the data ist beeing updated. Upon running, warnings are raised if the data shows inconsistencies.

## Part 3 Snapshots
According to my snapshot, these items changed in inventory:
- Pothos
- Philodendron
- Monstera
- String of pearls