ote: this question is probably more complex than the kind you would encounter in an interview. Consider it a challenge problem, or feel free to skip it!

Context: Say I have a table table in the following form, where a user can be mapped to multiple values of class:
| user | class |
|------|-------|
| 1    | a     |
| 1    | b     |
| 1    | b     |
| 2    | b     |
| 3    | a     |
Task: Assume there are only two possible values for class. Write a query to count the number of users in each class such that any user who has label a and b gets sorted into b, any user with just a gets sorted into a and any user with just b gets into b.

For table that would result in the following table:
| class | count |
|-------|-------|
| a     | 1     |
| b     | 2     |

CREATE TABLE "table_class"
("user_id" INT,
"class" VARCHAR(1));

INSERT INTO "table_class"
VALUES (1,'b'),
(2,'a'),
(3,'a'),
(4,'b'),
(5, 'a'),
(3, 'b'),
(1, 'a'),
(2, 'a'),
(7, 'b'),
(19, 'a'),
(16,'b'),
(14,'a'),
(11,'a'),
(13,'b'),
(12, 'a'),
(12, 'b'),
(9, 'a'),
(8, 'a'),
(14, 'b'),
(3, 'a')
;
select *
from table_class
order by user_id,class;

with sub as (select user_id user_id, class class1, lead(user_id,1) over (order by user_id) as lead, lag(user_id,1) over(order by user) lag
from table_class),

sub1 as (select user_id user_id, class1 class2, case when user_id =lead and lag is null then 'multiple_class'  when user_id =lead and user_id=lag then 'multiple_class' when user_id != lead and user_id = lag then 'multiple_class' when lead is null and user_id!=lag then 'single_class' when user_id = lead and user_id != lag then 'multiple_class'else 'single_class' end as class_type
from sub)

select user_id user_id,case when class_type ='single_class' then class2 else 'b' end as sorted_class
from sub1
group by user_id,sorted_class

select sorted_class class3, count(user_id)
from sub2
group by 1



with sub as (select *
from table_class tc1
join table_class tc2
on tc1.user_id=tc2.user_id
group by tc1.user_id,tc1.class,tc2.user_id,tc2.class
order by tc1.user_id,tc1.class,tc2.user_id,tc2.class)
select case when;




