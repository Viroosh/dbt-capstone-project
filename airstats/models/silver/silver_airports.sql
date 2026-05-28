with source as (

    select * from {{ ref('src_airports') }}

)

select * from source
