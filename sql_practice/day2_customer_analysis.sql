SELECT version();
CREATE DATABASE sql_practice_db;
USE sql_practice_db;

Create table Customers(
	customer_id INT auto_increment primary key,
    customer_name varchar(100),
    city varchar(50), 
    country varchar(50)
);

create table Orders(
	order_id int auto_increment primary key,
    customer_id int,
    order_date date,
    amount decimal(10,2),
    foreign key(customer_id) references customers(customer_id)
);

insert into customers (customer_name, city, country) values
('Maria Lopez', 'Madrid', 'Spain'),
('John Smith', 'London', 'UK'),
('Carlos Perez', 'Barcelona', 'Spain'),
('Sophie Dubois', 'Paris', 'France'),
('Minji Kim', 'Seoul', 'Korea');
insert into customers (customer_name, city, country) values
('Emma Brown', 'London', 'UK'),
('David Kim', 'Seoul', 'Korea'),
('Lucía Torres', 'Madrid', 'Spain'),
('Maria Gomez', 'Valencia', 'Spain'),
('Tom Chen', 'Taipei', 'Taiwan'),
('Elena Park', 'Seoul', 'Korea');

insert into orders (customer_id, order_date, amount) values
(1, '2025-10-01', 120.50),
(2, '2025-10-03', 75.20),
(3, '2025-10-05', 250.00),
(4, '2025-10-10', 180.00),
(5, '2025-10-12', 90.00);


select * from customers;
select * from customers where country ='Korea'order by customer_id desc;
select * from customers where country ='spain' and city ='madrid';

select * from customers where customer_name like 'L%';
select * from customers where customer_name like '%m%';
select * from customers where customer_name not like '%m%';

select country from customers;
select distinct country from customers;

select * from customers limit 5; 
select customer_id, customer_name from customers order by customer_id desc limit 5;

-- count
select * from customers;
-- 모든 행의 개수 즉 null 값이 있더라도 모든 데이터의 개수를 가져옴
select count(*) as total_customers from customers;
-- 여기서 만약에, 특정 컬럼 기준 null 값이 없는 행의 개수가 궁금하다면?
insert into customers (customer_name, city, country) values
('liam', '' , 'Italy'); 
-- ㄴ> null 값 만들기 위함 -> null 값으로 인식하지 않음. 빈 문자열로 인식함
-- update customers set city = where customer_name = 'liam';
-- ㄴ> 오류. = 오른쪽에 어떤 값으로 바꿀지 지정해야 함
update customers set city = NULL where customer_id = 12; -- null 값으로 변경
select count(city) as customer_with_city from customers;
insert into customers (customer_name, country) values
('lucas', 'spain'); -- 처음부터 null 값을 적용해서 데이터 삽입
-- 조건에 부합하는 데이터의 개수를 구한다.
select count(*) as spainish_customers 
from customers where country = 'spain';
-- 근데 여기서, 1) 조건을 제외한 데이터 개수를 세고 싶다면? 즉 국가가 스페인이 아닌 사람 수
select count(*) as non_spanish_customer 
from customers where country <> 'spain';
select count(*) as non_spanish_customer 
from customers where country != 'spain';
-- ㄴ> = 대신 != 혹은 <>(같지 않다) 써주면 됨
-- 근데 여기서, country 에 null 값이 있다? 위 처럼 하면, null 값 안셈.
-- 즉, 스페인 3개 + null 값 2개 => 5개 제외함
-- null 값은 세고, 내가 조건을 건 것만 제외하고 싶다면
-- 즉, 스페인 3개는 제외하되, null 값은 포함하고 싶다면
select count(*) as non_spanish_customer 
from customers where country != 'spain' or country is null; 
select count(*) as non_madrid_customer
from customers where city <> 'madrid'; -- madrid, null 제외 => 9
select count(*) as non_madrid_custmer
from customers where city <> 'madrid' or city is null; -- madrid 제외 => 11
-- 그리고 여기서, 2) 개수 뿐만 아니라, 고객의 이름이나 국가 이름도 같이 가져오고 싶다면?
-- select customer_name, city, count(*) from customers where city = 'madrid';
-- ㄴ> 여기서 group by 가 쓰임. 집계 함수와 일반 컬럼이 섞여 있는데 group by가 없으면 안됨!
-- ㄴ> count, sum, avg 등 집계 함수는 group by 와 같이 사용해야 일반 컬럼과 같이 쓸 수 있음
-- 예를 들어, city 별 고객 수를 보고 싶다 + 고객의 이름과, 도시의 이름도 같이 시각화 하고 싶다
select customer_name, city, count(*) as madrid_customer 
from customers where city = 'madrid' group by customer_name, city; 

-- group by
-- : 집계 함수(count, sum, avg...) 와 함께 데이터를 그룹별로 묶어서 계산할 때 쓰는 키워드
-- ㄴ> 같은 값끼리 묶는 역할. 
-- ㄴ> group by 없으면, count(*)는 전체 행 수 계산 / 있으면, 그룹 별로 count 등 집계 계산
-- ㄴ> SELECT 에 쓴 일반 컬럼은 모두 group by 안에 포함시켜야 함!  
select country, count(*) as customer_count 
from customers group by country; 
-- ㄴ> 보여줘, 나라 이름이랑 총 행의 개수를(customer_count 라는 컬럼명을 붙여서)
-- customers 테이블을 탐색하되, country를 기준으로 그룹화해서 진행해
select customer_id, customer_name, city, count(*) as madrid_customers 
from customers where city = 'madrid'
group by customer_id, customer_name, city;
select customer_id, customer_name, city, count(*) as non_madrid_customers
from customers where city != 'madrid' or city is null
group by customer_id, customer_name, city
order by city asc;

-- group by + having : group by 로 만들어진 그룹 결과에 조건을 걸 때 사용 
-- 차이점, where 조건 : 원본 테이블 행(row) 에 조건을 적용함
-- having 조건 : 그름화 후 집계 결과에 조건을 적용함  
select country, count(*) as total_customers 
from customers group by country; -- 이렇게 하면 국가로 그룹을 지어서 고객 수를 보여줌
select country, count(*) as customers_more_3
from customers group by country having count(*) >=3;
-- ㄴ>이렇게 하면, 일단 country 별로 그룹화를 하고, 그 그룹화된 데이터에 또 조건을 걸 수 있음
-- ㄴ> having count(*) 조건 : 전부를 셀 건데(*), 특정한 조건을 가진 것들만(having, 조건)

-- 집계 + 정렬
select country, count(*) as customer_count
from customers group by country; -- 국가 기준으로 그룹화해서 개수 나옴
select country, count(*) as customer_count
from customers group by country order by customer_count asc;
-- ㄴ> 정렬도 가능

