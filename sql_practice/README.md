## Day 1 - SQL Basics

**📅 Date:** 03/11/2025
**🎯 Focus:** Basic SQL commands (SELECT, WHERE, ORDER BY, DISTINCT)

**What I learned:**

- How to retrieve specific columns using `SELECT`
- How to filter data using `WHERE`
- How to sort results using `ORDER BY`
- How to remove duplicates using `DISTINCT`
- How logical operators `AND` / `OR` affect conditions
- Practiced pattern matching with `LIKE`

**Example Queries**

```sql
SELECT CustomerName, City, Country
FROM Customers
WHERE Country = 'Spain' AND City = 'Barcelona' OR City = 'Sevilla';

SELECT COUNT(*) FROM Customers;
SELECT DISTINCT City FROM Customers;
```

**Result:** Generated `day1_basic_select.sql` with all SQL queries practiced today.

## Day 2 - Data creation and aggregation

**📅 Date:** 04/11/2025
**🎯 Focus:** Practice data creation, filtering, and aggregation in MySQL.

**What I learned:**

- Created table `customers` and inserted sample data
- Practiced SELECT, WHERE, ORDER BY, LIKE, DISTINCT, LIMIT
- Learned to use aggregation: COUNT(), GROUP BY, HAVING
- Summarized customer data by country

**Example Queries**

```sql
select count(*) as non_madrid_custmer
from customers where city <> 'madrid' or city is null;
select customer_name, city, count(*) as madrid_customer
from customers where city = 'madrid' group by customer_name, city;

select customer_id, customer_name, city, count(*) as non_madrid_customers
from customers where city != 'madrid' or city is null
group by customer_id, customer_name, city
order by city asc;

select country, count(*) as customers_more_3
from customers group by country having count(*) >=3;

select country, count(*) as customer_count
from customers group by country order by customer_count asc;
```

**Result:** Generated `day2_customer_analysis.sql` with all SQL queries practiced today.

## Day 3 - SQL SELECT & WHERE Practice

**📅 Date:** 05/11/2025
**🎯 Focus:** Practice basic SELECT queries and filtering conditions in MySQL.

**What I learned:**

- Imported employees sample dataset into MySQL
- Practiced SELECT queries: choosing specific columns, using aliases
- Learned filtering with WHERE, AND/OR/NOT, BETWEEN, IN, LIKE
- Explored basic conditions on employee data: hire date, salary, and department

**Example Queries**

```sql
SHOW DATABASES;
USE employees;
SHOW TABLES;
select * from employees;

select
	emp_no as "직원 번호",
    first_name as "이름",
    last_name as "성",
    hire_date as "입사일"
from employees limit 10;

select emp_no, first_name, last_name, hire_date
from employees
where hire_date >= '1990-01-01' and last_name = 'Smith';
select * from employees where last_name like 'sm%' order by last_name asc;

select emp_no, first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1990-12-31'
order by hire_date asc;
```

**Result:** Generated `day3_practice_sql.sql` with all SQL queries practiced today.

## Day 4 - SQL JOIN Practice

**📅 Date:** 06/11/2025
**🎯 Focus:** Understanding and practicing different types of JOIN operations in MySQL.

**What I learned:**

- Practiced combining multiple tables using INNER JOIN, LEFT JOIN, and RIGHT JOIN
- Understood how joins merge rows based on matching values in key columns
- Learned the difference between inner and outer joins in terms of which rows are retained in the result
- Explored how NULL values behave in join conditions
- Clarified the logical structure of join execution (how joins build upon previous results step-by-step)

**Example Queries**

```sql
SELECT e.first_name, e.last_name, dp.dept_name
from employees e
join dept_emp d on e.emp_no = d.emp_no
join departments dp on d.dept_no = dp.dept_no;

 SELECT dp.dept_name, count(*) as total_employees
  from employees e
  join dept_emp d on e.emp_no = d.emp_no
  join departments dp on d.dept_no = dp.dept_no
  group by dp.dept_name
  order by dp.dept_name asc;

    select e.first_name, e.last_name, dp.dept_name
  from employees e
  join dept_emp d on e.emp_no = d.emp_no
  join departments dp on d.dept_no = dp.dept_no
  where dp.dept_name = 'Sales'
  order by e.first_name asc;
```

**Result:** Generated `day4_join.sql` containing all join-related practice queries and explanations.
