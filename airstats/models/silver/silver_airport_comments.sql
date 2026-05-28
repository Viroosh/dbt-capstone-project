{{
    config(
        materialized='incremental',
        unique_key='comment_id'
    )
}}

with source as (

    select * from {{ ref('src_airport_comments') }}

),

filtered as (

    select
        comment_id,
        airport_ident,
        comment_timestamp,
        coalesce(member_nickname, '__UNKNOWN__') as member_nickname,
        comment_subject,
        comment_body
    from source
    where comment_body is not null
      and trim(comment_body) != ''

)

select
    comment_id,
    airport_ident,
    comment_timestamp,
    member_nickname,
    comment_subject,
    comment_body,
    current_timestamp() as loaded_at
from filtered

{% if is_incremental() %}
where comment_id > (select coalesce(max(comment_id), 0) from {{ this }})
{% endif %}
