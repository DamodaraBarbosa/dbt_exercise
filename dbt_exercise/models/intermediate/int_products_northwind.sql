with products as (
    select *
    from {{ ref('stg_products_northwind') }}
)

, categories as (
    select *
    from {{ ref('stg_categories_northwind') }}
)

, suppliers as (
    select *
    from {{ ref('stg_suppliers_northwind') }}
)

, final_table as (
    select
        products.product_id
        , products.product_name
        , products.quantity_per_unit
        , categories.category_name
        , suppliers.company_name as supplier_name
        , suppliers.city as supplier_city
        , suppliers.region as supplier_region
        , suppliers.country as supplier_country
        , products.discontinued
    from products
    left join categories
        on products.category_id = categories.category_id
    left join suppliers
        on products.supplier_id = suppliers.supplier_id
)

select * 
from final_table