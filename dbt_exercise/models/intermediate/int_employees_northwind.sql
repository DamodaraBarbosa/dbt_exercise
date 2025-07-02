with employees as (
    select *
    from {{ ref('stg_employees_northwind') }}
)

, max_fact_date as (
    select 
        case 
            when max(order_date) >= max(shipped_date) then max(order_date)
            else max(shipped_date)
        end as max_date
    from {{ ref('stg_orders_northwind') }}
)

, final_table as (
    select
        employee_id
        , concat(first_name, ' ', last_name) as employee_name
        , title
        , birth_date
        , date_diff((select * from max_fact_date), birth_date, year) as age
        , hire_date
        , date_diff((select * from max_fact_date), hire_date, year) as years_hired
        , address
        , city
        , region
        , country
    from employees
)

select *
from final_table