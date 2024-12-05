show databases;
show tables;
desc actor;
show create table actor;
desc staff;
desc film;
desc category;
desc inventory;
desc payment;
desc rental;
desc store;
desc city;
desc customer;

select f.title as filmname,
    sum(p.amount)
    from payment p
    join rental r on p.rental_id= r. rental_id
    join inventory i on r. inventory_id= i.inventory_id
    join film f on i.film_id= f.film_id
    group by f.film_id;

use sakila;
--     
select concat_ws("",a.first_name, a.last_name) as ActorName,
    sum(p.amount) as total_rent
from 
    payment p
    join rental r on p.rental_id= r. rental_id
    join inventory i on r. inventory_id= i.inventory_id
    join film f on i.film_id= f.film_id
    join film_actor fa on f.film_id= fa.film_id
    join actor a on fa.actor_id= a.actor_id
 group by a.actor_id
 order by total_rent desc;
 
 -- find total no of times each film was rented.
 select f.title as filmname,
    count(r.rental_id)
    from 
    rental r
    join inventory i on r. inventory_id= i.inventory_id
    join film f on i.film_id= f.film_id
group by f.film_id;

 -- find the films which earned more then 
 -- average per-film rental and show their title and total rent.
 
 select f.title, sum(p.amount) as total_rent
    from payment p
        join rental r on p.rental_id = r.rental_id
        join inventory i on r.inventory_id = i.inventory_id
        join film f on i.film_id = f.film_id
      group by f.title
        having total_rent > 
        (
        select avg(total_rent) from
          (select f.title, sum(p.amount) as total_rent
            from payment p
              join rental r on p.rental_id = r.rental_id
              join inventory i on r. inventory_id = i.inventory_id
              join film f on i.film_id = f.film_id
              group by f.title) as avg_rent
         );     
        
 
-- which customer spent the maximum amount at the stores in total and how much?
  -- step1: find the total amount spent by each customer
  
 create view per_customer_tots as (select customer_id, sum(amount) as total
 from payment
 group by customer_id);
 
 drop table per_customer_tots;
 desc per_customer_tots;
 drop view per_customer_tots;
 
 
 select * from per_customer_tots;
 
   -- step2: find max of these per_customer_tots, aggregate function
 select max(total) from per_customer_tots;
 
 
   -- step3: find the customer having maximun total stends, filtering
select customer_id
from per_customer_tots
where total = (select max(total) from
                per_customer_tots);
               
-- iv) find the customer's name -> join

select concat(c.first_name, " ", c.last_name) from
customer c
join
(select customer_id
from per_customer_tots
where total = (select max(total) from
                per_customer_tots)) t2
               on c.customer_id = t2.customer_id ;






