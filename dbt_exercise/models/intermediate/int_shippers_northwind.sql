with stg_shippers_northwind as (
    select *
    from {{ ref('stg_shippers_northwind') }}
)

, stg_orders_northwind as (
    select *
    from {{ ref('stg_orders_northwind') }}
)

, transformed_table as (
    select
        concat(
            coalesce(stg_shippers_northwind.shipper_id, '')
            , '-'
            , coalesce(stg_shippers_northwind.company_name, '')
            , '-'
            , coalesce(stg_orders_northwind.ship_address, '')
        ) as ship_id
        , stg_shippers_northwind.shipper_id
        , stg_shippers_northwind.company_name
        , stg_orders_northwind.ship_address
        , stg_orders_northwind.ship_city
        , stg_orders_northwind.ship_region
        , stg_orders_northwind.ship_country
    from stg_shippers_northwind
    left join stg_orders_northwind
        on stg_shippers_northwind.shipper_id = stg_orders_northwind.ship_via
)

/* Aqui é feita a deduplicação da transformed_table */
, dedup_table as (
    select distinct *
    from transformed_table
)

, final_table as (
    select 
        *
        , case
            when dedup_table.ship_country in ('USA', 'Canada', 'Mexico') then 'North America'
            when dedup_table.ship_country in ('UK', 'France', 'Germany', 'Austria', 'Belgium', 
            'Denmark', 'Ireland', 'Finland', 'Italy', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland') then 'Europe'
            when dedup_table.ship_country in ('Brazil', 'Argentina', 'Venezuela') then 'South America'
            else 'Other'
        end as ship_continent
    from dedup_table
)

select *
from final_table