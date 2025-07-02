with raw_order_details as (
    select *
    from {{ source('northwind', 'order_details') }}
)

, stg_order_details_northwind as (
    select
        cast(order_id as string) as order_id
        , cast(product_id as string) as product_id
        , cast(unit_price as numeric) as unit_price
        , cast(quantity as integer) as quantity
        , cast(discount as numeric) as discount
    from raw_order_details
)

select *
from stg_order_details_northwind