with stg_products_northwind as (
    select *
    from {{ ref('stg_products_northwind') }}
)

, stg_categories_northwind as (
    select *
    from {{ ref('stg_categories_northwind') }}
)

, stg_suppliers_northwind as (
    select *
    from {{ ref('stg_suppliers_northwind') }}
)

, final_table as (
    select
        stg_products_northwind.product_id
        , stg_products_northwind.product_name
        , stg_products_northwind.quantity_per_unit
        , stg_categories_northwind.category_name
        , stg_suppliers_northwind.company_name as supplier_name
        , stg_suppliers_northwind.city as supplier_city
        , stg_suppliers_northwind.region as supplier_region
        , stg_suppliers_northwind.country as supplier_country
        , case
            when stg_suppliers_northwind.country in ('USA', 'Canada') then 'North America'
            when stg_suppliers_northwind.country in ('Brazil') then 'South America'
            when stg_suppliers_northwind.country in ('UK', 'Germany', 'Netherlands', 'Spain', 'France', 'Norway', 'Italy', 'Denmark', 'Sweden', 'Finland') then 'Europe'
            when stg_suppliers_northwind.country in ('Singapore', 'Japan') then 'Asia'
            when stg_suppliers_northwind.country in ('Australia') then 'Oceania'
            else 'Other'
          end as supplier_continent
        , case 
            when stg_products_northwind.discontinued = 1 then True
            else False
        end as is_discontinued
    from stg_products_northwind
    left join stg_categories_northwind
        on stg_products_northwind.category_id = stg_categories_northwind.category_id
    left join stg_suppliers_northwind
        on stg_products_northwind.supplier_id = stg_suppliers_northwind.supplier_id
)

select *
from final_table