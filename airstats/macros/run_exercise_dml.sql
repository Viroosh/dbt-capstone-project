{% macro run_exercise_dml() %}

    {% set new_id_query %}
        select coalesce(max(id), 0) + 1 as new_id from {{ source('comments', 'airport_comments') }}
    {% endset %}

    {% set new_id_result = run_query(new_id_query) %}
    {% if execute %}
        {% set new_id = new_id_result.columns[0].values()[0] %}
    {% else %}
        {% set new_id = 999999999 %}
    {% endif %}

    {% set insert_query %}
        insert into {{ source('comments', 'airport_comments') }} (
            id,
            thread_ref,
            airport_ref,
            airport_ident,
            date,
            member_nickname,
            subject,
            body,
            loaded_at
        )
        select
            {{ new_id }},
            {{ new_id }},
            a.id,
            'KLAX',
            current_timestamp(),
            'capstone_student',
            'Capstone incremental test',
            'This comment was inserted to validate the silver_airport_comments incremental model.',
            current_timestamp()
        from {{ source('raw', 'airports') }} as a
        where a.ident = 'KLAX'
        limit 1
    {% endset %}

    {% do run_query(insert_query) %}

    {% set update_query %}
        update {{ source('raw', 'airports') }}
        set type = 'closed'
        where ident = '01CN'
    {% endset %}

    {% do run_query(update_query) %}

    {{ log("Inserted airport comment with id " ~ new_id, info=True) }}
    {{ log("Updated airport 01CN type to closed", info=True) }}

{% endmacro %}
