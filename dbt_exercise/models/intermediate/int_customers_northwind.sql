with customers as (
    select *
    from {{ ref('stg_customers_northwind') }}
)

, final_table as (
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
    from customers
)

select *
from final_table