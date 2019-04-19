#1
use sakila;
SELECT first_name, last_name FROM actor;
  
use sakila;
select concat(first_name, ' ', last_name) AS "Actor Name" FROM actor;

#2
use sakila;
SELECT * FROM actor WHERE first_name = "Joe";
ALTER TABLE actor DROP column last_update;

use sakila;
SELECT * FROM actor WHERE 
last_name LIKE "%GEN%";

use sakila;
SELECT * FROM actor WHERE 
last_name LIKE "%LI%";

use sakila;
SELECT country_id,country FROM country WHERE country in ("Afghanistan", "Bangladesh", "China");

#3
alter table actor
 ADD column description blob(25);

ALTER TABLE actor
DROP description;

#4
SELECT last_name, COUNT(*) AS 'Number of Actors' 
FROM actor GROUP BY last_name;

SELECT last_name, COUNT(*) AS 'Number of Actors' 
FROM actor GROUP BY last_name Having count(*)>2;

SELECT * FROM actor WHERE 
first_name LIKE "%Har%";

UPDATE actor
SET 
    first_name = 'Harpo'
WHERE
    first_name = 'GROUCHO' AND last_name = 'Williams';
    
UPDATE actor 
SET first_name = 'GROUCHO'
WHERE actor_id = 172;

#5[https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html]



#6
SELECT first_name, last_name, address
FROM  staff 
JOIN  address
ON staff.address_id =  address.address_id;

SELECT payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date 
From staff
Join payment
On payment_id = payment_id
AND payment_date LIKE '2005-08%'; 

SELECT f.title AS 'Film Title', COUNT(fa.actor_id) AS `Number of Actors`
FROM film_actor fa
INNER JOIN film f 
ON fa.film_id= f.film_id
GROUP BY f.title;

SELECT title, (
SELECT COUNT(*) FROM inventory
WHERE film.film_id = inventory.film_id
) AS 'Number of Copies'
FROM film
WHERE title = "Hunchback Impossible";

SELECT  c.first_name, c.last_name, sum(p.amount) As 'total amount'
From customer c
Join payment p
On c.customer_id = p.customer_id
group by c.last_name;


#7
SELECT title 
From film 
where title like "K%" or "Q%"
AND title in
(
SELECT language_id  
FROM film 
WHERE language_id = 1
);


SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
Select actor_id
FROM film_actor
WHERE film_id IN 
(
SELECT film_id
FROM film
WHERE title = 'Alone Trip'
));


SELECT cus.first_name, cus.last_name, cus.email 
FROM customer cus
JOIN address a 
ON (cus.address_id = a.address_id)
JOIN city ct
ON (ct.city_id = a.city_id)
JOIN country cou
ON (cou.country_id = ct.country_id)
WHERE cou.country= "Canada";



SELECT title, description 
from film
where film_id in
(
select film_id 
from film_category
where category_id in
(select category_id 
from category 
where name = "family"
));


SELECT f.title, COUNT(rental_id) AS "Most Frequently Rented"
FROM rental r
JOIN inventory i
ON (r.inventory_id = i.inventory_id)
JOIN film f
ON (i.film_id = f.film_id)
GROUP BY f.title
ORDER BY "Most Frequently Rented" DESC;

select s.store_id, sum(amount) AS "Revenue"
from rental r
Join payment p
on r.rental_id = p.rental_id
JOIN inventory i
ON i.inventory_id = r.inventory_id
JOIN store s
ON s.store_id = i.store_id
GROUP BY s.store_id; 

#8
CREATE VIEW genre_revenue AS
SELECT c.name AS "Genre", SUM(amount) AS "Gross"
FROM category c
JOIN film_category;

select * from genre_revenue; 

Drop View genre_revenue; 
 