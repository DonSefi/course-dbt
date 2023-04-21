{{
  config(
    materialized='table'
  )
}}

with
session_events_agg as (
    select * from {{ref('int_session_events_agg')}}
),
users as (
    SELECT *from {{ref("stg_postgres__users")}}
),
user_addresses as(
    Select * from {{ref("stg_postgres__addresses")}}
)

SELECT
    session_events_agg.event_session_guid,
    session_events_agg.event_user_guid,
    users.first_name,
    users.last_name,
    users.email,
    user_addresses.address,
    user_addresses.zipcode,
    user_addresses.country,
    session_events_agg.checkouts,
    session_events_agg.package_shippeds,
    session_events_agg.page_views,
    session_events_agg.first_session_event_at_utc as first_session_event,
    session_events_agg.last_session_event_at_utc as last_session_event,
    timediff('minute',first_session_event,last_session_event) as session_length_minutes
from session_events_agg
left join users
    on session_events_agg.event_user_guid = users.user_guid
left join user_addresses
    on users.address_guid = user_addresses.address_guid


