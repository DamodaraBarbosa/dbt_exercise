with raw_categories as (
    select *
    from {{ source('northwind', 'categories') }}
)

/* Ao construir a staging não vamos trazer a coluna picture, pois ela não traz informação relevante */
, stg_categories_northwind as (
    select
        cast(category_id as string) as category_id
        , cast(category_name as string) as category_name
        , cast(description as string) as description
    from raw_categories
)

select *
from stg_categories_northwind