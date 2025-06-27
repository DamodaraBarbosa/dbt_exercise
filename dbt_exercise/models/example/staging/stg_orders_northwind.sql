with orders as (
    select *
    from {{ source('dbt_dw_raw', 'orders') }}
)

select
    cast(order_id, string) as order_id
    , cast(customer_id, string) as customer_id
    , cast(employee_id, string) as employee_id
    , cast(order_date, date) as order_date
    , cast(required_date, date) as required_date
    , cast(shipped_date, date) as shipped_date
    , cast(ship_via, string) as ship_via
    , cast(freight, decimal(10, 2)) as freight
    , cast(ship_name, string) as ship_name
    , cast(ship_address, string) as ship_address
    , cast(ship_city, string) as ship_city
    , cast(ship_region, string) as ship_region
    , cast(ship_postal_code, string) as ship_postal_code
    , cast(ship_country, string) as ship_country
from orders