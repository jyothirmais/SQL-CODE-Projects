What is the Query to Find 2nd Highest Salary of Employee?
Employee_num    Employee_name   Department  Salary
1   Amit    OBIEE   680000
2   Rohan   OBIEE   550000
3   Rohit   OBIEE   430000



create table "employee1"
    ("employee_num" int,
    "employee_name" varchar(20),
    "department" varchar(5),
    "salary" int)


insert into "employee1" values (1, 'rahul', 'OBIEE','680000'),
    (2, 'rohit', 'OBIEE','550000'),
    (3, 'rohan', 'OBIEE','430000'),
    (4,   'Arya',    'OBIEE','760000'),
(5,   'Aari',    'OBIEE','650000'),
(6,   'Ishu',    'OBIEE','720000'),
(7,   'jyothi',  'OBIEE','910000'),
(8,   'mahi',    'OBIEE','900000');

with sub as (select employee_num e_num,employee_name e_nam,department e_dep,salary sal
from employee1
order by salary desc
limit 2)

select case when s1.sal>s2.sal then s2.sal end as second_highest_salary
from sub s1
join sub s2
on s1.e_dep=s2.e_dep;


