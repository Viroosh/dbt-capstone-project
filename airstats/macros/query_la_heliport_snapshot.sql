{% macro query_la_heliport_snapshot() %}

    {% set query %}
        select *
        from {{ ref('scd_silver_airports') }}
        where airport_ident = '01CN'
        order by dbt_valid_from
    {% endset %}

    {% set results = run_query(query) %}
    {% do results.print_table() %}

{% endmacro %}
