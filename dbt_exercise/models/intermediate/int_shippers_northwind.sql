with shippers as (
    select *
    from {{ ref('stg_shippers_northwind') }}
)

, orders as (
    select *
    from {{ ref('stg_orders_northwind') }}
)

, transformed_table as (
    select
        shippers.shipper_id
        , shippers.company_name
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
    from shippers
    left join orders
        on shippers.shipper_id = orders.ship_via
)

/* Aqui é feita a deduplicação da transformed_table */
, final_table as (
    select distinct *
    from transformed_table
)

select *
from final_table