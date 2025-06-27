with employee_territories as (
    select *
    from {{ source('northwind', 'employee_territories') }}
)

select
    cast(employee_id as string) as employee_id
    , cast(territory_id as string) as territory_id
from employee_territories