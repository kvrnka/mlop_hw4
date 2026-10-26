{% macro amount_bucket(column_name) %}

CASE
    WHEN {{ column_name }} IS NULL THEN 'UNKNOWN'
    WHEN {{ column_name }} < 50 THEN 'SMALL'
    WHEN {{ column_name }} < 200 THEN 'MEDIUM'
    ELSE 'LARGE'
END

{% endmacro %}
