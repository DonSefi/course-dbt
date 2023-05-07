{{
  config(
    materialized='table'
  )
}}

with session_agg as(
    SELECT
    *
    FROM 
    {{ ref('int_session_events_agg') }}
),

purchased_sessions as(
    SELECT 
    count(*) as n_purchased
    FROM
    session_agg
    WHERE 
    checkouts = 1
) ,

all_sessions as(
    SELECT 
    count(*) as n_sessions
    FROM
    session_agg
)

SELECT
    (SELECT n_purchased FROM purchased_sessions ) as purchased_sessions,
    (SELECT n_sessions FROM all_sessions) as all_sessions,
    div0(purchased_sessions,all_sessions) as conversion_rate


-- select * from all_sessions

