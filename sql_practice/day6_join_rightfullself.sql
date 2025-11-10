Show databases;
use employees;
select * from employees;

-- 1. inner join 과 left join 비교하기
select e.emp_no, e.first_name, d.dept_name
from employees e
inner join dept_emp de on e.emp_no = de.emp_no
inner join departments d on de.dept_no = d.dept_no;

select e.emp_no, e.first_name, d.dept_name
from employees e
left join dept_emp de on e.emp_no = de.emp_no
left join departments d on de.dept_no = d.dept_no;

-- 실제 테이블의 총 행의 수를 파악해서 join, left join 차이 비교하기
-- 1) inner join
-- : employees, dept_emp, deptarments 테이블에 매칭되는 값만 들어왔을 것
select count(*) -- 331603
from employees e
inner join dept_emp de on e.emp_no = de.emp_no
inner join departments d on de.dept_no = d.dept_no;
-- 2) left join
-- : employees 행 전부 + dept_emp가 매칭되는 행 -> 조인된 테이블 행 전부 + departments가 매칭되는 행
select count(*) -- 331603
from employees e
left join dept_emp de on e.emp_no = de.emp_no
left join departments d on de.dept_no = d.dept_no;
-- ㄴ> 결과 같음. null 값이 없다는 뜻. 
-- 진짜 없나?
select * from employees where emp_no is null;
select * from dept_emp where emp_no is null or dept_no is null;
select * from departments where dept_no is null;

-- 2. right join
-- 위의 테이블에는 null 값이 없음. null 값이 있는 테이블을 만들어서 실습
show tables;

create table employees2 (
	emp_no int, -- primary key 로 지정하면 데이터 집어 넣을 때, 생략 불가함
    first_name varchar(50),
    last_name varchar(100)
);
drop table employees2;
insert into employees2 (emp_no, first_name, last_name) values
(001, 'dabin', 'lee'),
(002, 'jimin', 'park'),
(003, 'dasom', 'lee'),
(004, 'jiyeon', 'son');
insert into employees2(first_name, last_name) values
('matteo', 'ricci');
select * from employees2;

create table emp_dept2(
	emp_no int,
    dept_no int
);
drop table emp_dept2;
insert into emp_dept2(emp_no, dept_no) values
(001, 1111),
(002, 2222),
(004, 1111),
(004, 2222),
(005, 3333);
insert into emp_dept2(dept_no) values
(4444);
select * from emp_dept2;

create table departments2(
	dept_no int,
    dept_name varchar(100)
);
insert into departments2(dept_no, dept_name) values
(1111, 'marketing'),
(2222, 'development'),
(5555, 'design');
insert into departments2(dept_name) values
('HR');
select * from departments2;

-- inner와 left, right join 비교
-- 1) inner join
select * from employees2; -- 5, 1234null
select * from emp_dept2; -- 5, 12445null / 1111222233334444
select * from departments2; -- 4, 111122225555null

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



 

