--Full name:-Himani Reddy Lakky Reddy
--Submission date:- 3/12/2022
--Unid:- u1400919
--Course name:- IS_6420-Database Theory and Design
--Submission title:- Assignment-3-SQL

--1.List the ID, name, and price for all products with a price less than or equal to the average product price.
select product_id, product_name, product_price from product p group by product_id having product_price <= avg(product_price);

--2.For each product, list its ID and total quantity ordered. right
--Products should be listed in ascending order of the product ID.
select p.product_id, sum(oline.quantity) from product p left join order_line oline  on p.product_id = oline.product_id
group by p.product_id order by p.product_id asc;

--3.For each product, list its ID and total quantity ordered. 
-- Products should be listed in descending order of total quantity ordered.
select p.product_id, sum(oline.quantity) from product p left join order_line oline 
on p.product_id = oline.product_id group by p.product_id order by p.product_id desc;

--4.For each product, list its ID, name and total quantity ordered.
-- Products should be listed in ascending order of the product name.

select p.product_id, p.product_name, sum(oline.quantity)
from product p left join order_line oline  on p.product_id = oline.product_id
group by p.product_id order by p.product_name asc;

--5.List the name for all customers, who have placed 20 or more orders. 
--Each customer name should appear exactly once. Customer names should be sorted in ascending alphabetical order.

select c.customer_name
from order_header ohead left join customer c on ohead.customer_id = c.customer_id group by c.customer_id having count(ohead.order_id) >= 20 and c.customer_name is not null
order by c.customer_name ;

--6.Implement the previous query using a subquery and IN adding the requirement 
--that the customers orders have been placed after Nov 5, 2020.

select customer_name as "Customers_that_have_ordered_after_Nov 5,2020" from customer
where customer_id in (select customer_id from order_header  
where order_id in (select order_id from order_line where quantity >=20) 
and order_date > '2020-11-05')
group by customer_name order by customer_name;

--7.For each city, list the number of customers from that city, 
--who have placed 5 or more orders. Cities are listed in ascending alphabetical order.

select c.city,count(c.customer_id) as number_of_customers
from (
select c1.city, c1.customer_id
from customer c1 inner join order_header ohead 
on ohead.customer_id = c1.customer_id
group by c1.customer_id, city
having count(ohead.order_id) >= 5
and c1.customer_id is not null
) as c
group by city having c.city is not null order by city;

--8.Implement the previous using a subquery and IN.

select c.city,count(c.city) as number_of_customers
from customer c
where c.customer_id in (select customer_id
from order_header ohead group by ohead.customer_id
having count(ohead.order_id) >= 5
and ohead.customer_id is not null
)group by c.city having c.city is not null
order by c.city ;

--9.List the ID for all products, which have NOT been ordered on Nov 5, 2019 or after. 
--Sort your results by the product id in ascending order.  Use EXCEPT for this query.

select p.product_id 
from product p
inner join order_line oline 
on oline.product_id = p.product_id 
inner join order_header ohead 
on ohead.order_id = oline.order_id
except 
select order_id 
from order_header 
where order_date >= '2019-11-05' 
order by product_id;

--10.List the ID for all Arizona customers, who have placed one or more orders on Nov 5, 2019 or after. 
--Sort the results by the customer id in ascending order.  Use Intersect for this query.  
--Make sure to look for alternate spellings for Arizona, like "AZ"

select distinct c.customer_id
from customer c
where upper(state_province) in ('AZ', 'ARIZONA')
intersect 
select distinct c.customer_id
from customer c
left join order_header ohead
on c.customer_id = ohead.customer_id
where ohead.order_date >= '2019-11-05'
group by c.customer_id having count(ohead.order_id) >= 1 order by customer_id;

--11.Implement the previous query using a subquery and IN.
select distinct c.customer_id
from customer c where upper(state_province) in ('AZ', 'ARIZONA')
intersect  select distinct c.customer_id
from customer c
where c.customer_id in (
select ohead.customer_id
from order_header ohead
where ohead.order_date >= '2019-11-05'
group by ohead.customer_id
having count(ohead.order_id) >= 1
) order by customer_id;

--12.List the IDs for all California customers along with all customers 
--(regardless where they are from) who have placed one or more order(s) before Nov 5, 2020. 
--Sort the results by the customer id in ascending order.  Use union for this query.

select distinct customer_id
from customer
where upper(state_province) in ('CA', 'CALIFORNIA')
union select distinct customer_id
from order_header ohead
where ohead.order_date < '2020-11-05'
group by customer_id
having count(order_id) >= 1
order by customer_id;

--13.List the product ID, product name and total quantity ordered for all products 
--with total quantity ordered greater than 6.

select p.product_id, p.product_name, count(oline.quantity) as total_quantity_ordered from product p left join order_line oline on p.product_id = oline.product_id group by p.product_id;

--14.List the product ID, product name  and total quantity ordered for all products 
--with total quantity ordered greater than 4 and were placed by Nevada customers. 
-- Make sure to look for alternative spellings for Nevada state, such as "NV".
select p.product_id, p.product_name, count(oline.quantity) as total_quantity_ordered
from product p
left join order_line oline 
on 
p.product_id = oline.product_id
left join order_header ohead 
on
oline.order_id = ohead.order_id 
left join customer c 
on
ohead.customer_id = c.customer_id 
where upper(c.state_province) in ('NV','NEVADA')
group by p.product_id
having count(oline.quantity) > 4;

