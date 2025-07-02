with stg_orders_northwind as (
    select *
    from {{ ref('stg_orders_northwind') }}
)

, stg_order_details_northwind as (
    select *
    from {{ ref('stg_order_details_northwind') }}
)

, stg_shippers_northwind as (
    select *
    from {{ ref('stg_shippers_northwind') }}
)

, transformed_table as (    
    select
        stg_orders_northwind.order_id 
        , stg_orders_northwind.customer_id
        , stg_orders_northwind.employee_id
        , stg_orders_northwind.order_date
        , stg_orders_northwind.required_date
        , stg_orders_northwind.shipped_date
        , date_diff(stg_orders_northwind.shipped_date, stg_orders_northwind.order_date, day) as days_to_ship
        , concat(
            coalesce(stg_orders_northwind.ship_via, '')
            , '-'
            , coalesce(stg_shippers_northwind.company_name, '')
            , '-'
            , coalesce(stg_orders_northwind.ship_address, '')
        ) as ship_id
        , stg_orders_northwind.ship_via      
        , stg_shippers_northwind.company_name as shipper_name
        , sum(stg_order_details_northwind.unit_price * stg_order_details_northwind.quantity * (1 - stg_order_details_northwind.discount)) as total_order_amount
        , stg_orders_northwind.freight
        , stg_orders_northwind.ship_name
        , stg_orders_northwind.ship_address
        , stg_orders_northwind.ship_city
        , stg_orders_northwind.ship_region
        , stg_orders_northwind.ship_country
        , case
            when stg_orders_northwind.ship_country in ('USA', 'Canada', 'Mexico') then 'North America'
            when stg_orders_northwind.ship_country in ('UK', 'France', 'Germany', 'Austria', 'Belgium', 
            'Denmark', 'Ireland', 'Finland', 'Italy', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland') then 'Europe'
            when stg_orders_northwind.ship_country in ('Brazil', 'Argentina', 'Venezuela') then 'South America'
            else 'Other'
        end as ship_continent
    from stg_orders_northwind
    left join stg_order_details_northwind
        on stg_orders_northwind.order_id = stg_order_details_northwind.order_id
    left join stg_shippers_northwind
        on stg_orders_northwind.ship_via = stg_shippers_northwind.shipper_id
    group by 
        stg_orders_northwind.order_id
        , stg_orders_northwind.customer_id
        , stg_orders_northwind.employee_id
        , stg_orders_northwind.order_date
        , stg_orders_northwind.required_date
        , stg_orders_northwind.shipped_date
        , stg_orders_northwind.ship_via
        , stg_shippers_northwind.company_name
        , stg_orders_northwind.freight
        , stg_orders_northwind.ship_name
        , stg_orders_northwind.ship_address
        , stg_orders_northwind.ship_city
        , stg_orders_northwind.ship_region
        , stg_orders_northwind.ship_country
)

, int_orders_northwind as (
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
from int_orders_northwind