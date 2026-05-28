select *
from {{ ref('silver_airport_comments') }}
where member_nickname is null
