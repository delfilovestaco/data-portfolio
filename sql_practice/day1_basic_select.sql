-- <select : 원하는 정보 가져오기>

-- 1) SELECT 전체 조회
SELECT * from customers;

-- 2) 특정 컬럼만 조회
SELECT customername, country from customers;

-- 3) WHERE 조건 걸기
SELECT customername, country from customers where city ='Madrid';

-- 4) Order by 정렬
SELECT customername from customers where city = 'Madrid' order by customername asc;
SELECT customername from customers where city = 'Madrid' order by customername desc;

-- 5) distinct 해당 컬럼 중복된 값 제거
SELECT distinct city from customers order by city desc;

-- 6) 조건 조합 연습 WHERE + AND/OR
SELECT customername, city, country from customers where country ='spain' and city='madrid';
SELECT customername, city, country from customers where country ='spain' and city ='barcelona' or city='sevilla';
-- ㄴ> 연산자 우선순위
-- 1. 괄호 2. NOT 3. AND 4. OR
-- => 위의 문장 해석 : country가 spain 이면서 city가 barcelona 인 즉 두 개를 다 만족하는 데이터를 추려 놓음 
-- -> city가 sevilla인 데이터를 따로 추려서 둘 다 보여줌
SELECT customername, city, country from customers where country = 'spain' and city ='barcelona' or city ='berlin'
--ㄴ> 이러면 스페인의 바르셀로나와 독일의 베를린이 나옴
--and 를 or 에 각각 적용되게 하고 싶다면, 즉 (예를 들어) 다른 나라 말고 스페인의 바르셀로나와 스페인의 베를린이 보고 싶은 거야!
--=> 괄호 처리를 잘 해주면 됨
SELECT customername, city, country from customers where country = 'spain' and (city = 'barcelona' or city='sevilla')
--ㄴ> 이러면 스페인 AND (Barcelona OR Sevilla) 조건이 적용돼서, 스페인 밖의 Sevilla는 제외됨
--ㄴ> 왜냐하면, 일단 spain을 찾아놓고, city 가 바르셀로나 혹은 세비야인 데이터들을 다 찾음.
--그리고 도시가 바르셀로나 혹은 세비야이면서, and 국가가 스페인인 데이터들을 추리기 때문.
--만약에 예를들어 이탈리아 세비야 가 있었다면, 탈락됨. 
SELECT customername, city, country from customers where country = 'spain' and (city = 'barcelona' or city='berlin')
--ㄴ> 이러면 바르셀로나만 나옴. 일단 country 가 spain인 데이터 추려 놓고. 
-- city가 barcelona, berlin 인 것 추려 놓은 상태에서, and 연산자에 의해서 country 가 spain이고 city가 barcelna 인 
-- 혹은 country가 spain 이고 city가 berlin 인, 으로 계산이 되기 때문 

-- 7) 패턴 검색(LIKE) : 문자열 패턴으로 조건 걸기
SELECT * from customers where customername like 'al%'; 
--ㄴ> al로 시작하는 고객이름 조건
SELECT * from customers where customername like '%t'; 
--ㄴ> t로 끝나는 고객이름 조건
SELECT * from customers where customername like 'l%e'; 
--ㄴ> l로 시작하고, e로 끝나는 고객이름 조건
--* % : 0개 이상의 문자를 의미함
--* _ : 한 글자만을 의미

-- 8) 집계 예습(count)
select count(*) as totalcustomers from customers;
--ㄴ> count(*) : 전체 행(row, 즉 데이터 개수)를 세는 함수. *는 모든 열을 의미
--결과 적으로 이 조건에 맞는 행이 몇 개인가를 알려줌
select count(*) as USAcustomers from customers where country='usa';
--ㄴ> 나라가 usa 인 것을 추린 후 -> 행의 개수를 세니까 -> 나라가 USA 인 고객 수를 세는 것
select count(*) from customers; -- : 해당 데이터 셋의 모든 행의 개수를 세어줌, NULL 값이 있어도
select count(city) from customers; -- : 해당 컬럼의 NULL 값이 아닌 값만 세어줌
select count(distinct city) from customers; -- : 해당 컬럼의 중복값은 제외하고 유니크한 값 세어줌