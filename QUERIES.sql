/* SQL script to run test queries on and retrieve test data from the database. */

/* Query 1: UNION
Retrieve the full names of all people (customers and staff) involved in a sale on 4/7/2018. */
SELECT first_name, last_name FROM CUSTOMER
WHERE customer_id IN (SELECT customer_id
			 FROM SALE
			 WHERE date_ = '2018-04-11')
UNION
SELECT first_name, last_name FROM STAFF
WHERE staff_id IN (SELECT staff_id
				   FROM SALE
				   WHERE date_ = '2018-04-11');

/* Query 2: INTERSECT
Retrieve the VIN of all cars that have been in an accident AND have a warranty. */
SELECT vin FROM ACCIDENT_REPORT
INTERSECT
SELECT vin FROM WARRANTY;

/* Query 3: EXCEPT
Retrieve the VIN of all cars that have a warranty, but have not been in an accident. */
SELECT vin FROM WARRANTY
EXCEPT
SELECT vin FROM ACCIDENT_REPORT;


/* Query 4: DIVISION
Retrieve the full name of customer(s) who have bought every car from David Zucco. */
SELECT first_name, last_name FROM CUSTOMER AS c
WHERE NOT EXISTS (
	SELECT customer_id, staff_id FROM SALE
	WHERE customer_id = c.customer_id
	AND NOT staff_id IN (
		SELECT staff_id FROM STAFF as s
		WHERE s.first_name = 'David'
		AND s.last_name = 'Zucco') );

/* Query 5: AGGREGATE FUNCTION COUNT
Retrieve the average price of all sales made by salesman Joe Simons. */
SELECT AVG(price) AS average
FROM SALE
WHERE staff_id = 2;

/* Query 6: MULTIPLE JOINS
Retrieve first names of all customers and their salesman, as well as the color of the car sold. */
SELECT c.first_name, s.first_name, car.color
FROM SALE AS sale
JOIN CAR car ON sale.vin = car.vin
JOIN CUSTOMER c ON sale.customer_id = c.customer_id
JOIN STAFF s ON sale.staff_id = s.staff_id;