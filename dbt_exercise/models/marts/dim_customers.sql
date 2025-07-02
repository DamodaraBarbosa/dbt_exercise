with int_customers_northwind as (
    select *
    from {{ ref('int_customers_northwind') }}
)

, dim_customers as (
    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as sk_customer
        , customer_id
        , company_name
        , contact_name
        , contact_title
        , address
        , city
        , region
        , country
        , continent
    from int_customers_northwind
)

select *
from dim_customers