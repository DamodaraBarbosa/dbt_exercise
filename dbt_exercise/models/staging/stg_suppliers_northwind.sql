with raw_suppliers as (
    select *
    from {{ source('northwind', 'suppliers') }}
)

, stg_suppliers_northwind as (
    select
        cast(supplier_id as string) as supplier_id
        , cast(company_name as string) as company_name
        , cast(contact_name as string) as contact_name
        , cast(contact_title as string) as contact_title
        , cast(address as string) as address
        , cast(city as string) as city
        , cast(region as string) as region
        , cast(postal_code as string) as postal_code
        , cast(country as string) as country
        , cast(phone as string) as phone
        , cast(fax as string) as fax
        , cast(homepage as string) as home_page
    from raw_suppliers
)

select *
from stg_suppliers_northwind