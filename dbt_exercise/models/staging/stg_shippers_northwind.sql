with shippers as (
    select *
    from {{ source('northwind', 'shippers') }}
)

select
    cast(shipper_id as string) as shipper_id
    , cast(company_name as string) as company_name
    , cast(phone as string) as phone
from shippers