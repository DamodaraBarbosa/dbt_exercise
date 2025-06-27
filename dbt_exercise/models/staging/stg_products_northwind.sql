with products as (
    select *
    from {{ source('northwind', 'products') }}
)

select
    cast(product_id as string) as product_id
    , cast(product_name as string) as product_name
    , cast(supplier_id as string) as supplier_id
    , cast(category_id as string) as category_id
    , cast(quantity_per_unit as string) as quantity_per_unit
    , cast(unit_price as numeric) as unit_price
    , cast(units_in_stock as numeric) as units_in_stock
    , cast(units_on_order as numeric) as units_on_order
    , cast(reorder_level as numeric) as reorder_level
    , cast(discontinued as boolean) as discontinued
from products