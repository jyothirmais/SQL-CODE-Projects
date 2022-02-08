CREATE TABLE "students" (
"id" SERIAL,
"name" TEXT,
"rank" INTEGER
);

---------------+---------------+---------------+-----------------------+
| customer_id   | order_id  | sales_usd | order_datetime    |
+---------------+---------------+---------------+-----------------------+
| 3362462944    | 4496      | 50.6      | 11/30/2021 16:10  |
| 9974574193    | 92589     | 27.81     | 11/30/2021 16:05  |
| 8434103670    | 80710     | 96.6      | 11/30/2021 16:18  |
| 1735736329    | 32524     | 29.36     | 11/30/2021 16:20  |
| 7162944850    | 74378     | 11.16     | 11/30/2021 18:16  |
| 4076426500    | 47201     | 53.55     | 11/30/2021 16:20  |
| 8434103670    | 50015     | 73.9      | 11/30/2021 18:08  |
| 1735736329    | 81255     | 80.75     | 11/30/2021 20:18  |
| 7162944850    | 98671     | 95.75     | 11/30/2021 17:08  |
+---------------+---------------+---------------+-----------------------+
--Write a query that will count the number of unique customers and the average sales
                        --amount in November 2021 (01 Nov - 30 Nov 2021).


select count(distinct cutomer_id),avg(sales_usd)
from sub
where order_datetime between '2021-11-01' and '2021-11-30'


-- Write a query that will count the number of unique customers and the average of
                      --  customers average sales amount in November 2021 (01 Nov - 30 Nov 2021).

 with sub as (select customer_id,avg(sales_usd)customer_avg_sales
 from customer_orders
 group by customer_id
 orfdr by cutomer_id
 where order_datetime between '2021-11-01' and '2021-11-30')     

 select avg(customer_avg_sales)    
 from sub


--Write a query that will produce data used to populate a histogram that shows the
                        --how many unique orders customers have during the month of November 2021.
                        --Ensure the query provides the count of customers who had zero orders in Nov 2021.

select customer_id,count(order_id) count_unique_orders    
from customer_orders
group by customer_id
having order_id is 0 and order_id !=0
order by customer_id


--Identify the week-ending date within the last year that saw the largest change in
                        --the number of customers who ordered in that week versus the prior week.

with sub1 as (select date_part('week',order_datetime) ord_week,count(distinct cutomer_id) no_of_customers_that_week
from cutomer_orders
group by ord_week
order by ord_week
where order_datetime between '2021-01-01' to '2022-01-01'),
-- gett
sub2 as (select ord_week,no_of_customers_that_week,lag(no_of_customers,1) over(order by ord_week) no_of_customers_prior_week
from sub)

select ord_week,max(abs(no_of_customers_that_week-no_of_customers_prior_week)) max_change_no_of_customers
from sub2
