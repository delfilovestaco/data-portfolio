SHOW DATABASES;
USE employees;

-- 1. 각 직원의 이름과 소속 부서 이름 조회
-- departments 테이블에 부서 이름과 코드 있음
-- employees 테이블에 사원번호와, 이름 있음
-- dept_emp 테이블에 사원번호, 부서코드 있음

-- table 3개 JOIN?
SELECT e.first_name, e.last_name, dp.dept_name
from employees e
join dept_emp d on e.emp_no = d.emp_no
join departments dp on d.dept_no = dp.dept_no;
-- ㄴ> 이렇게 하면, 부서 이름으로 자동 정렬 정리 돼서 나옴

SELECT e.first_name, e.last_name, dp.dept_name
from departments dp
join dept_emp d on dp.dept_no = d.dept_no
join employees e on e.emp_no = d.emp_no;
-- ㄴ> 이렇게 해도, 부서 이름으로 자동 정렬 정리 돼서 나옴

-- 2. 각 부서별 직원 수 구하기
  SELECT dp.dept_name, count(*) as total_employees 
  from employees e
  join dept_emp d on e.emp_no = d.emp_no
  join departments dp on d.dept_no = dp.dept_no
  group by dp.dept_name
  order by dp.dept_name asc;
  
  -- 3. sales 부서 소속 직원 이름만 조회
  select e.first_name, e.last_name, dp.dept_name 
  from employees e
  join dept_emp d on e.emp_no = d.emp_no
  join departments dp on d.dept_no = dp.dept_no
  where dp.dept_name = 'Sales'
  order by e.first_name asc;


