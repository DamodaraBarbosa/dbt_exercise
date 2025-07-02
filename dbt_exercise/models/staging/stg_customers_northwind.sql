with raw_customers as (
    select *
    from {{ source('northwind', 'customers') }}
)

, stg_customers_northwind as (
    select
        cast(customer_id as string) as customer_id
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
    from raw_customerscustomers
)

select *
from stg_customers_northwind