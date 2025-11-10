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

## Day 5 - SQL JOIN (INNER / LEFT)

**📅 Date:** 07/11/2025
**🎯 Focus:** Understanding and practicing SQL JOINs (INNER JOIN, LEFT JOIN)

**What I learned:**

- How to combine multiple tables using JOIN
- The difference between INNER JOIN and LEFT JOIN
- How to handle NULL values that result from joins
- How to identify duplicated keys after joins (using GROUP BY and HAVING)
- How to inspect data completeness and missing values after joining
- Practiced analyzing join results to understand which rows remain or disappear

**Key Concepts:**
| JOIN Type | Description | Output Characteristics |
| ------------ | --------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `INNER JOIN` | Returns rows with matching keys in both tables | Only common (intersection) rows remain |
| `LEFT JOIN` | Returns all rows from the left table and matching rows from the right | Keeps all left-side data, fills missing right-side data with `NULL` |

**Example Queries**

```sql
-- 1. INNER join basic
SELECT e.emp_no, e.first_name, e. last_name, d.dept_name
FROM employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
order by emp_no asc;

select count(*) as num_emplyees from employees; -- 300024
select count(*) as num_dept from dept_emp; -- 331603
select count(*) as num_employees_dept
from employees e
join dept_emp de on e.emp_no = de.emp_no; -- 331603
SELECT count(*) total_num
FROM employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no; -- 331603

SELECT count(emp_no) from employees; -- 300024
SELECT count(distinct emp_no) from employees; -- 300024
select count(emp_no) from dept_emp; -- 331603
select count(distinct emp_no) from dept_emp; -- 300024
-- ㄴ> 한 명의 사원이 여러 부서에 들어가 있는 것을 알 수 있음

-- 사람을 기준으로 부서가 몇 개 할당되어 있는지 보고 싶음
SELECT e.first_name, count(*) as dept_by_emp
from employees e
join dept_emp de on e.emp_no = de.emp_no
group by e.emp_no;

-- 사람을 기준으로 부서가 2개 이상 할당되어 있는 사람만 보고 싶음
-- ㄴ> where 쓰면 안 되지!!!!! 그룹화되어 있는 것을 필터링할 때는 having 이지!!
SELECT e.emp_no, e.first_name, count(*) as dept_by_emp
from employees e
join dept_emp de on e.emp_no = de.emp_no
group by e.emp_no, e.first_name
having dept_by_emp >=2;
-- ㄴ> group by 에 e.emp_no 말고도, e.first_name, e.last_name도 적어야 함
-- ㄴ> 표준 SQL 문법 관점 : SELECT 절에 있는 컬럼은 GROUP BY에 포함되어 있거나, 집계 함수로 감싸져 있어야 한다.

-- 저 위의 테이블에서 그럼 2개 부서가 할당된 사람이 몇 명인지는 못 보나?
-- : 서브쿼리
SELECT count(*) as num_of_multi_dept_emps
From(
	SELECT e.emp_no, e.first_name, count(*) as dept_by_emp
	from employees e
	join dept_emp de on e.emp_no = de.emp_no
	group by e.emp_no, e.first_name
	having dept_by_emp >=2
) as sub; -- 31579 => employees 테이블의 총 수 300.024 +  2개 이상인 사람 -> 331.603나옴

-- 서브쿼리2 : MySQL 8.0 이상에서 가능함.
with multi_dept as(
	SELECT e.emp_no, e.first_name, count(*) as dept_by_emp
	from employees e
	join dept_emp de on e.emp_no = de.emp_no
	group by e.emp_no, e.first_name
	having dept_by_emp >=2
)
select count(*) as num_of_multi_dept_emps
from multi_dept;

-- left join
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
LIMIT 10;
-- ㄴ> 일부 직원의 dempt_name 이 null일 수도 있다.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
where d.dept_name is null;
```

**Result:** Generated `day5_join_practice.sql` with INNER and LEFT JOIN examples and query results.

## Day 6 - SQL JOIN Mastery

**📅 Date:** 10/11/2025
**🎯 Focus:** Mastering all types of JOINs (INNER, LEFT, RIGHT, FULL OUTER, SELF JOIN) and practicing real-world scenarios in MySQL.

**What I learned:**

- Reviewed LEFT JOIN vs INNER JOIN differences
  ㄴ> INNER JOIN: only matching rows are retained
  ㄴ> LEFT JOIN: all left table rows are retained, unmatched right table rows become NULL
- Practiced RIGHT JOIN to understand the mirror of LEFT JOIN
  ㄴ> Right table rows are fully retained, unmatched left table rows become NULL
- Understood FULL OUTER JOIN concept and how to simulate it in MySQL using UNION
- Learned SELF JOIN to query hierarchical or relational data within the same table
  ㄴ> Example: finding employee-manager relationships or colleagues sharing the same attribute
- Clarified how NULL values propagate in different JOIN types
- Learned the importance of aliasing and column selection to avoid duplicate column names in JOIN results
- Generated multiple result sets and uploaded them to GitHub for practice and documentation

**Example Queries**

```sql
-- 1) inner join
select * from employees2 e2
join emp_dept2 ed2 on e2.emp_no = ed2.emp_no
-- ㄴ> 결과 : emp_no 이 1, 2인 것 하나씩 + 4인 것 2개, 총 4개
-- & dabin 1111, jimin 2222, jiyeon 1111, 2222
join departments2 d2 on ed2.dept_no = d2.dept_no;
-- ㄴ> 결과 : dabin 1111, jimin 2222, jyeon 1111, 2222.

-- 2) left join
select * from employees2 e2
left join emp_dept2 ed2 on e2.emp_no = ed2.emp_no
-- ㄴ> 결과 : 12344null(emp테이블의) - dasom, matteo dept_num null
left join departments2 d2 on ed2.dept_no = d2.dept_no;
-- ㄴ> 결과 : dabin1111, jimin2222, dasomnull, jiyyeon11112222,matteonull,
-- & dasom, matteo  dep_name null

-- 3) right join
select * from employees2 e2
right join emp_dept2 ed2 on e2.emp_no = ed2.emp_no;
-- ㄴ> emp_no이 1, 2 각각 하나, 4 둘, 5, null(empt_dept에서 온 것) 각각 하나
SELECT
    COALESCE(ed2.emp_no, e2.emp_no) AS emp_no,  -- 기준 컬럼 하나로 합치기
    ed2.dept_no,
    e2.first_name,
    e2.last_name
FROM employees2 e2
RIGHT JOIN emp_dept2 ed2 ON e2.emp_no = ed2.emp_no;

-- 4) self join
select e1.first_name as firstname1, e2.first_name as firstname2
from employees2 e1 join employees2 e2
where e1.last_name = e2.last_name
and e1.emp_no <> e2.emp_no;

select
coalesce(e1.first_name, e2.first_name) as emp_name, e1.last_name
from employees2 e1
join employees2 e2
where e1.last_name = e2.last_name
and e1.emp_no <> e2.emp_no;


```

**Result:** Generated `day6_join_rightfullself.sql`, with README documenting all JOIN types, differences, and practical insights.
