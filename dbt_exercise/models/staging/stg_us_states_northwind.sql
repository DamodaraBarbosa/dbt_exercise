with us_states as (
    select *
    from {{ source('northwind', 'us_states') }}
)

select
    cast(state_id as string) as state_id
    , cast(state_name as string) as state_name
    , cast(state_abbr as string) as state_abbr
    , cast(state_region as string) as state_region
from us_states