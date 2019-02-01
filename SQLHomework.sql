USE sakila;

SELECT * FROM actor;

# 1A
SELECT first_name, last_name FROM actor;

# 1B
ALTER TABLE actor
ADD actor_name VARCHAR(40);

UPDATE actor
SET actor_name = CONCAT(first_name, ' ', last_name);

# 2A
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

# 2B
SELECT * FROM actor 
WHERE last_name LIKE '%gen%';

# 2C
SELECT * FROM actor 
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

# 2D
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

# 3A
ALTER TABLE actor
ADD description BLOB;

# 3B
ALTER TABLE actor
DROP COLUMN description;

# 4A
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
ORDER BY last_name;

# 4B
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1
;

# 5A
SHOW CREATE TABLE address;

# 6A
SELECT first_name, last_name, address
FROM staff
     LEFT JOIN
     address 
     ON staff.address_id = address.address_id
;

# 6B
SELECT * 
FROM 
(
	SELECT staff_id, first_name, last_name
	FROM staff
) AS X
INNER JOIN 
(    
	SELECT SUM(amount), staff_id
	FROM payment
	WHERE payment_date LIKE '2005-08%'
	GROUP BY staff_id
) as Y ON X.staff_id = Y.staff_id
;

# 6C
SELECT film_actor.film_id, title, COUNT(actor_id) AS total_actors
FROM film_actor
     INNER JOIN
     film 
     ON film_actor.film_id = film.film_id
GROUP BY film_id
;

# 6D
SELECT COUNT(inventory_id) FROM inventory
WHERE film_id IN (
	SELECT film.film_id 
	FROM film
	WHERE title = 'Hunchback Impossible'
);

# 6E
SELECT * FROM customer
WHERE customer_id IN 
(
	SELECT SUM(amount), customer_id
	FROM payment
	GROUP BY customer_id
);


# 7A
SELECT * FROM film 
WHERE (title LIKE 'k%' OR title LIKE 'Q%') AND (language_id = 1);

SELECT * FROM actor;

# 7B
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
	WHERE film_id IN (
		SELECT film.film_id 
		FROM film
		WHERE title = 'Alone Trip'
	)
);



# 7C
SELECT first_name, last_name, email
WHERE country_id = 20 IN (
	SELECT * FROM city
	INNER JOIN (
		SELECT * FROM address
		INNER JOIN
			(
			SELECT first_name, last_name, email, customer.address_id
			FROM customer
		) as a ON a.address_id = address.address_id) as b ON a.address_id = b.address_id
);


# 7D
SELECT film_id, title FROM film
WHERE film_id IN (
	SELECT film_id FROM film_category
	WHERE category_id = 8
);


# 7G
SELECT * FROM address
WHERE (address_id = 1 OR address_id =2) 
LEFT JOIN 
    city
    );