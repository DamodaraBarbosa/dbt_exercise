with territories as (
    select *
    from {{ source('northwind', 'territories') }}
)

select 
    cast(territory_id as string) as territory_id
    , cast(territory_description as string) as territory_description
    , cast(region_id as string) as region_id
from territories