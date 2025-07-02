with int_products as (
    select *
    from {{ ref('int_products_northwind') }}
)

, dim_products as (
    select
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as sk_product
        , product_id
        , product_name
        , quantity_per_unit
        , category_name
        , supplier_name
        , supplier_city
        , supplier_region
        , supplier_country
        , supplier_continent
        , discontinued
    from int_products
)

select *
from dim_products