SHOW DATABASES;
USE employees;
SELECT * from employees;

-- 1. INNER join 기본 : 교집합만 남는 구조 확인하기
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

-- 2. Left Join 연습 : 왼쪽 테이블 기준으로 모두 남기는 형태 확인
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
-- ㄴ> 어떤 부서에도 속하지 않는 직원들 찾는 것.
-- 사원 테이블의 모든 행을 유지하면서, 결합된 테이블에 매칭되는 값이 없으면 null로 채워 넣음
-- 따라서, where d.dept_name is null 을 걸면,
-- 부서테이블에 매칭되는 값이 없는, 즉 부서 정보가 없는 직원만 남게 됨.  

with left_join as(
	SELECT e.emp_no, e.first_name, e.last_name, de.dept_no
	FROM employees e 
	LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
)select count(*) from left_join as num; -- 331603

-- 중복된 행 찾아보기
SELECT e.emp_no, e.first_name, e.last_name, de.dept_no
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE e.emp_no IN (
    SELECT e.emp_no
    FROM employees e
    LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
    GROUP BY e.emp_no
    HAVING COUNT(*) > 1
)
ORDER BY e.emp_no;
-- ㄴ> 안쪽 쿼리(서브 쿼리) 먼저 이해하고 해석해야 함
-- : 둘을 조인한 테이블에서, 사원 번호 기준으로 그룸을 하고 카운트를하면, 사원 번호가 
-- 중복되는 즉, 부서가 여러 개 있는 사원의 수를 구할 수 있음 -> having 으로 2 이상 사원 추림
-- 그 결과가 사원 번호 1, 2, 3, 4 라고 가정해보자.
-- ㄴ> 바깥 쿼리는, 나한테 사원 번호, 이륾, 부서 번호를 보여주는데, 그 사원 번호가
-- 1, 2, 3, 4 즉, 여러 개의 부서를 가진 사원들에 대한 정보를 보여줘. 이렇게 되는 것


