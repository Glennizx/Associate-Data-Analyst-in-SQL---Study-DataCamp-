/* Exercise 1
1.Use NOW() to select the current timestamp with timezone.
2.Select the current date without any time value.
3.Now, let's use the CAST() function to eliminate the timezone from the current timestamp.
4. Finally, let's select the current date.
Use CAST() to retrieve the same result from the NOW() function.
*/

SELECT 
	-- Select the current date
	CURRENT_DATE,
    -- CAST the result of the NOW() function to a date
    CAST( NOW() AS date )


--Exercise 2: Select the current timestamp without timezone and alias it as right_now.

SELECT CURRENT_TIMESTAMP::timestamp AS right_now;

-- Exercise 3: Now select a timestamp five days from now and alias it as five_days_from_now.

SELECT
	CURRENT_TIMESTAMP::timestamp AS right_now,
    interval '5 days' + CURRENT_TIMESTAMP AS five_days_from_now;

-- Exercise 4: Finally, let's use a second-level precision with no fractional digits for both the right_now and five_days_from_now fields.
SELECT
	CURRENT_TIMESTAMP(0)::timestamp AS right_now,
    interval '5 days' + CURRENT_TIMESTAMP(0) AS five_days_from_now;


-- Exercise 5: Get the day of the week from the rental_date column.

SELECT 
  -- Extract day of week from rental_date
  EXTRACT(dow FROM rental_date) AS dayofweek 
FROM rental 
LIMIT 100;


-- Exercise 6: Count the total number of rentals by day of the week.
-- Extract day of week from rental_date
SELECT 
  EXTRACT(dow FROM rental_date) AS dayofweek, 
  -- Count the number of rentals
  COUNT(rental_id) as rentals 
FROM rental 
GROUP BY 1;


-- Exercise 7: Truncate the rental_date field by year.
SELECT DATE_TRUNC('year', rental_date) AS rental_year
FROM rental;


-- Exercise 8: Now modify the previous query to truncate the rental_date by month.
SELECT DATE_TRUNC('month', rental_date) AS rental_month
FROM rental;

-- Exercie 9: Let's see what happens when we truncate by day of the month.
SELECT DATE_TRUNC('day', rental_date) AS rental_day 
FROM rental;


-- Exercise 10: Count the total number of rentals by rental_day and alias it as rentals

SELECT 
  DATE_TRUNC('day', rental_date) AS rental_day,
  -- Count total number of rentals 
  COUNT(rental_day) AS rentals 
FROM rental
GROUP BY 1;

-- Exercise 11: Extract the day of the week from the rental_date column using the alias dayofweek.
-- Use an INTERVAL in the WHERE clause to select records for the 90 day period starting on 5/1/2005.
SELECT 
  -- Extract the day of week date part from the rental_date
  EXTRACT(dow FROM rental_date) AS dayofweek,
  AGE(return_date, rental_date) AS rental_days
FROM rental AS r 
WHERE 
  -- Use an INTERVAL for the upper bound of the rental_date 
  rental_date BETWEEN CAST('2005-05-01' AS DATE)
   AND CAST('2005-05-01' AS DATE) + INTERVAL '90 day';



-- Exercise 12:  Finally, use a CASE statement and DATE_TRUNC() to create a
--  new column called past_due which will be TRUE if the rental_days is greater than the rental_duration otherwise, it will be FALSE
SELECT 
  c.first_name || ' ' || c.last_name AS customer_name,
  f.title,
  r.rental_date,
  EXTRACT(dow FROM r.rental_date) AS dayofweek,
  AGE(r.return_date, r.rental_date) AS rental_days,
  CASE WHEN DATE_TRUNC('day', AGE(r.return_date, r.rental_date)) > 
    f.rental_duration * INTERVAL '1' day 
  THEN TRUE 
  ELSE FALSE END AS past_due 
FROM 
  film AS f 
  INNER JOIN inventory AS i 
  	ON f.film_id = i.film_id 
  INNER JOIN rental AS r 
  	ON i.inventory_id = r.inventory_id 
  INNER JOIN customer AS c 
  	ON c.customer_id = r.customer_id 
WHERE 
  r.rental_date BETWEEN CAST('2005-05-01' AS DATE) 
  AND CAST('2005-05-01' AS DATE) + INTERVAL '90 day';


--Exercise 13: Concatenate the first_name and last_name columns
-- separated by a single space followed by email surrounded by < and >.
SELECT first_name || ' ' ||  last_name || ' <' || email || '>' AS full_email 
FROM customer

-- Exeercise 14: Now use the CONCAT() function to do the same operation as the previous step.
SELECT CONCAT(first_name, ' ', last_name,  ' <', email, '>') AS full_email 
FROM customer

