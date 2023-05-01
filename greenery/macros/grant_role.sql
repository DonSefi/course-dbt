{% macro grant_role(role_name) %}
    GRANT SELECT on {{this}} to {{role_name}}
{% endmacro %}