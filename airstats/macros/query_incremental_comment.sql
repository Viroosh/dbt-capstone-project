{% macro query_incremental_comment() %}

    {% set query %}
        select
            comment_id,
            airport_ident,
            comment_subject,
            member_nickname,
            loaded_at
        from {{ ref('silver_airport_comments') }}
        where comment_subject = 'Capstone incremental test'
        order by comment_id desc
        limit 5
    {% endset %}

    {% set results = run_query(query) %}
    {{ log(results.columns[0].values(), info=True) }}

{% endmacro %}
