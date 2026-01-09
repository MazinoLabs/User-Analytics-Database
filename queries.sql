--Total number of registered users
select count(*) as "Total Users" from users;

--Users per country (top 10)
select country, count(country) as "Total Users"
from users
group by
    country
order by count(country) desc
limit 10;

--Gender distribution
select gender, count(gender) as "Total Users"
from users
group by
    gender
order by gender;

--Users registered in the last 30 days
select *
from users
where
    registered_at >= now() - interval '30days';

--Oldest and youngest users
--Oldest
select min(date_of_birth) from users;

select first_name, last_name, EXTRACT(
        YEAR
        FROM AGE (NOW(), date_of_birth)
    ) AS age
from users
where
    date_of_birth = (
        select min(date_of_birth)
        from users
    );

--Youngest
select max(date_of_birth) from users;

select
    first_name,
    last_name,
    date_of_birth
from users
where
    date_of_birth = (
        select max(date_of_birth)
        from users
    );

--Users with Gmail, Yahoo, or corporate emails
select count(email)
from users
where
    email ilike '%gmail%'
    or email ilike '%yahoo%'
    or email ilike '%facebook%';

select count(email)
from users
where
    email not ilike '%gmail%'
    and email not ilike '%facebook%'
    and not ilike '%yahoo%';

--Users born between 1990 and 2000
select *
from users
where
    date_of_birth between date '1990-01-01' and '2000-12-31';

select count(*)
from users
where
    date_of_birth between date '1990-01-01' and '2000-12-31';

--Countries with more than 50 users
select country, count(*)
from users
group by
    country
having
    count(*) > 50;

--Most recent 20 registrations
select * from users order by registered_at limit 20;

--Distinct list of countries represented
select distinct country from users;