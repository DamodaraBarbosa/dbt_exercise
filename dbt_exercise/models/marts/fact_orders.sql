with int_orders_northwind as (
    select *
    from {{ ref('int_orders_northwind') }}
)

, dim_products as (
    select *
    from {{ ref('dim_products') }}
)

, dim_customers as (
    select *
    from {{ ref('dim_customers') }}
)

, dim_ship as (
    select *
    from {{ ref('dim_ship') }}
)

, dim_employees as (
    select *
    from {{ ref('dim_employees') }}
)

, fact_orders as (
    select 
        {{ dbt_utils.generate_surrogate_key(['int_orders_northwind.order_id', 'dim_customers.customer_id', 'dim_employees.employee_id', 'dim_products.product_id']) }} as sk_orders
        , int_orders_northwind.order_id
        , dim_customers.sk_customer
        , int_orders_northwind.customer_id
        , dim_employees.sk_employee
        , int_orders_northwind.employee_id
        , int_orders_northwind.order_date
        , int_orders_northwind.required_date
        , dim_ship.sk_ship
        , int_orders_northwind.ship_id
        , int_orders_northwind.shipped_date
        , int_orders_northwind.days_to_ship
        , dim_products.sk_product
        , int_orders_northwind.product_id
        , int_orders_northwind.amount
        , int_orders_northwind.rationed_shipping
        , int_orders_northwind.is_shipped
    from int_orders_northwind
    left join dim_products
        on int_orders_northwind.product_id = dim_products.product_id
    left join dim_customers
        on int_orders_northwind.customer_id = dim_customers.customer_id
    left join dim_employees
        on int_orders_northwind.employee_id = dim_employees.employee_id
    left join dim_ship
        on int_orders_northwind.ship_id = dim_ship.ship_id
)

select *
from fact_orders