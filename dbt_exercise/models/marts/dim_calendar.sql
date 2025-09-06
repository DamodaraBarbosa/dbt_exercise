
with dates as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2008-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}
)

, calendar as (
    select
        cast(date_day as date) as date_day
        , extract(year from date_day) as year
        , extract(quarter from date_day) as quarter
        , extract(month from date_day) as month
        , format_date('%B', date_day) as month_name
        , extract(isoweek from date_day) as week_of_year
        , extract(day from date_day) as day_of_month
        , extract(dayofweek from date_day) as day_of_week -- 1=domingo, 7=sábado
        , format_date('%A', date_day) as day_name
        , case 
            when extract(dayofweek from date_day) in (1,7) then true 
            else false 
        end as is_weekend
    from dates
)

, dim_calendar as (
    select
        date_day as date
        , year
        , quarter
        , month
        , case 
            when month_name = 'January' then 'janeiro'
            when month_name = 'February' then 'fevereiro'
            when month_name = 'March' then 'março'
            when month_name = 'April' then 'abril'
            when month_name = 'May' then 'maio'
            when month_name = 'June' then 'junho'
            when month_name = 'July' then 'julho'
            when month_name = 'August' then 'agosto'
            when month_name = 'September' then 'setembro'
            when month_name = 'October' then 'outubro'
            when month_name = 'November' then 'novembro'
            when month_name = 'December' then 'dezembro'
        end as month_name
        , week_of_year
        , day_of_month
        , day_of_week
        , case 
            when day_name = 'Sunday' then 'domingo'
            when day_name = 'Monday' then 'segunda-feira'
            when day_name = 'Tuesday' then 'terça-feira'
            when day_name = 'Wednesday' then 'quarta-feira'
            when day_name = 'Thursday' then 'quinta-feira'
            when day_name = 'Friday' then 'sexta-feira'
            when day_name = 'Saturday' then 'sábado'
        end as day_name
        , is_weekend
    from calendar
)

select * 
from dim_calendar
