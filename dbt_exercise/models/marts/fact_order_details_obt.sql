with int_orders_northwind as (
    select *
    from {{ ref('int_orders_northwind') }}
)

, int_order_details_northwind as (
    select *
    from {{ ref('int_order_details_northwind') }}
)

, int_products_northwind as (
    select *
    from {{ ref('int_products_northwind') }}
)

, int_customers_northwind as (
    select *
    from {{ ref('int_customers_northwind') }}
)

, int_employees_northwind as (
    select *
    from {{ ref('int_employees_northwind') }}
)

, int_shippers_northwind as (
    select *
    from {{ ref('int_shippers_northwind') }}
)

, fact_order_details_obt as (
    select
        int_orders_northwind.order_id
        , int_customers_northwind.company_name as customer_name
        , int_customers_northwind.country as customer_country
        , int_customers_northwind.continent as customer_continent
        , int_employees_northwind.employee_name
        , int_employees_northwind.title as employee_title
        , int_orders_northwind.order_date
        , int_orders_northwind.required_date
        , int_orders_northwind.shipped_date
        , int_orders_northwind.days_to_ship
        , int_shippers_northwind.company_name as shipper_name
        , int_shippers_northwind.ship_city as shipper_city
        , int_shippers_northwind.ship_country as shipper_country
        , int_shippers_northwind.ship_continent as shipper_continent
        , int_orders_northwind.shipper_name
        , int_products_northwind.product_name
        , int_products_northwind.quantity_per_unit
        , int_products_northwind.category_name as product_category_name
        , int_products_northwind.supplier_name
        , int_products_northwind.supplier_country
        , int_order_details_northwind.unit_price
        , int_order_details_northwind.discount
        , int_orders_northwind.ship_name
        , int_orders_northwind.ship_address
        , int_orders_northwind.ship_city
        , int_orders_northwind.ship_region
        , int_orders_northwind.ship_country
        , int_orders_northwind.ship_continent
        , int_orders_northwind.is_shipped
    from int_orders_northwind
    left join int_order_details_northwind
        on int_orders_northwind.order_id = int_order_details_northwind.order_id
    left join int_products_northwind
        on int_order_details_northwind.product_id = int_products_northwind.product_id
    left join int_customers_northwind
        on int_orders_northwind.customer_id = int_customers_northwind.customer_id
    left join int_shippers_northwind
        on int_orders_northwind.ship_via = int_shippers_northwind.shipper_id
    left join int_employees_northwind
        on int_orders_northwind.employee_id = int_employees_northwind.employee_id
)

select * 
from fact_order_details_obt