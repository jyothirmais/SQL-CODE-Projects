

Retained Users Per Month
Context: Say we have login data in the table logins:
| user_id | date       |
|---------|------------|
| 1       | 2018-07-01 |
| 234     | 2018-07-02 |
| 3       | 2018-07-02 |
| 1       | 2018-07-02 |
| ...     | ...        |
| 234     | 2018-10-04 |

CREATE TABLE "login_users1"
(  "customer_id"    int,
  "date_login" date);

INSERT INTO "login_users1"
VALUES (1,'2018-07-01'),
(2,'2018-02-02'),
(1,'2018-02-02'),
(2,'2018-03-03'),
(2, '2018-05-05'),
(3, '2018-02-02'),
(4, '2018-01-01'),
(5, '2018-01-01'),
(6, '2018-01-01'),
(7, '2018-01-01'),
(3,'2018-03-03'),
(4,'2018-02-02'),
(6,'2018-05-05'),
(2,'2018-08-08'),
(9, '2018-03-03'),
(8, '2018-01-01'),
(9, '2018-04-04'),
(10, '2018-01-01'),
(11, '2018-01-01'),
(12, '2018-01-01')
;
select * from login_users1
order by 1,2

Task 1: Write a query that gets the number of retained users per month. In this case, retention for a given month is defined as the number of users who logged in that month who also logged in the immediately previous month.



with sub as (select login1.customer_id,login1.date_login,login2.date_login
from login_users1 as login1
join login_users1 as login2
on login1.customer_id = login2.customer_id and extract(month from login2.date_login) =  extract(month from login1.date_login) +  1
order by 1,2)

select count(customer_id)
from sub;



Task 2: Now we’ll take retention and turn it on its head: Write a query to find many users last month did not come back this month. i.e. the number of churned users.

with sub as (select login1.customer_id customer_id,login1.date_login,login2.date_login
from login_users1 as login1
join login_users1 as login2
on login1.customer_id = login2.customer_id and extract(month from login2.date_login) !=  extract(month from login1.date_login) +  1 
and extract(month from login1.date_login) !=  extract(month from login2.date_login) +  1 and extract(month from login2.date_login) !=  extract(month from login1.date_login) 
group by 1
order by 1)

select count(customer_id)
from sub




Context: You now want to see the number of active users this month who have been reactivated — in other words, users who have churned but this month they became active again. Keep in mind a user can reactivate after churning before the previous month. An example of this could be a user active in February (appears in logins), no activity in March and April, but then active again in May (appears in logins), so they count as a reactivated user for May .

Task 3: Create a table that contains the number of reactivated users per month.

with sub as (select login1.user_id,login1.date_login,login2.date_login
from login as login1
join login as login2
on login1.user_id = login2.user_id and login2.date_login >= interval of'30 days' +
order by 1,2)

select count(user_id)
from sub
group by user_id




