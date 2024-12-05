create database employees;
use employees;
create table emp(
 id int primary key auto_increment,
 name varchar(100) not null,
 department_id int,
 salary int not null,
 foreign key(department_id) references department(id));
 
 desc emp;
 
insert into emp (name, department_id, salary)
values ('Alice','1','50000'), ('Bob','2','60000'), 
('Charlie','1','70000'), ('Diana','3','40000'), ('Ethan',NULL,'45000');
select * from emp;

create table department(
 id int primary key auto_increment,
 department_name varchar(100));
 
 desc department;
 
insert into department (department_name)
values ('HR'), ('IT'), 
('Sales'), ('Marketing');
select * from department;


-- sunquries
select name, salary  -- for that exprestion avg salary will come 53,000 then above avg salary will show output 'bob' and 'charlie' salary only
from emp
where salary > (
     select avg (salary)
     from emp
     );
     
     
 -- multi-row subquery  --list operator
 select name -- in which cell 1 , 2 department_id available that all emp name will come
 from emp                      -- output : Alice , Charlie, Bob
 where department_id in(
   select id
   from department
   where id in (1,2)
); 

-- multi-column subqury
select name   -- alice salary same salary compair with another emp salary wich is same as alice salary and same department emp name
from emp      -- but in our record same salary with same department not available 
where(department_id, salary) in (    -- output: alice
  select department_id, salary
  from emp
  where name = 'Alice'
);  
  
-- correlated subquery
-- who can earn salary more than avg salary of 1 department only 
-- then again it will go to 2nd department and output will come salary more than avg 2nd's department...  like that go on
SELECT name, salary
FROM emp e1
WHERE salary > (
    SELECT AVG(salary)
    FROM emp e2
    WHERE e2.department_id = e1.department_id
);  
 
 -- Non-correlated Subquery
 SELECT name, (  -- output: Alice=4, bob=4, Charlie=4, Diana=4, Ethen=4
    SELECT COUNT(*)  -- calculate the total no of departments
    FROM department
) AS total_department
FROM emp;


--  Using Subquery in FROM Clause
SELECT department_name, avg_salary  -- avg salary od department 1 is 50000+70000/2= 60000, 60000 is more than 50000 that y department id is for HR department
FROM (                             -- avg salary od department 2(only one emp) is 60000, 60000 is more than 50000 that y department id is for IT department
    SELECT d.department_name, AVG(e.salary) AS avg_salary  -- no another department avg salary is not more then 50,000
    FROM emp e                                             -- output: HR - 60,000 and IT- 60,000
    INNER JOIN department d
    ON e.department_id = d.id
    GROUP BY d.department_name
) AS department_avg
WHERE avg_salary > 50000;


-- joints check explaination in book
-- inner join
select e.name AS emp_name, d.department_name
from emp e
inner join department d
on e.department_id = d.id;

-- left join
select e.name AS emp_name, d.department_name
from emp e
left join department d
on e.department_id = d.id;

-- right join
select e.name AS emp_name, d.department_name
from emp e
right join department d
on e.department_id = d.id;

-- full outer join
select e.name AS emp_name, d.department_name
from emp e
left join department d
on e.department_id = d.id
union
select e.name AS emp_name, d.department_name
from emp e
right join department d
on e.department_id = d.id;


-- want all recorders with another table also
-- cross join
select e.name as emp_name, d.department_name
from emp e
cross join department d;

