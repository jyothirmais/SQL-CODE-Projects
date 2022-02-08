





Table Name : EMPLOYEE
Columns : Employee_ID, Name, Manager_Employee_ID, Department, Salary

|-------------------|-------|-------------------|----------|--------|
|Employee_ID        |Name   |Manager_employee_ID|Department|Salary  |
|-------------------|-------|-------------------|--------  |--------|
| 20                |John   | 3                 | IT       |$120,000|
| 23                |Sam    | 3                 | IT       |$80,000 |
| 25                |Suzie  | 3                 | IT       |$80,000 |
| 12                |Kate   | 4                 | QA       |$92,000 |
| 3                 |Bob    | 4                 | QA       |$320,000|
| 4                 |Ann    | 2                 | Sales    |$320,000|
| 12                |Matt   | 3                 | IT       |$85,000 |
| 15                |Kate   | 4                 | QA       |$78,000 |
| 11                |Will   | 4                 | QA       |$82,000 |
| 2                 |Jeff   |                   | Sales    |$540,000|
|-------------------|-------|-------------------|--------  |--------|

CREATE TABLE "table1"
(  "user"    int,
  "class"   varchar(1));

INSERT INTO "table1"
VALUES (3,'b'),
(1,'a'),
(1, 'a'),
(1,'b'),
(2, 'a'),
(2, 'b'),
(2, 'a'),
(3, 'a'),
(3, 'b'),
(4, 'a');
select *
from table1
order by user;

Q) Write a SQL Query to fetch the employees with second and third highest salaries. Try to not use TOP or LIMIT clause.
with sub as (select *, dense_rank() over (order by salary desc) highest_salaries
from employee)
select * from sub
where highest_salaries = 2 or highest_salaries = 3;

Q) Write a SQL Query to fetch the list of employees who do not manage anyone(Employee_ID, Name)


select employee_id,name
from employee1
where name not in (select e2.name manager_name
    from employee1 e1
    join employee1 e2
    on e1.manager_employee_id = e2.employee_id
    group by e2.name);




Q) Write a SQL Query to fetch Manager Name for all employees. (Employee_ID, Employee Name, Manager Name)
select e1.employye_id employee_id,e1.name employee_name,e2.name manager_name
from employee e1
    left join employee e2
    on e1.manager_employee_id = e2.employye_id

Q) Write a SQL Query to find the cases where employee is paid higher than manager. (Department, Employee Name)

select e1.department Deapartmnet,e1.name employee_name
from employee1 e1
    left join employee1 e2
    on e1.manager_employee_id = e2.employee_id
    where e2.name is not null and e1.salary>e2.salary
