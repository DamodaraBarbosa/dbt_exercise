with orders as (
    select *
    from {{ ref('stg_orders_northwind') }}
)

, order_details as (
    select *
    from {{ ref('stg_order_details_northwind') }}
)

, final_table as (    
    select
        orders.order_id 
        , orders.customer_id
        , orders.employee_id
        , orders.order_date
        , orders.required_date
        , orders.shipped_date
        , date_diff('day', orders.order_date, orders.shipped_date) as days_to_ship
        , orders.ship_via
        , sum(order_details.unit_price * order_details.quantity * (1 - order_details.discount)) as total_order_amount
        , orders.freight
        , orders.ship_name
        , orders.ship_address
        , orders.ship_city
        , orders.ship_region
        , orders.ship_country
    from orders
    left join order_details
        on orders.order_id = order_details.order_id
)

select *
from final_table