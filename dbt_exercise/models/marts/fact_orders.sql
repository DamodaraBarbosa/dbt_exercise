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

{# , fact_orders as (

) #}

select *
from int_orders_northwind