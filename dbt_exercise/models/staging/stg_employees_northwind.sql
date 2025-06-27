with employees as (
    select *
    from {{ source('northwind', 'employees') }}
)

/* Os campos photo, notes e reports_to e photo_path não são carregadas na staging */
select
    cast(employee_id as string) as employee_id
    , cast(first_name as string) as first_name
    , cast(last_name as string) as last_name
    , cast(title as string) as title
    , cast(title_of_courtesy as string) as title_of_courtesy
    , cast(birth_date as date) as birth_date
    , cast(hire_date as date) as hire_date
    , cast(address as string) as address
    , cast(city as string) as city
    , cast(region as string) as region
    , cast(postal_code as string) as postal_code
    , cast(country as string) as country
    , cast(home_phone as string) as home_phone
    , cast(extension as string) as extension
from employees