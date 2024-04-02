WITH X as (SELECT m.film_id, m.title, string_agg(mc.company_id::text, ',') as company_id,string_agg(c.name, ',') as company_names
from movie as m
JOIN movie_company as mc
ON m.film_id = mc.film_id
JOIN company as c
ON mc.company_id = c.company_id
GROUP BY m.film_id
)
SELECT X.film_id, X.company_names
FROM X
WHERE X.company_names LIKE '%Pixar%'

-- Find out all movies of TOM CRUISE where the rating of the movie is above 7

-- We first find Tom cruise ID number in the DB
SELECT person_id, name from crew_credit
WHERE name LIKE '%Tom Cru%'

--USING CTE we created a movies table having rating more than 7 and then an actor TABLE containg 
--all TOM Cruise's movies.
WITH movies as (
	SELECT film_id, title, rating
	FROM movie
	WHERE rating > 7.0
),
actor as (
	SELECT film_id, person_id, name
	FROM crew_credit
	WHERE person_id = 500
)
SELECT movies.film_id, actor.person_id, actor.name, movies.title, movies.rating 
FROM movies
JOIN actor 
ON movies.film_id = actor.film_id
