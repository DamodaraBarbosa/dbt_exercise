with raw_orders as (
    select *
    from {{ source('northwind', 'orders') }}
)

, stg_orders_northwind as (
    select
        cast(order_id as string) as order_id
        , cast(customer_id as string) as customer_id
        , cast(employee_id as string) as employee_id
        , cast(order_date as timestamp) as order_date
        , cast(required_date as timestamp) as required_date
        , cast(shipped_date as timestamp) as shipped_date
        , cast(ship_via as string) as ship_via
        , cast(freight as numeric) as freight
        , cast(ship_name as string) as ship_name
        , cast(ship_address as string) as ship_address
        , cast(ship_city as string) as ship_city
        , cast(ship_region as string) as ship_region
        , cast(ship_postal_code as string) as ship_postal_code
        , cast(ship_country as string) as ship_country
    from raw_orders
)

select *
from stg_orders_northwind