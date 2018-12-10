
-- 1a. display the first and last name of all actors from the table 'actor'.
use sakila; 
select frist_name, last_name  
from actor; 

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
select upper(concat(first_name,'', last_name)) as 'Actor Name'
from actor; 

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, firt_name, last_name
from actor 
where first_name = "Joe"

-- 2b.  Find all actors whose last name contain the letters `GEN`

select actor_id, first_name, last_name 
from actor
where last_name like 'gen'; 

-- 2c. Find all actors whose last names contain the letters `LI`. 
--     This time, order the rows by last name and first name, in that order:
select actor_id, last_name, first_name
from actor 
where last_name like "LI"; 

-- 2d. Using `IN`, display the `country_id` and `country` columns of 
--     the following countries: Afghanistan, Bangladesh, and China

select country_id, country 
from country 
where country IN 
('Afganistan',
'Bangladesh',
'China',
); 

-- 3a. You want to keep a description of each actor. 
-- You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB 
-- (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
alter table actor
add column middle_name varchar(25) after first_name; 

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
-- Delete the description column.

alter table actor
modify column middle_name to BLOB; 

alter table actor
drop column middle_name; 


-- 4a. List the last names of actors, as well as how many actors have that last name
select last_name, count(*) as 'number of actors'
from actor group by last_name; 

-- 4b. List last names of actors and the number of actors who have that last name, 
--     but only for names that are shared by at least two actors
select last_name, count(*) as "number of actors"
from actor group by last_name having count(*) >=2; 

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
-- Write a query to fix the record.

update actor 
set first_name = 'harpo'
where first_name = 'groucho' and last_name ='willimas';

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. 
-- It turns out that GROUCHO was the correct name after all!
--  In a single query, if the first name of the actor is currently HARPO, 
-- change it to GROUCHO.
update actor 
set first_name ='GROUCHO'
where actor_id = 172; 

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
describe sakila.address; 
 -- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. 
 -- Use the tables staff and address:

select s.first_name, s.last_name, a.address, c.city, co.country
from staff as s 
left join address as a 
on s.address_id = a.address_id
left join city as c
on a.city_id = c.city_id
left join country as co
on c.country_id = co.country_id 

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
select * from payment; 
select * from staff; 
select s.staff_id, s.first_name, s.last_name, SUM(p.amount) as total_sales 
from payment as p 
inner join staff as s
on p. staff_id = s.staff_id 
where payment date between "20050801" and "20050901"
group by s.staff_id;

-- 6c. List each film and the number of actors who are listed for that film. 
-- Use tables film_actor and film. Use inner join. 
select * from film_actor;
select * from film;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select f.title, count(f.title) as num from film as f
innier join inventory as i
on f.film_id = i.film_id
where f.title = 'hunchback impossible'
group by f.title; 

-- 6e. Using the tables payment and customer and the JOIN command,
--  list the total paid by each customer. List the customers alphabetically by last name
select * from payment; 
select * from customer; 
select c.first_name, c.last_name, sum(p.amount) as total_paid from payment as p 
inner join customer as c
on p.customer_id = c.customer_id 
group by c.first_name, c.last_name 
order by c.last_name, c.first_name 

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
-- As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

select * from language; 
select title from film 
where title like"Q" or title like "K"
	and language_id = ( 
		select language_id from language 
        where name = "English"); 
        
-- 7b - Use subqueries to display all actors who appear in the film Alone Trip.

select * from actor; 
select first_name ; last_name from actor 
where actor_id IN( 
	select actor_id from film_actor 
    where film_id = (
    select film_id from film
    where title = "Alone Trip")); 
    
-- 7e. Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(f.title) AS rent_count

FROM rental AS r

INNER JOIN inventory AS i

    ON r.inventory_id = i.inventory_id

INNER JOIN film AS f

    ON i.film_id = f.film_id

GROUP BY f.title

ORDER BY rent_count DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT a.address, cy.city, co.country, SUM(p.amount) AS total_revenue

FROM store AS s

INNER JOIN address AS a

    ON s.address_id = a.address_id

INNER JOIN customer AS c

    ON s.store_id=c.store_id

INNER JOIN payment AS p

    ON p.customer_id = c.customer_id

INNER JOIN city AS cy

    ON cy.city_id = a.city_id

INNER JOIN country AS co

    ON co.country_id = cy.country_id

GROUP BY a.address, cy.city, co.country;

-- 7g. Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, a.address, cy.city, co.country

FROM store AS s

INNER JOIN address AS a

    ON s.address_id = a.address_id

INNER JOIN city AS cy

    ON cy.city_id = a.city_id

INNER JOIN country AS co

    ON co.country_id = cy.country_id;

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT c.name, SUM(p.amount) AS gross_revenue

FROM category AS c

INNER JOIN film_category AS fc

    ON c.category_id = fc.category_id

INNER JOIN inventory AS i

    ON fc.film_id = i.film_id

INNER JOIN rental AS r

    ON i.inventory_id = r.inventory_id

INNER JOIN payment AS p

    ON r.rental_id = p.rental_id

GROUP BY name

ORDER BY gross_revenue DESC

LIMIT 5;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

CREATE VIEW top5_genre_gross_revenue AS

SELECT c.name, SUM(p.amount) AS gross_revenue

FROM category AS c

INNER JOIN film_category AS fc

    ON c.category_id = fc.category_id

INNER JOIN inventory AS i

    ON fc.film_id = i.film_id

INNER JOIN rental AS r

    ON i.inventory_id = r.inventory_id

INNER JOIN payment AS p

    ON r.rental_id = p.rental_id

GROUP BY name

ORDER BY gross_revenue DESC

LIMIT 5;

-- 8b. How would you display the view that you created in 8a?

SELECT * FROM top5_genre_gross_revenue;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

DROP VIEW IF EXISTS top5_genre_gross_revenue;

 





