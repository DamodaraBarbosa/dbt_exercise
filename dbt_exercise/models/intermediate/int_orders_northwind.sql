with orders as (
    select *
    from {{ ref('stg_orders_northwind') }}
)

, order_details as (
    select *
    from {{ ref('stg_order_details_northwind') }}
)

, shippers as (
    select *
    from {{ ref('stg_shippers_northwind') }}
)

, transformed_table as (    
    select
        orders.order_id 
        , orders.customer_id
        , orders.employee_id
        , orders.order_date
        , orders.required_date
        , orders.shipped_date
        , date_diff(orders.shipped_date, orders.order_date, day) as days_to_ship
        , concat(
            coalesce(orders.ship_via, '')
            , '-'
            , coalesce(shippers.company_name, '')
            , '-'
            , coalesce(orders.ship_address, '')
        ) as ship_id
        , orders.ship_via      
        , shippers.company_name as shipper_name
        , sum(order_details.unit_price * order_details.quantity * (1 - order_details.discount)) as total_order_amount
        , orders.freight
        , orders.ship_name
        , orders.ship_address
        , orders.ship_city
        , orders.ship_region
        , orders.ship_country
        , case
            when orders.ship_country in ('USA', 'Canada', 'Mexico') then 'North America'
            when orders.ship_country in ('UK', 'France', 'Germany', 'Austria', 'Belgium', 
            'Denmark', 'Ireland', 'Finland', 'Italy', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland') then 'Europe'
            when orders.ship_country in ('Brazil', 'Argentina', 'Venezuela') then 'South America'
            else 'Other'
        end as ship_continent
    from orders
    left join order_details
        on orders.order_id = order_details.order_id
    left join shippers
        on orders.ship_via = shippers.shipper_id
    group by 
        orders.order_id
        , orders.customer_id
        , orders.employee_id
        , orders.order_date
        , orders.required_date
        , orders.shipped_date
        , orders.ship_via
        , shippers.company_name
        , orders.freight
        , orders.ship_name
        , orders.ship_address
        , orders.ship_city
        , orders.ship_region
        , orders.ship_country
)

, final_table as (
    select
        transformed_table.order_id
        , transformed_table.customer_id
        , transformed_table.employee_id
        , transformed_table.order_date
        , transformed_table.required_date
        , transformed_table.shipped_date
        , transformed_table.days_to_ship
        , transformed_table.ship_id
        , transformed_table.ship_via
        , transformed_table.shipper_name
        , transformed_table.total_order_amount
        , transformed_table.freight
        , transformed_table.ship_name
        , transformed_table.ship_address
        , transformed_table.ship_city
        , transformed_table.ship_region
        , transformed_table.ship_country
        , transformed_table.ship_continent
        , case 
            when transformed_table.days_to_ship is null then False
            else True
          end as is_shipped
    from transformed_table
)

select *
from final_table