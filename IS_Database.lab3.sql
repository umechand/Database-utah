
/*Lab_3 Assignment
* Name: Dinakar Yadamala
* Unid: u1426832
* Submission date: 10-03-2022
* Course name: IS_6420
* Submission title: Lab_3
*/
 
--Guided Exercise:--
--1. List IDs of products that have been ordered. One ID appears 
--exactly one time. Order product IDs in ascending order.
 
select distinct product_id 
from product
order by product_id asc;
 
-- 2. List IDs of customers that have placed orders after October 27, 2019.
-- One ID appears exact one time. Order customer IDs in ascending order.
 
select distinct(customer_id) 
from order_header 
where order_date>'2019-10-27' 
order by customer_id asc;
 
-- 3. List the names of all customer who are from SLC and whose 
-- first name starts with the letter ëJí.
 
select customer_name 
from customer 
where city like '%Salt Lake City%' and customer_name like 'J%';
 
-- 4. List the product name, product price and product price after 10% discount.
 
select product_name,product_price,cast((product_price - product_price*0.1) as numeric )   discount_price 
from product;
 
-- 5. List the number of products with a price higher than $100.  
 
select count(*) no_of_products_more_than_100_dollars
from product 
where cast(product_price as numeric)> 100.00;
 
-- 6. List name and price for all products that have been purchased
-- on order 1001. Use a subquery and IN to implement this query.
 
select product_name , product_price 
from product
where product_id in 
(select product_id
from order_line 
where  order_id  = 1001);
 
-- 7.  List the order id and the order date for each order from an Arizona customer.  
--Sort the result by the date descending.
 
select order_id,order_date
from order_header 
where customer_id in (
    select customer_id 
    from customer 
    where upper(state_province) in ('AZ','ARIZONA')
)
order by order_date desc;
 
 
-----challenge excercise 1:------
 
--Select all rows from the customer table, but add a column called is_vip_customer where 1 
--indicates customers who have placed at least 10 orders and 0 indicates customers who have 
--placed 9 or less orders (Note: VIP = Very Important Person).  The result should have those who 
--are VIP customers first, then those are not VIP.  Within these two groups, sort by state/province 
--ascending, then city ascending.
 
ALTER TABLE customer 
ADD is_vip_customer integer; 
 
update customer set is_vip_customer=1 where customer_id in 
(
select p.customer_id from customer q inner join order_header p on q.customer_id =p.customer_id 
group by p.customer_id 
having (count(p.order_id)>=10)
)
 
update customer set is_vip_customer=0 where customer_id in 
(
select p.customer_id from customer q inner join order_header p on q.customer_id =p.customer_id 
group by p.customer_id 
having (count(p.order_id)<10)
) 
 
select * from customer order by is_vip_customer desc,state_province asc,city asc;
 
 
-- List the order id, date and total dollar amount for the top 10 orders by dollar amount.  
----Sort the result by the date ascending and then the total amount descending. 
--(hint: you will need to join tables to get product price and quantity)
 
 
select p.order_id, p.order_date, (ol.quantity*pr.product_price)as total_amount
from order_header p inner join order_line ol
on p.order_id =ol.order_id 
join product pr 
on ol.product_id =pr.product_id
order by p.order_date, total_amount desc
limit 10;
 
 
-----Challenge excercise 2:------
 
----1.    Remove the customer "Pavia Vanyutin" from the database.
delete from order_line where order_id in (select order_id from order_header where customer_id in (select customer_id from customer where customer_name ='Pavia Vanyutin'));
delete from order_header where customer_id in (select customer_id from customer where customer_name='Pavia Vanyutin');
delete from customer where customer_name ='Pavia Vanyutin';
 
----2.    Remove the customer "Rania Kyne" from the database using only three
 
delete from order_line where order_id in (select order_id from order_header where customer_id in (select customer_id from customer where customer_name ='Rania Kyne'));
delete from order_header where customer_id in (select customer_id from customer where customer_name='Rania Kyne');
delete from customer where customer_name ='Rania Kyne';
 
----3. Delete the customer "Allistir Rickett" from the customer table,
---followed by their order header records, followed by their order line records
 
delete from order_line where order_id in (select order_id from order_header where customer_id in (select customer_id from customer where customer_name ='Allistir Rickett'));
delete from order_header where customer_id in (select customer_id from customer where customer_name='Allistir Rickett');
delete from customer where customer_name ='Allistir Rickett';
 
---4. Re-add any constraints that were dropped in order to meet the requirements for step 1
---No constraints were dropped. 
 
 
 
 
 
 


