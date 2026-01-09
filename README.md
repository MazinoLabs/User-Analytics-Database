# User Demographics & Registration Analytics System

## Overview

This project is a PostgreSQL-based **User Analytics Database** designed to simulate a real-world business scenario. It stores user registration information and allows for meaningful analysis to answer business questions about demographics, registrations, and engagement.

The project demonstrates:

* Database design
* Data integrity using constraints
* SQL query skills for analysis
* Realistic dataset handling

---

## Tech Stack

* PostgreSQL
* SQL
* Mockaroo (for generating realistic user data)

---

## Database Schema

### `users` Table

| Column Name   | Data Type    | Constraint                |
| ------------- | ------------ | ------------------------- |
| id            | BIGSERIAL    | PRIMARY KEY, NOT NULL     |
| first_name    | VARCHAR(50)  | NOT NULL                  |
| last_name     | VARCHAR(50)  |                           |
| email         | VARCHAR(150) | UNIQUE                    |
| gender        | VARCHAR(10)  |                           |
| country       | VARCHAR(50)  |                           |
| date_of_birth | DATE         |                           |
| registered_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP |

---

## Queries

The following queries showcase real business questions and analytics:

### 1. Total number of registered users

```sql
SELECT COUNT(*) AS "Total Users" FROM users;
```

### 2. Users per country (top 10)

```sql
SELECT country, COUNT(country) AS "Total Users"
FROM users
GROUP BY country
ORDER BY COUNT(country) DESC
LIMIT 10;
```

### 3. Gender distribution

```sql
SELECT gender, COUNT(gender) AS "Total Users"
FROM users
GROUP BY gender
ORDER BY gender;
```

### 4. Users registered in the last 30 days

```sql
SELECT *
FROM users
WHERE registered_at >= NOW() - INTERVAL '30 days';
```

### 5. Oldest and youngest users

#### Oldest user

```sql
SELECT MIN(date_of_birth) FROM users;

SELECT first_name, last_name, EXTRACT(YEAR FROM AGE(NOW(), date_of_birth)) AS age
FROM users
WHERE date_of_birth = (SELECT MIN(date_of_birth) FROM users);
```

#### Youngest user

```sql
SELECT MAX(date_of_birth) FROM users;

SELECT first_name, last_name, date_of_birth
FROM users
WHERE date_of_birth = (SELECT MAX(date_of_birth) FROM users);
```

### 6. Users with Gmail, Yahoo, or corporate emails

```sql
SELECT COUNT(email)
FROM users
WHERE email ILIKE '%gmail%'
   OR email ILIKE '%yahoo%'
   OR email ILIKE '%facebook%';
```

#### Users without these emails

```sql
SELECT COUNT(email)
FROM users
WHERE email NOT ILIKE '%gmail%'
  AND email NOT ILIKE '%facebook%'
  AND email NOT ILIKE '%yahoo%';
```

### 7. Users born between 1990 and 2000

```sql
SELECT *
FROM users
WHERE date_of_birth BETWEEN DATE '1990-01-01' AND '2000-12-31';

SELECT COUNT(*)
FROM users
WHERE date_of_birth BETWEEN DATE '1990-01-01' AND '2000-12-31';
```

### 8. Countries with more than 50 users

```sql
SELECT country, COUNT(*)
FROM users
GROUP BY country
HAVING COUNT(*) > 50;
```

### 9. Most recent 20 registrations

```sql
SELECT * FROM users ORDER BY registered_at DESC LIMIT 20;
```

### 10. Distinct list of countries represented

```sql
SELECT DISTINCT country FROM users;
```

---

## What I Learned

* Importing real datasets into PostgreSQL using `\i` and COPY.
* Executing queries in the proper **order of execution**: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY.
* Using **intervals** and `EXTRACT` to calculate ages and filter by dates.
* Reinforced concepts of **constraints, primary keys, uniqueness**, and data integrity.
* Realized the practical value of SQL for **business insights**.

---


## How to Run This Project

1. Clone the repository.
2. Open PostgreSQL and connect to your server.
3. Run `schema.sql` to create the database and table.
4. Run `data_import.sql` to load the Mockaroo dataset.
5. Run `queries.sql` to execute the example queries.
6. Inspect results and explore further analytics.

---

