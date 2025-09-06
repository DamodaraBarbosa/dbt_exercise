with int_orders_northwind as (
    select *
    from {{ ref('int_orders_northwind') }}
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

, fact_order_details_obt as (
    select
        {{ dbt_utils.generate_surrogate_key(['int_orders_northwind.order_id', 'int_customers_northwind.customer_id', 'int_employees_northwind.employee_id', 'int_products_northwind.product_id', 'int_orders_northwind.ship_id']) }} as sk_orders
        , int_orders_northwind.order_id
        , int_customers_northwind.customer_id
        , int_customers_northwind.company_name as customer_name
        , int_customers_northwind.contact_name as customer_contact_name
        , int_customers_northwind.contact_title as customer_contact_title
        , int_customers_northwind.address as customer_address
        , int_customers_northwind.city as customer_city
        , int_customers_northwind.region as customer_region
        , int_customers_northwind.country as customer_country
        , int_customers_northwind.country as customer_continent
        , int_employees_northwind.employee_id
        , int_employees_northwind.employee_name
        , int_employees_northwind.title as employee_title
        , int_employees_northwind.address as employee_address
        , int_employees_northwind.city as employee_city
        , int_employees_northwind.region as employee_region
        , int_employees_northwind.country as employee_country
        , int_orders_northwind.order_date
        , int_orders_northwind.required_date
        , int_orders_northwind.shipped_date
        , int_orders_northwind.days_to_ship
        , int_orders_northwind.ship_id
        , int_orders_northwind.ship_via
        , int_orders_northwind.shipper_name
        , int_products_northwind.product_id
        , int_products_northwind.product_name
        , int_products_northwind.quantity_per_unit
        , int_products_northwind.category_name
        , int_products_northwind.supplier_name
        , int_products_northwind.supplier_city
        , int_products_northwind.supplier_region
        , int_products_northwind.supplier_country
        , int_products_northwind.supplier_continent
        , int_products_northwind.is_discontinued
        , int_orders_northwind.amount
        , int_orders_northwind.rationed_shipping
        , int_orders_northwind.ship_name
        , int_orders_northwind.ship_address
        , int_orders_northwind.ship_city
        , int_orders_northwind.ship_region
        , int_orders_northwind.ship_country
        , int_orders_northwind.ship_continent
        , int_orders_northwind.is_shipped
    from int_orders_northwind
    left join int_products_northwind
        on int_orders_northwind.product_id = int_products_northwind.product_id
    left join int_customers_northwind
        on int_orders_northwind.customer_id = int_customers_northwind.customer_id
    left join int_employees_northwind
        on int_orders_northwind.employee_id = int_employees_northwind.employee_id
)

select *
from fact_order_details_obt