with region as (
    select *
    from {{ source('northwind', 'region') }}
)

select 
    cast(region_id as string) as region_id
    , cast(region_description as string) as region_description
from region