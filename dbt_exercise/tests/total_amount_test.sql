with source_orders as (
    select *
    from {{ source('northwind', 'orders') }}
)

, source_order_details as (
    select *
    from {{ source('northwind', 'order_details') }}
)

, fact_orders as (
    select *
    from {{ ref('fact_orders') }}
)

{# , range_dates as (
    select 
        min(order_date) as min_order_date
        , max(order_date) as max_order_date
    from source_orders
)

select * from range_dates #}

, source_amount as (
    select 
        sum(source_order_details.unit_price * source_order_details.quantity * (1 - source_order_details.discount)) as total_amount
    from source_orders
    left join source_order_details
        on source_orders.order_id = source_order_details.order_id
    where 
        format_date('%Y-%m', source_orders.order_date) = '1997-01'
)

, fact_amount as (
    select 
        sum(amount) as total_amount
    from fact_orders
    where 
        format_date('%Y-%m', order_date) = '1997-01'
)


select *
from fact_amount
where 
    total_amount != (select total_amount from source_amount)