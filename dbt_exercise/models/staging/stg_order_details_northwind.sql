with order_details as (
    select *
    from {{ source('northwind', 'order_details') }}
)

select
    cast(order_id as string) as order_id
    , cast(product_id as string) as product_id
    , cast(unit_price as numeric) as unit_price
    , cast(quantity as integer) as quantity
    , cast(discount as numeric) as discount
from order_details