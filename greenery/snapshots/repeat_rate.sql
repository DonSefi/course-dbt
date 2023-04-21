{% snapshot repeat_rate_snapshot %}
{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    unique_key='updated_at',
    strategy='timestamp',
    updated_at='updated_at'
   )
}}

with SRC as (
    select * FROM {{ ref('int_repeat_rate') }}
)
SELECT repeat_rate,
        updated_at,
        id_repeat_rate 
FROM SRC

{% endsnapshot %}