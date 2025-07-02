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
        , case
            when suppliers.country in ('USA', 'Canada') then 'North America'
            when suppliers.country in ('Brazil') then 'South America'
            when suppliers.country in ('UK', 'Germany', 'Netherlands', 'Spain', 'France', 'Norway', 'Italy', 'Denmark', 'Sweden', 'Finland') then 'Europe'
            when suppliers.country in ('Singapore', 'Japan') then 'Asia'
            when suppliers.country in ('Australia') then 'Oceania'
            else 'Other'
          end as supplier_continent
        , products.discontinued
    from products
    left join categories
        on products.category_id = categories.category_id
    left join suppliers
        on products.supplier_id = suppliers.supplier_id
)

select * 
from final_table