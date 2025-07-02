with raw_employee_territories as (
    select *
    from {{ source('northwind', 'employee_territories') }}
)

, stg_employee_territories as (
    select
        cast(employee_id as string) as employee_id
        , cast(territory_id as string) as territory_id
    from raw_employee_territories
)

select *
from stg_employee_territories