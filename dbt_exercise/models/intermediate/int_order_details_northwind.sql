with stg_order_details_northwind as (
    select *
    from {{ ref('stg_order_details_northwind') }}
)

, int_order_details_northwind as (
    select 
        order_id
        , product_id
        , unit_price
        , quantity
        , discount
    from stg_order_details_northwind
)

select * 
from int_order_details_northwind