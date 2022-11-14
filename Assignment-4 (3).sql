--Full name	: Nihal Sriramoju
--Submission date : 10/17/2022
--Unid : u1432044
--Course name : IS 6420 Database Design
--Submission title : Assignment 4

-- 1. List the top 5 states by total volume of dollar sales in the Computer product line.

SELECT sum(ol.quantity * prod.product_price) as total_dollar_amount,cus.state_province FROM order_line ol left join product prod 
ON ol.product_id = prod.product_id left join order_header oh ON ol.order_id = oh.order_id left join customer cus 
ON oh.customer_id = cus.customer_id WHERE prod.product_line = 'Computers' group by cus.state_province order by total_dollar_amount desc
limit 5;

--2. Create a seasonality report with "Winter", "Spring", "Summer", "Fall", as the seasons.  List the season, product line, total quantity, 
--and total dollar amount of sales.  Sort by product line and then season in chronological order ("Winter", "Spring", "Summer", "Fall").
--You do not need to include the year.  

select case when extract(month from oh.order_date) in ('12', '1', '2') then 'Winter'when extract(month from oh.order_date) in 
('3', '4', '5') then 'Spring' when extract(month from oh.order_date) in ('6', '7', '8') then 'Summer'when extract(month	from oh.order_date)
in ('9', '10', '11') then 'Fall'else 'Other' end as season,prod.product_line, sum(ol.quantity) as total_quantity,	
sum(ol.quantity * prod.product_price) as total_dollar_sale FROM order_header oh left join order_line ol ON oh.order_id = ol.order_id 
left join product prod ON ol.product_id = prod.product_id group BY season,prod.product_line HAVING prod.product_line is not NULL and 
sum(ol.quantity) is not null order BY prod.product_line ,season;

--3. Create a query that returns the orders for Sept 2019 with the following columns (one row per order).  Hint: use a CASE statement
-- order_id
-- num_items   (number of items in the order)
-- num_computers   (number of computers in the order)

SELECT distinct ol.order_id,sum(ol.quantity) as num_items,sum( case when prod.product_line  = 'Computers' then ol.quantity 
else 0 end ) as num_computers FROM order_line ol inner join product prod ON ol.product_id = prod.product_id inner join 
order_header oh on ol.order_id  = oh.order_id  where oh.order_date  between '2019-09-01' and '2019-09-30' group BY ol.order_id ;

--4. Create a query that uses a Common Table Expression (CTE) and a Window Function to find the last (most recent) customer in each state to place an order.  Your query should return the following columns:
--state_province
--last_customer_name (split the name into first and last names, use the last name)  

with cte_last_customer_name as (select distinct state_province
, oh.order_date , split_part(customer_name, ' ', 1) as first_name
, split_part(customer_name, ' ', 2) as last_name
,rank() over(partition by state_province
order by order_date desc) as rk_order from customer c 
inner join order_header oh on oh.customer_id = c.customer_id 
where oh.order_date is not null order by state_province)

select distinct state_province , last_name
from cte_last_customer_name where rk_order = 1;

--5. Create the query from question #4 using a Temporary Table instead of a CTE. Please include a DROP IF EXISTS statement prior to 
-- your statement that creates the Temporary Table.

drop table if exists table_last_customer_name;
create temp table table_last_customer_name as (SELECT distinct state_province,oh.order_date,
split_part(customer_name, ' ', 1) as first_name, split_part(customer_name, ' ', 2) as last_name,rank() 
over(partition by state_province order BY order_date desc) as rank_order FROM customer cus inner join order_header oh ON 
oh.customer_id = cus.customer_id WHERE oh.order_date is not null order BY state_province);

SELECT distinct state_province,last_name as last_customer_name FROM table_last_customer_name where rank_order = 1;

--6. Create the query from question #4 using a View instead of a CTE. Please include a
-- DROP IF EXISTS statement prior to your statement that creates the View.

drop view if exists CTE_last_customer_name; create view CTE_last_customer_name as SELECT distinct state_province,oh.order_date ,
split_part(customer_name, ' ', 1) as first_name, split_part(customer_name, ' ', 2) as last_name,rank() 
over(partition by state_province order BY order_date desc) as rank_order FROM customer cus inner join 
order_header oh ON oh.customer_id = cus.customer_id WHERE oh.order_date is not null order BY state_province;

SELECT distinct state_province,last_name as last_customer_name FROM CTE_last_customer_name WHERE rank_order = 1;

--7. Create a role named product_administrator with permissions to SELECT and INSERT records into the product table.   
--Create a user named bob finance who is a member of that role.

create role product_administrator;
GRANT select,INSERT ON product to product_administrator;
create user "bob finance";
grant product_administrator to "bob finance";

