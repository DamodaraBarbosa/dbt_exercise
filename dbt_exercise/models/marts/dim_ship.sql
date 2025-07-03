with int_shippers_northwind as (
    select *
    from {{ ref('int_shippers_northwind') }}
)

, dim_ship as (
    select
        {{ dbt_utils.generate_surrogate_key(['ship_id']) }} as sk_ship
        , ship_id
        , shipper_id
        , company_name
        , ship_address
        , ship_city
        , ship_region
        , ship_country
        , ship_continent
    from int_shippers_northwind
)

select *
from dim_ship