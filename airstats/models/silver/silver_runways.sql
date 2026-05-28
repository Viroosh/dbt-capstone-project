with source as (

    select * from {{ ref('src_runways') }}

)

select
    runway_id,
    airport_ident,
    runway_length_ft,
    runway_width_ft,
    coalesce(nullif(trim(runway_surface), ''), '__UNKNOWN__') as runway_surface,
    runway_lighted,
    runway_closed
from source
