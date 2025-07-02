with raw_shippers as (
    select *
    from {{ source('northwind', 'shippers') }}
)

, stg_shippers_northwind as (
    select
        cast(shipper_id as string) as shipper_id
        , cast(company_name as string) as company_name
        , cast(phone as string) as phone
    from raw_shippers
)

select *
from stg_shippers_northwind
