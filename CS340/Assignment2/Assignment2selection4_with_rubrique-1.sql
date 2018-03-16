#1 Find all films with maximum length or minimum rental duration (compared to all other films). 
#In other words let L be the maximum film length, and let R be the minimum rental duration in the table film. You need to find all films that have length L or duration R or both length L and duration R.
#You just need to return attribute film id for this query. 


SELECT film_id FROM film 
WHERE rental_duration = (SELECT MIN(rental_duration) FROM film)
OR length = (SELECT MAX(length) FROM film);


-- RUBRIQUE
-- All films with maximum length returned = 5
-- All films with minimum rental duration returned = 5
-- Total = 10

-- For every required attribute not present in the results, deduct 10
-- For any number of extra attributes present in the results, deduct 3

#2 We want to find out how many of each category of film ED CHASE has started in so return a table with category.name and the count
#of the number of films that ED was in which were in that category order by the category name ascending (Your query should return every category even if ED has been in no films in that category).


SELECT 
    category.name AS 'category name',
    IFNULL(count(actor.actor_id), 0) AS count
FROM category
LEFT JOIN
	film_category ON film_category.category_id = category.category_id
LEFT JOIN
	film_actor ON film_actor.film_id = film_category.film_id
LEFT JOIN
   	actor ON actor.actor_id = film_actor.actor_id
    	AND actor.first_name = 'ED'
    	AND actor.last_name = 'CHASE'
GROUP BY category.category_id
ORDER BY category.name ASC;


-- RUBRIQUE
-- All categories & correct count for them returned = 10
-- Any category is missing or count is incorrect = -10

-- For every required attribute not present in the results, deduct 10
-- For any number of extra attributes present in the results, deduct 3

#3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
#That is the result should list the names of all of the actors(even if an actor has not been in any Sci-Fi films)and the total length of Sci-Fi films they have been in.

SELECT first_name, last_name, IFNULL(sum(scifi_films.length), 0) AS length
FROM actor
LEFT JOIN
	film_actor ON film_actor.actor_id = actor.actor_id
LEFT JOIN
	(SELECT f.film_id, f.length FROM film f
	LEFT JOIN film_category ON film_category.film_id = f.film_id
	LEFT JOIN category ON category.category_id = film_category.category_id
	WHERE category.name = 'Sci-Fi') scifi_films ON scifi_films.film_id = film_actor.film_id
GROUP BY actor.actor_id
ORDER BY actor.first_name ASC;

-- RUBRIQUE 
-- All actors and correct count listed = 10
-- Any actor is missing = -5
-- A count is wrong = -5 

-- For every required attribute not present in the results, deduct 10
-- For any number of extra attributes present in the results, deduct 3

#4 Find the first name and last name of all actors who have never been in a Sci-Fi film
-- RUBRIQUE 
-- All actors who have NOT been in sci-fi films returned = 10 
-- Any missing actor = -5
-- Any actor who HAS been in SCI-fi film returned = -10

SELECT DISTINCT first_name, last_name
FROM actor
WHERE actor.actor_id NOT IN (
	SELECT actor.actor_id FROM actor
	INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
	INNER JOIN film ON film.film_id = film_actor.film_id
	INNER JOIN film_category ON film_category.film_id = film.film_id
	INNER JOIN category ON category.category_id = film_category.category_id
	WHERE category.name = 'Sci-Fi'
);

-- For every required attribute not present in the results, deduct 10
-- For any number of extra attributes present in the results, deduct 3

#5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies

SELECT DISTINCT title FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
INNER JOIN actor ON actor.actor_id = film_actor.actor_id
	AND ( (actor.first_name = 'Kirsten' AND actor.last_name = 'Paltrow') OR (actor.first_name = 'WARREN' AND actor.last_name = 'NOLTE') )
ORDER BY film.title DESC;

-- RUBRIQUE
-- All films featuring both KIRSTEN and WARREN returned in DESCENDING ORDER of TITLE = 10
-- Wrong Order = -5
-- Any missing film = -10

-- For every required attribute not present in the results, deduct 10
-- For any number of extra attributes present in the results, deduct 3
