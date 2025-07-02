with int_employees_northwind as (
    select *
    from {{ ref('int_employees_northwind') }}
)

, dim_employees as (
    select
        {{ dbt_utils.generate_surrogate_key(['employee_id']) }} as sk_employee
        , employee_id
        , employee_name
        , title
        , birth_date
        , age
        , hire_date
        , years_hired
        , address
        , city
        , region
        , country
    from int_employees_northwind
)
select *
from dim_employees