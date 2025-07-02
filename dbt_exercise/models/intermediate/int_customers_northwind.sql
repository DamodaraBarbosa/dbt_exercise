with stg_customers_northwind as (
    select *
    from {{ ref('stg_customers_northwind') }}
)

, int_customers_northwind as (
    select 
        customer_id
        , company_name
        , contact_name
        , contact_title
        , address
        , city
        , region
        , country
        , case 
            when country in ('USA', 'Canada', 'Mexico') then 'North America'
            when country in ('UK', 'France', 'Germany', 'Austria', 'Belgium', 'Denmark', 'Ireland'
            , 'Finland', 'Italy', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland') then 'Europe'
            when country in ('Brazil', 'Argentina', 'Venezuela') then 'South America'
            else 'Other'
        end as continent
    from stg_customers_northwind
)

select *
from int_customers_northwind